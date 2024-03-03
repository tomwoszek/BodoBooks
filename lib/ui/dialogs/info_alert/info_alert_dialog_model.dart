import 'package:bodobox/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InfoAlertDialogModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();

  void close() {
    DialogResponse<dynamic> response = DialogResponse();
    _dialogService.completeDialog(response);
  }
}
