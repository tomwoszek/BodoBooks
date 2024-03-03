import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/views/register_book/register_book_view.form.dart';
import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:bodobox/ui/widgets/common/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'register_book_viewmodel.dart';

@FormView(
  fields: [
    FormTextField(
      name: 'title',
    ),
    FormTextField(name: 'description'),
  ],
)
class RegisterBookView extends StackedView<RegisterBookViewModel>
    with $RegisterBookView {
  const RegisterBookView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterBookViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarWithLeadingText(
          leadingTitle: 'Neues Buch',
          icon: const Icon(Icons.arrow_back_ios),
          leadingWidth: 300,
          onPressedCallback: () {}),
      body: Container(
        color: theme.colorScheme.background,
        child: Padding(
          padding: pagePaddingwithAppBar(mediaQuery.width),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                viewModel.isBookUploaded == true
                    ? Material(
                        color: Colors.transparent,
                        elevation: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            viewModel.coverLink,
                            height: 350,
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          await viewModel.uploadCover();
                        },
                        child: SizedBox(
                          height: 350,
                          width: 250,
                          child: Material(
                              color: theme.colorScheme.onBackground,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Cover hinzufügen",
                                        style: theme.textTheme.bodySmall)
                                  ])),
                        ),
                      ),
                verticalSpaceMedium,
                CustomTextField(
                    controller: titleController,
                    label: "Titel",
                    isPassword: false,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Gebe bitte einen Titel ein.";
                      return null;
                    }),
                verticalSpaceMedium,
                CustomTextField(
                    controller: descriptionController,
                    label: "Beschreibung des Buches",
                    isPassword: false,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return "Gebe bitte eine Beschreibung ein.";
                      return null;
                    }),
                verticalSpaceMedium,
                CustomButton(
                  height: 50,
                  invert: false,
                  label: "Weiter",
                  onPressedCallback: () async {
                    if (viewModel.formKey.currentState!.validate()) {
                      await viewModel.uploadBook();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  RegisterBookViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RegisterBookViewModel();

  @override
  void onViewModelReady(RegisterBookViewModel viewModel) {
    syncFormWithViewModel(viewModel);
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(RegisterBookViewModel viewModel) {
    disposeForm();
    super.onDispose(viewModel);
  }
}
