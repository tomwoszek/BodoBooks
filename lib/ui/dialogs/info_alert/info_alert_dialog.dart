import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'info_alert_dialog_model.dart';

class InfoAlertDialog extends StackedView<InfoAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const InfoAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    InfoAlertDialogModel viewModel,
    Widget? child,
  ) {
    final _theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      surfaceTintColor: _theme.colorScheme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              request.title ?? "Erfolg",
              style: _theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            verticalSpaceSmall,
            /* const Icon(
              Icons.check,
              size: 50,
              color: Colors.green,
            ),*/
            verticalSpaceSmall,
            Text(
              request.description ?? "Die Anfrage hat geklappt",
              textAlign: TextAlign.center,
              style: _theme.textTheme.bodyMedium,
            ),
            verticalSpaceSmall,
            CustomButton(
              label: request.customData ?? "Schließen",
              onPressedCallback: request.data ??
                  () {
                    viewModel.close();
                  },
              invert: false,
            )
          ],
        ),
      ),
    );
  }

  @override
  InfoAlertDialogModel viewModelBuilder(BuildContext context) =>
      InfoAlertDialogModel();
}
