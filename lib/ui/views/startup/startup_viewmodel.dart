import 'package:bodobox/services/prefs_service.dart';
import 'package:stacked/stacked.dart';
import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PrefsService _prefService = locator<PrefsService>();

  Future runStartupLogic() async {
    final userId = _prefService.getUserId();
    await Future.delayed(const Duration(seconds: 1));
    if (userId == null || userId.isEmpty) {
      await _navigationService.replaceWithTitleView();
    } else {
      await _navigationService.replaceWithHomeView();
    }
  }
}
