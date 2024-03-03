import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/book_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BuyViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final BookService _bookService = locator<BookService>();

  void back() {
    _navigationService.back();
  }

  Future<void> buySingleBook(String bookId) async {
    if (await _bookService.buyBook(bookId, false)) {
      await _navigationService.clearStackAndShow(Routes.homeView);
    }
  }

  Future<void> buyBundle(String bookId) async {
    if (await _bookService.buyBook(bookId, true)) {
      await _navigationService.clearStackAndShow(Routes.homeView);
    }
  }
}
