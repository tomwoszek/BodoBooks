import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/master_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PagelistViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final MasterService _masterService = locator<MasterService>();

  Future<void> createPage(String bookLink) async {
    await _navigationService.navigateToUploadPageView(bookLink: bookLink);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPages(String bookId) {
    return _masterService.getPages(bookId);
  }

  Future<void> uploadBook(String bookId) async {
    final uploadStatus = await _masterService.setBookLive(bookId);
    if (uploadStatus) {
      await _navigationService.clearStackAndShow(Routes.homeView);
    }
  }
}
