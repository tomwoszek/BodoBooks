import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ErrorDialogModel extends BaseViewModel {
  final DialogService _dialogService = DialogService();

  void close() {
    DialogResponse<dynamic> response = DialogResponse();
    _dialogService.completeDialog(response);
  }
}
