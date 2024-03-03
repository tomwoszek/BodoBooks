import 'package:bodobox/app/app.dialogs.dart';
import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/book_service.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BookDetailViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final BookService _bookService = locator<BookService>();

  Future<void> readPage(String bookId) async {
    await giveInformation();
    await _navigationService.navigateToReadView(bookId: bookId);
  }

  Future<void> listenToAudios(String bookId, BodoBook book) async {
    await giveInformation();
    await _navigationService.navigateToListenView(bookLink: bookId, book: book);
  }

  Future<bool> hasBundle(String bookId) async{
    return await _bookService.hasBundle(bookId);

  }

  Future<void> giveInformation() async {
    await _dialogService.showCustomDialog(
        variant: DialogType.error,
        title: "Achtung",
        description:
            "Lassen Sie ihr Kind bitte nicht unbeaufsichtigt mit diesem Gerät alleine, aktivieren sie wenn doch den Geführten Zugriff.");
  }
}
