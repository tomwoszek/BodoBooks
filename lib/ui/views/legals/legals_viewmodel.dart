import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/utils/enums.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LegalsViewModel extends FutureViewModel {
  LegalsViewModel({required this.legals});
  final LegalTexts legals;
  final NavigationService _navigationService = locator<NavigationService>();
  String header = "Header";
  String body = "Body";

  void back() {
    _navigationService.back();
  }

  void setText() {
    switch (legals) {
      case LegalTexts.dataSecurity:
        header = "DataSecurity";
        body = "...";
      case LegalTexts.imprint:
        header = "Imprint";
        body = "...";
      case LegalTexts.termsOfUsage:
        header = "Terms Of Usage";
        body = "...";
    }
  }

  @override
  Future futureToRun() async {
    setText();
  }
}
