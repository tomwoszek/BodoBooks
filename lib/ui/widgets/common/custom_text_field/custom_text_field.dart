import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import 'custom_text_field_model.dart';

// ignore: must_be_immutable
class CustomTextField extends StackedView<CustomTextFieldModel> {
  CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      required this.isPassword,
      this.validator,
      this.icon});

  String label;
  TextEditingController controller;
  bool isPassword;
  String? Function(String?)? validator;
  IconData? icon;

  @override
  Widget builder(
    BuildContext context,
    CustomTextFieldModel viewModel,
    Widget? child,
  ) {
    final _theme = Theme.of(context);
    return Material(
      color: _theme.colorScheme.onBackground,
      borderRadius: BorderRadius.circular(20),
      child: TextFormField(
        obscureText: isPassword,
        onTap: () {
          HapticFeedback.selectionClick();
        },
        controller: controller,
        cursorColor: _theme.colorScheme.primary,
        decoration: icon != null
            ? InputDecoration(
                prefixIcon: Icon(icon),
                labelText: label,
                labelStyle: _theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              )
            : InputDecoration(
                labelText: label,
                labelStyle: _theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
        validator: validator,
      ),
    );
  }

  @override
  CustomTextFieldModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomTextFieldModel();
}
