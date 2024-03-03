import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/views/register/register_view.form.dart';
import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:bodobox/ui/widgets/common/custom_loading_indicator/custom_loading_indicator.dart';
import 'package:bodobox/ui/widgets/common/custom_text_field/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'register_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(name: 'name'),
    FormTextField(
      name: 'email',
    ),
    FormTextField(
      name: 'confirmPassword',
    ),
    FormTextField(name: 'password'),
  ],
)
class RegisterView extends StackedView<RegisterViewModel> with $RegisterView {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    final _theme = Theme.of(context);
    final _mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarWithButton(
          title: "Registrierung",
          icon: const Icon(Icons.arrow_back_ios),
          onPressedCallback: () {
            viewModel.back();
          }),
      backgroundColor: _theme.colorScheme.background,
      body: ListView(
        physics: _mediaQuery.width < 400
            ? const NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
        children: [
          Container(
              padding: pagePaddingwithAppBar(_mediaQuery.width, _mediaQuery.height),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/logo-white.png", height: 150),
                    verticalSpaceTiny,
                    CustomTextField(
                        icon: Icons.person,
                        controller: nameController,
                        label: "Vor-Nachname",
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Gebe bitte deinen Namen ein.";
                          return null;
                        }),
                    verticalSpaceMedium,
                    CustomTextField(
                        icon: Icons.mail,
                        controller: emailController,
                        label: "E-Mail",
                        isPassword: false,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Gebe bitte eine E-Mail ein.";
                          if (EmailValidator.validate(value) == false)
                            return "Gebe bitte eine richtige E-Mail an.";
                          return null;
                        }),
                    verticalSpaceMedium,
                    CustomTextField(
                        icon: Icons.password,
                        controller: passwordController,
                        label: "Passwort",
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Gebe bitte ein Passort ein.";
                          return null;
                        }),
                    verticalSpaceMedium,
                    CustomTextField(
                        icon: Icons.password,
                        controller: confirmPasswordController,
                        label: "Passwort bestätigen",
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Gebe bitte ein Passort ein.";
                          if (value != passwordController.text)
                            return "Das Password stimmt nicht überein.";
                          return null;
                        }),
                    verticalSpaceMedium,
                    viewModel.isBusy == true
                        ? CustomLoadingIndicator()
                        : CustomButton(
                            invert: false,
                            label: "Weiter",
                            height: 50,
                            onPressedCallback: () {
                              if (viewModel.formKey.currentState?.validate() ==
                                  true) {
                                viewModel.register();
                              }
                            },
                          ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  @override
  RegisterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterViewModel();

  @override
  void onViewModelReady(RegisterViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(RegisterViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
