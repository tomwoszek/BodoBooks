import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'upload_page_viewmodel.dart';

class UploadPageView extends StackedView<UploadPageViewModel> {
  const UploadPageView(this.bookLink, {Key? key}) : super(key: key);
  final String bookLink;

  @override
  Widget builder(
    BuildContext context,
    UploadPageViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: dummyAppBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Container(
            padding: pagePaddingwithAppBar(mediaQuery.width, mediaQuery.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Seite hochladen", style: theme.textTheme.titleLarge),
                verticalSpaceMedium,
                viewModel.pageLink != null
                    ? Material(
                        color: Colors.transparent,
                        elevation: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            viewModel.pageLink!,
                            height: 275,
                            width: 500,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          await viewModel.uploadSite();
                        },
                        child: SizedBox(
                          height: 300,
                          width: 500,
                          child: Material(
                              color: theme.colorScheme.onBackground,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Seite hinzufügen",
                                        style: theme.textTheme.bodySmall)
                                  ])),
                        ),
                      ),
                verticalSpaceMedium,
                viewModel.audioLink != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          horizontalSpaceMedium,
                          SizedBox(
                            width: 250,
                            child: Text(
                              "Diese Datei wurde erfolgreich hochgeladen.",
                              style: theme.textTheme.bodyLarge,
                              textAlign: TextAlign.start,
                            ),
                          )
                        ],
                      )
                    : CustomButton(
                        invert: true,
                        label: "Lade ein Höhrspiel hoch",
                        onPressedCallback: () async {
                          await viewModel.uploadAudio(bookLink);
                        }),
                verticalSpaceSmall,
                viewModel.musicLink != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          horizontalSpaceMedium,
                          SizedBox(
                            width: 250,
                            child: Text(
                              "Diese Datei wurde erfolgreich hochgeladen.",
                              style: theme.textTheme.bodyLarge,
                              textAlign: TextAlign.start,
                            ),
                          )
                        ],
                      )
                    : CustomButton(
                        invert: true,
                        label: "Lade ein Lied hoch",
                        onPressedCallback: () async {
                          await viewModel.uploadMusic(bookLink);
                        }),
                verticalSpaceMedium,
                CustomButton(
                  invert: false,
                  label: "Lade diese Seite hoch",
                  onPressedCallback: () async {
                    await viewModel.uploadPage(bookLink);
                  },
                )
              ],
            )),
      ),
    );
  }

  @override
  UploadPageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      UploadPageViewModel();
}
