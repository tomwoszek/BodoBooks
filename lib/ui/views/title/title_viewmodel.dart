import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TitleViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> navigateToRegister() async {
    await _navigationService.navigateTo(Routes.registerView);
  }

  Future<void> navigateToLogIn() async {
    await _navigationService.navigateTo(Routes.loginView);
  }
}
