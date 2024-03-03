import 'dart:io';
import 'dart:typed_data';

import 'package:bodobox/app/app.dialogs.dart';
import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/crypt_service.dart';
import 'package:bodobox/services/device_service.dart';
import 'package:bodobox/services/prefs_service.dart';
import 'package:bodobox/utils/enums.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:bodobox/utils/models/page_model.dart';
import 'package:bodobox/utils/models/server_callback_model.dart';
import 'package:bodobox/utils/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:stacked_services/stacked_services.dart';

class RequestService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final DialogService _dialogService = locator<DialogService>();
  static final DeviceService _deviceService = locator<DeviceService>();
  static final PrefsService _prefsService = locator<PrefsService>();
  static final CryptService _cryptService = locator<CryptService>();
  static final NavigationService _navigationService =
      locator<NavigationService>();

  // User Service

  Future<ServerCallBack> registerUser(BodoboxUser user) async {
    try {
      final createdUserAuthSystem =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);
      await _firebaseFirestore
          .collection("user")
          .doc(createdUserAuthSystem.user!.uid)
          .set({
        "name": user.name,
        "email": user.email,
        "devices-id-one": user.deviceOneId,
        "devices-id-two": "zero",
        "devices-name-one": user.deviceOneName,
        "devices-name-two": "zero",
        "owingBooks": [],
        "sharingBooks": false,
        "masterUser": false,
      });
      if (createdUserAuthSystem.user?.uid != null) {
        return ServerCallBack(
            status: true, string: createdUserAuthSystem.user!.uid);
      } else {
        return ServerCallBack(status: false, string: "");
      }
    } on FirebaseAuthException catch (error) {
      String errorCode = "Unbekannter Fehler";
      switch (error.code) {
        case "email-already-in-use":
          errorCode = "Diese E-Mail ist bereits einem Account zugeordnet.";
          break;
        case "invalid-email":
          errorCode = "Diese E-Mail kann nicht verwendet werden.";
          break;
        case "operation-not-allowed":
          errorCode = "Ein BackEnd Problem ist aufgetretten.";
          break;
        case "weak-password":
          errorCode = "Das Password ist zu schwach.";
          break;
      }
      await _dialogService.showCustomDialog(
          variant: DialogType.error, description: errorCode);
      return ServerCallBack(status: false, string: "");
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten $error");
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<ServerCallBack> signInUser(BodoboxUser user) async {
    try {
      final signedInUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);

      final fireStoreUser = await _firebaseFirestore
          .collection("user")
          .doc(signedInUser.user!.uid)
          .get();
      Map<String, dynamic> userData = fireStoreUser.data()!;
      final deviceIdOne = userData["devices-id-one"];
      final deviceIdTwo = userData["devices-id-two"];
      final currentDevice = await _deviceService.getDeviceImei();
      if (currentDevice == null)
        return ServerCallBack(status: false, string: "");
      if (deviceIdOne == currentDevice.imeiNumber ||
          deviceIdTwo == currentDevice.imeiNumber) {
        return ServerCallBack(status: true, string: fireStoreUser.id);
      } else {
        if (deviceIdTwo == "zero" || deviceIdOne == "zero") {
          if (deviceIdTwo == "zero") {
            await registerSecondDevice(
              fireStoreUser.id,
            );
          } else {
            await registerFirstDevice(
              fireStoreUser.id,
            );
          }
          return ServerCallBack(status: true, string: fireStoreUser.id);
        } else {
          await _dialogService.showCustomDialog(
              variant: DialogType.error,
              description:
                  "Du hast bereits die maximal anzahl an Geräten erreicht die mti deinem Account verbunden werden können.");
          return ServerCallBack(
              status: false,
              string:
                  "Du hast bereits die maximal anzahl an Geräten erreicht die mti deinem Account verbunden werden können.");
        }
      }
    } on FirebaseAuthException catch (error) {
      String errorCode = error.code;
      switch (error.code) {
        case "too-many-requests":
          errorCode = "Ein Fehler ist aufgetretten.";
          break;
        case "operation-not-allowed":
          errorCode = "Ein Fehler ist aufgetretten.";
          break;
      }
      await _dialogService.showCustomDialog(
          variant: DialogType.error, description: errorCode);
      return ServerCallBack(status: false, string: "");
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten $error");
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<BodoboxUser?> getUserData(String userId) async {
    try {
      print("hello");
      final userID = _prefsService.getUserId();
      if (userID == null) return null;
      final userRawData =
          await _firebaseFirestore.collection("user").doc(userID).get();
      if (userRawData.exists) {
        final userData = userRawData.data();
        if (userData != null) {
          return BodoboxUser(
              name: userData["name"],
              email: userData["email"],
              deviceOneId: userData["devices-id-one"],
              deviceTwoId: userData["devices-id-two"],
              deviceOneName: userData["devices-name-one"],
              deviceTwoName: userData["devices-name-two"],
              shareMode: userData["sharingBooks"],
              masterUser: userData["masterUser"],
              owningBooks: userData["owingBooks"],
              uid: userID);
        } else {
          return null;
        }
      } else {
        await logOut();
        await _dialogService.showCustomDialog(
            variant: DialogType.error,
            title: "Du wurdest ausgelogt.",
            description: "Dein BodoBox Account existiert nicht mehr.");
        return null;
      }
    } on FirebaseAuthException catch (error) {
      String errorCode = error.code;
      switch (error.code) {
        case "too-many-requests":
          errorCode = "Ein Fehler ist aufgetretten.";
          break;
        case "operation-not-allowed":
          errorCode = "Ein Fehler ist aufgetretten.";
          break;
      }
      await _dialogService.showCustomDialog(
          variant: DialogType.error, description: errorCode);
      return null;
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten $error");
      return null;
    }
  }

  Future<ServerCallBack> updateSharingMode(BodoboxUser user, bool mode) async {
    try {
      await _firebaseFirestore.collection("user").doc(user.uid).update({
        "sharingBooks": mode,
      });
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten $error");
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<ServerCallBack> updateName(BodoboxUser user, String name) async {
    try {
      await _firebaseFirestore.collection("user").doc(user.uid).update({
        "name": name,
      });
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten $error");
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<ServerCallBack> updatePassword(BodoboxUser user) async {
    try {
      if (user.email == null) return ServerCallBack(status: false, string: "");
      await _firebaseAuth.sendPasswordResetEmail(email: user.email!);
      return ServerCallBack(status: true, string: "");
    } on FirebaseAuthException catch (error) {
      String errorCode = error.code;
      switch (error.code) {
        case "too-many-requests":
          errorCode = "Ein Fehler ist aufgetretten.";
          break;
        case "operation-not-allowed":
          errorCode = "Ein Fehler ist aufgetretten.";
          break;
      }
      await _dialogService.showCustomDialog(
          variant: DialogType.error, description: errorCode);
      return ServerCallBack(status: false, string: "");
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten");
      return ServerCallBack(status: false, string: "$error");
    }
  }

  Future<void> logOut() async {
    await _prefsService.deletUserId();
    await _navigationService.clearStackAndShow(Routes.titleView);
  }
   
  Future<ServerCallBack> deleteUser(String userId) async {
     try {
      await _firebaseAuth.currentUser?.delete();
      await _firebaseFirestore.collection("user").doc(userId).delete();
      return ServerCallBack(status: true, string: "");
    } on FirebaseAuthException catch (error) {
      String errorCode = error.code;
      switch (error.code) {
        case "too-many-requests":
          errorCode = "Ein Fehler ist aufgetretten.";
          break;
        case "operation-not-allowed":
          errorCode = "Ein Fehler ist aufgetretten.";
          break;
      }
      await _dialogService.showCustomDialog(
          variant: DialogType.error, description: errorCode);
      return ServerCallBack(status: false, string: "");
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten");
      return ServerCallBack(status: false, string: "$error");
    }
  }
  // Household Service

  Future<String?> getHousHoldIpAdress() async {
    try {
      var connectivityResult = await ConnectivityWrapper.instance.isConnected;
      if (connectivityResult == false) {
        _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Du befindest dich derzeitig nicht in einem Netztwerk.",
        );
      }

      NetworkInfo networkInfo = NetworkInfo();
      String? routerIp = await networkInfo.getWifiIP();
      if (routerIp == null) return "";
      return routerIp.substring(0, routerIp.length - 4);
    } catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description:
            "Beim abrufen der IP Adresse ist ein fehler aufgetreten $e",
      );
      return null;
    }
  }

  Future<ServerCallBack> registerHouseHold(
      BodoboxUser user, String ipAdress, List sharingBooks) async {
    try {
      await _firebaseFirestore.collection("houses").doc(ipAdress).set({
        "uid": user.uid,
        "sharingBooks": sharingBooks,
      });
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten $error");
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<ServerCallBack> deleteHouseHold(
    ipAdress,
  ) async {
    try {
      await _firebaseFirestore.collection("houses").doc(ipAdress).delete();
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten $error");
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<List> getHousBooks(String ipAdress) async {
    try {
      final books =
          await _firebaseFirestore.collection("houses").doc(ipAdress).get();
      return books["sharingBooks"];
    } on FirebaseException catch (error) {
      await _dialogService.showCustomDialog(
          variant: DialogType.error,
          description: "Ein fehler ist aufgetretten $error");
      return [];
    }
  }

  // Device Service

  Future<ServerCallBack> registerSecondDevice(String userId) async {
    try {
      final device = await _deviceService.getDeviceImei();
      if (device == null) return ServerCallBack(status: false, string: "");
      await _firebaseFirestore.collection("user").doc(userId).update({
        "devices-id-two": device.imeiNumber,
        "devices-name-two": device.deviceName,
      });
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: true, string: "");
    }
  }

  Future<ServerCallBack> registerFirstDevice(String userId) async {
    try {
      final device = await _deviceService.getDeviceImei();
      if (device == null) return ServerCallBack(status: false, string: "");
      await _firebaseFirestore.collection("user").doc(userId).update({
        "devices-id-one": device.imeiNumber,
        "devices-name-one": device.deviceName,
      });
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: true, string: "");
    }
  }

  Future<ServerCallBack> deleteDevice(
      BodoboxUser user, String deviceId, DeviceIndex index) async {
    try {
      // udaten des eintrags im server dokument
      switch (index) {
        case DeviceIndex.firstDevice:
          await _firebaseFirestore.collection("user").doc(user.uid).update({
            "devices-id-one": "zero",
            "devices-name-one": "zero",
          });
          break;
        case DeviceIndex.secondDevice:
          await _firebaseFirestore.collection("user").doc(user.uid).update({
            "devices-id-two": "zero",
            "devices-name-two": "zero",
          });
          break;
      }
      final currentDevice = await _deviceService.getDeviceImei();
      if (currentDevice == null)
        return ServerCallBack(
            status: false,
            string: "Es konnten keine Geräte Informationen bekommen werden.");

      // checken ob das zu löschende Gerät das momentane gerät ist
      if (currentDevice.imeiNumber == deviceId) {
        await logOut();
        await _dialogService.showCustomDialog(
            variant: DialogType.error,
            title: "Du wurdest ausgeloggt",
            description:
                "Dieses Gerät hat keinen Zugriff mmehr auf diesen Account.");
        return ServerCallBack(status: true, string: "");
      }
      return ServerCallBack(status: true, string: "");
    } catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: "Beim entfernen des Gerätes ist ein fehler aufgetreten $e",
      );
      return ServerCallBack(status: true, string: "");
    }
  }

  // Master Service

  Future<ServerCallBack> registerBook(BodoBook bodoBook) async {
    try {
      final book = await _firebaseFirestore.collection("books").add({
        "bookCover": bodoBook.coverLink,
        "bookTitle": bodoBook.title,
        "bookDescription": bodoBook.description,
        "pageIndex": bodoBook.pageIndex,
        "testMode": bodoBook.testMode,
      });
      return ServerCallBack(status: true, string: book.id);
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<ServerCallBack> uploadPage(String bookId, BodoBookPage page) async {
    try {
      await _firebaseFirestore
          .collection("books")
          .doc(bookId)
          .collection("pages")
          .add({
        "link-page": page.pageLink,
        "link-music": page.musicLink,
        "link-audio": page.audioLink,
        "pageIndex": page.pageIndex,
      });
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<String?> uploadImage(XFile imageFile, String bucketId) async {
    String imageId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference = _storage.ref().child('$bucketId/$imageId.jpg');
    Uint8List imageBytes = await imageFile.readAsBytes();
    UploadTask uploadTask = storageReference.putData(imageBytes);
    await uploadTask.whenComplete(() => print('Bild erfolgreich hochgeladen'));
    String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  }

  Future<ServerCallBack> uploadAudio(
      String? audioFilePath, String audioName, String bucketId) async {
    try {
      if (audioFilePath != null) {
        String audioFileName = audioName;
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('$bucketId/$audioFileName.mp3');
        UploadTask uploadTask = storageReference.putFile(File(audioFilePath));
        await uploadTask
            .whenComplete(() => print('Bild erfolgreich hochgeladen'));
        String downloadURL = await storageReference.getDownloadURL();
        return ServerCallBack(status: true, string: downloadURL);
      } else {
        print('Bitte wähle eine Audiodatei aus und gib einen Namen ein.');
        return ServerCallBack(status: false, string: "");
      }
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<ServerCallBack> regsiterAudio(String bookId, String collectionId,
      String audioTitle, String audioLink) async {
    try {
      await _firebaseFirestore
          .collection("books")
          .doc(bookId)
          .collection(collectionId)
          .add({
        "audioTitle": audioTitle,
        "audioLink": audioLink,
      });
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: false, string: "");
    }
  }

  Future<int?> getPageIndex(String bookId) async {
    try {
      final pageIndex = await _firebaseFirestore
          .collection("books")
          .doc(bookId)
          .collection("pages")
          .get();
      return pageIndex.size;
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return null;
    }
  }

  Future<int> getUserIndex() async {
    try {
      final user = await _firebaseFirestore.collection("user").get();
      return user.size;
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return 0;
    }
  }

  Future<int> getBookIndex() async {
    try {
      final book = await _firebaseFirestore.collection("books").get();
      return book.size;
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return 0;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPages(String bookId) {
    final pages = _firebaseFirestore
        .collection("books")
        .doc(bookId)
        .collection("pages")
        .orderBy("pageIndex")
        .snapshots();

    print("readed Sucsessfull");

    return pages;
  }

  Future<ServerCallBack> uploadBook(String bookId) async {
    try {
      await _firebaseFirestore.collection("books").doc(bookId).update({
        "testMode": false,
      });
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: false, string: "");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBooks() {
    final books = _firebaseFirestore.collection("books").snapshots();
    return books;
  }

  Future<ServerCallBack> deleteBook(String bookId) async {
    try {
      await _firebaseFirestore.collection("books").doc(bookId).delete();
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: false, string: "");
    }
  }

  // Book Service

  Future<ServerCallBack> buyBook(
    String userId,
    String bookId,
    bool bundle,
  ) async {
    try {
      await _firebaseFirestore
          .collection("user")
          .doc(userId)
          .collection("buyProtocol")
          .doc(bookId)
          .set({
        "bundle": bundle,
      });
      print("achievied: 1");
      final userData = await getUserData(userId);
      print("achievied: 2");
      if (userData == null) ServerCallBack(status: false, string: "");
      final bookList = userData!.owningBooks!;
      bookList.add(bookId);
      await _firebaseFirestore.collection("user").doc(userId).update({
        "owingBooks": bookList,
      });
      print("achievied: 3");

      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: false, string: "");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAudios(
    String bookId,
  ) {
    final snapshots = _firebaseFirestore
        .collection("books")
        .doc(bookId)
        .collection("music")
        .snapshots();
    return snapshots;
  }

  Future<bool> hasBundle(String userId, String bookId) async {
    try {
      final protocolRawData = await _firebaseFirestore
          .collection("user")
          .doc(userId)
          .collection("buyProtocol")
          .doc(bookId)
          .get();
      final data = protocolRawData.data();
      if (data == null) return false;
      return data["bundle"];
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return false;
    }
  }

  Future<ServerCallBack> buyBundle(
    String userId,
    String bookId,
  ) async {
    try {
      await _firebaseFirestore
          .collection("user")
          .doc(userId)
          .collection("buyProtocol")
          .doc(bookId)
          .update({
        "bundle": true,
      });
      return ServerCallBack(status: true, string: "");
    } on FirebaseException catch (e) {
      _dialogService.showCustomDialog(
        variant: DialogType.error,
        description: e.code,
      );
      return ServerCallBack(status: false, string: "");
    }
  }
}
