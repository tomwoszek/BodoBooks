import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:bodobox/ui/widgets/common/custom_title/custom_title.dart';
import 'package:bodobox/ui/widgets/common/view_standard/view_standard.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'title_viewmodel.dart';

class TitleView extends StackedView<TitleViewModel> {
  const TitleView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TitleViewModel viewModel,
    Widget? child,
  ) {
    final _theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: _theme.colorScheme.background,
      body: ViewStandard(
          children: [
            verticalSpaceMedium,
            Image.asset("assets/logo-white.png", height: 150),
            Text(
              "Willkommen",
              style: _theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            verticalSpaceMedium,
            CustomTitle(
              icon: Icons.help_outline,
              title: "Was ist BodoBooks ?",
              body:
                  "BODO BOOKS ist eine App von Bodo Krah und Rolf Schröder, einem Kinderbuchautor.\nMit dieser Anwendung können Kinderbücher erworben, gespeichert und vorgelesen werden.",
            ),
            verticalSpaceMedium,
            CustomTitle(
              icon: Icons.star,
              title: "Was ist an BODO BOOKS besonders ?",
              body:
                  "Bei BODO BOX gibt es kein Bücher Labyrinth. Es sind nur die Bücher von Bodo Krah gelistet. Dadurch können die Qualitätsansprüche von Bodo Krah sicher wiedergegeben werden. ",
            ),
            verticalSpaceMedium,
            CustomTitle(
              icon: Icons.settings,
              title: "Wie funktioniert BODO BOOKS ?",
              body:
                  "Nachdem du ein Buch digital erworben hast, findest du es immer in deiner persönlichen Home View, wo du es jederzeit abrufen und vorlesen kannst.",
            ),
            verticalSpaceMedium,
            CustomButton(
                invert: false,
                label: "Registrieren",
                height: 50,
                onPressedCallback: () {
                  viewModel.navigateToRegister();
                }),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Schon ein Account? ",
                  style: _theme.textTheme.bodyMedium,
                ),
                TextButton(
                    onPressed: () {
                      viewModel.navigateToLogIn();
                    },
                    child:
                        Text("Anmelden", style: _theme.textTheme.bodyLarge))
              ],
            ),
            verticalSpaceMedium,
          ]),
    );
  }

  @override
  TitleViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TitleViewModel();
}
