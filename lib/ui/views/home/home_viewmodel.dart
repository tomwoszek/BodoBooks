import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/device_service.dart';
import 'package:bodobox/services/house_hold_service.dart';
import 'package:bodobox/services/master_service.dart';
import 'package:bodobox/services/user_servie_service.dart';
import 'package:bodobox/ui/views/book_detail/book_detail_view.dart';
import 'package:bodobox/ui/views/buy/buy_view.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:bodobox/utils/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel {
  final UserServieService _userService = locator<UserServieService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DeviceService _deviceService = locator<DeviceService>();
  final MasterService _masterService = locator<MasterService>();
  final HouseHoldService _houseHoldService = locator<HouseHoldService>();

  BodoboxUser? _user;
  BodoboxUser? get user => _user;
  String _imageLink =
      "https://scontent.ffra1-1.fna.fbcdn.net/v/t39.30808-6/288357007_111369891616661_1261077742861482743_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=krIpkdYjUYIAX_UdIpa&_nc_oc=AQneOYbxrpgGL9axxgRB82n40N-LeZame2v3Qqb8M1rBLGIdFznR-CRaPefOeDHbh2du0aTWgY12GLLF-Rb4aq5S&_nc_ht=scontent.ffra1-1.fna&oh=00_AfCFFGQ_HnOl47isSndary0NvfcTln3FcBBq3AgkmoCXQg&oe=65C810F0";
  String get imageLink => _imageLink;
  int _currentPage = 1;
  int get currentPage => _currentPage;

  int _bookIndex = 0;
  int get bookIndex => _bookIndex;

  List<dynamic> _availableBooks = [];
  List<dynamic> get availableBooks => _availableBooks;

  @override
  Future futureToRun() async {
    await getUserData();
    await isDeviceRegistered();
    await getIndexes();
    await getAvailableBooks();
  }

  Future<void> getAvailableBooks() async {
    if (_user == null) return;
    if (_user!.owningBooks != null) {
      final userBooks = _user!.owningBooks;
      _availableBooks.addAll(userBooks!);
    }
    final housBooks = await _houseHoldService.getBooks();
    _availableBooks.addAll(housBooks);
  }

  bool isBookAvailable(String currentBook) {
    return _availableBooks.contains(currentBook);
  }

  void updateIndex(int newIndex) {
    _currentPage = newIndex;
    rebuildUi();
  }

  Future<void> logOut() async{
   await  _userService.logOut();
  }

  Future<void> getUserData() async {
    _user = await _userService.getUserData();
  }

  Future<void> isDeviceRegistered() async {
    await _deviceService.isDeviceRegistered(user!);
  }

  Future<void> settings() async {
    await _navigationService.clearStackAndShow(Routes.settingsView);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBooks() {
    return _masterService.getBooks();
  }

  Future<void> getIndexes() async {
    _bookIndex = await _masterService.getBookIndex();
  }

  Future<void> gotToDetailView(
    BodoBook book,
    String bookId,
    bool bought,
  ) async {
    if (bought == true) {
      await _navigationService.navigateWithTransition(
          BookDetailView(book, bookId),
          transitionStyle: Transition.zoom);
    } else {
      await _navigationService.navigateWithTransition(BuyView(book, bookId),
          transitionStyle: Transition.zoom);
    }
  }
}
