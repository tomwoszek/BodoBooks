import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'custom_button_model.dart';

// ignore: must_be_immutable
class CustomButton extends StackedView<CustomButtonModel> {
  CustomButton(
      {super.key,
      required this.invert,
      required this.label,
      this.height,
      this.onPressedCallback});

  bool invert;
  String label;
  double? height = 60;
  void Function()? onPressedCallback;

  @override
  Widget builder(
    BuildContext context,
    CustomButtonModel viewModel,
    Widget? child,
  ) {
    final _theme = Theme.of(context);
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressedCallback,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              invert == false ? _theme.colorScheme.primary : Colors.black,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(label,
                  style: invert == true
                      ? _theme.textTheme.labelMedium
                          ?.copyWith(color: Colors.white)
                      : _theme.textTheme.labelMedium),
            ],
          ),
        ),
      ),
    );
  }

  @override
  CustomButtonModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomButtonModel();
}
