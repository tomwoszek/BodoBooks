import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'legals_viewmodel.dart';

class LegalsView extends StackedView<LegalsViewModel> {
  const LegalsView(this.type, {Key? key}) : super(key: key);
  final LegalTexts type;

  @override
  Widget builder(
    BuildContext context,
    LegalsViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appBarWithButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressedCallback: () {
              viewModel.back();
            },
            title: ''),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: pagePaddingwithAppBar(mediaQuery.width),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(viewModel.header, style: theme.textTheme.titleMedium),
                verticalSpaceMedium,
                Text(
                  '''${viewModel.body}''',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  LegalsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LegalsViewModel(legals: type);
}
