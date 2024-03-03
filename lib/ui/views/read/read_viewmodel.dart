import 'package:bodobox/app/app.dialogs.dart';
import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/master_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReadViewModel extends BaseViewModel {
  int _currentPage = 1;
  int get currentPage => _currentPage;
  int _bookIndex = 0;
  int get bookIndex => _bookIndex;
  final MasterService _masterService = locator<MasterService>();
  final DialogService _dialogService = locator<DialogService>();

  void updateIndex(int newIndex) {
    _currentPage = newIndex;
    rebuildUi();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPages(String bookId) {
    return _masterService.getPages(bookId);
  }

  Future<void> activateGuidedAccess() async {
    final platform = MethodChannel("custom");
    try {
      await platform.invokeMethod('activateGuidedAccess');
    } on PlatformException catch (e) {
      print('Fehler beim Aktivieren des geführten Zugriffs: ${e.message}');
    }
  }
}
