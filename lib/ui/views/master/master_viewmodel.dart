import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/master_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MasterViewModel extends FutureViewModel {
  final MasterService _masterService = locator<MasterService>();
  final NavigationService _navigationService = locator<NavigationService>();

  int _bookIndex = 0;
  int _userIndex = 0;

  int get bookIndex => _bookIndex;
  int get userIndex => _userIndex;

  @override
  Future futureToRun() async {
    await getIndexes();
  }

  Future<void> getIndexes() async {
    _bookIndex = await _masterService.getBookIndex();
    _userIndex = await _masterService.getUserIndex();
  }

  void back() {
    _navigationService.back();
  }

  Future<void> registerBook() async {
    await _navigationService.navigateToRegisterBookView();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBooks() {
    return _masterService.getBooks();
  }

  Future<void> deleteBook(String bookId) async {
    await _masterService.deleteBook(bookId);
    await getIndexes();
    rebuildUi();
  }
}
