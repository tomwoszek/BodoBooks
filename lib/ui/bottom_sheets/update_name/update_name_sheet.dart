import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:bodobox/ui/widgets/common/custom_loading_indicator/custom_loading_indicator.dart';
import 'package:bodobox/ui/widgets/common/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'update_name_sheet_model.dart';

class UpdateNameSheet extends StackedView<UpdateNameSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const UpdateNameSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    UpdateNameSheetModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40),
            ),
            height: 5,
            width: 60,
          ),
          verticalSpaceSmall,
          Text(
            'Name ändern',
            style: theme.textTheme.titleMedium,
          ),
          verticalSpaceMedium,
          CustomTextField(
            controller: viewModel.nameController,
            label: "Name",
            isPassword: false,
          ),
          verticalSpaceMedium,
          viewModel.isBusy
              ? const CustomLoadingIndicator()
              : CustomButton(
                  invert: false,
                  label: "Bestätigen",
                  height: 60,
                  onPressedCallback: () {
                    if (viewModel.nameController.text.isNotEmpty) {
                      viewModel.updateName();
                    }
                  },
                )
        ],
      ),
    );
  }

  @override
  UpdateNameSheetModel viewModelBuilder(BuildContext context) =>
      UpdateNameSheetModel(user: request.data);
}
