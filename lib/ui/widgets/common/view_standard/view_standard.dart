import 'package:bodobox/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'view_standard_model.dart';

class ViewStandard extends StackedView<ViewStandardModel> {
  ViewStandard(
      {super.key, this.padding, this.backgroundColor, required this.children});
  EdgeInsetsGeometry? padding;
  Color? backgroundColor;
  final List<Widget> children;

  @override
  Widget builder(
    BuildContext context,
    ViewStandardModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Container(
        padding: padding ??
            pagePaddingwithAppBar(mediaQuery.width, mediaQuery.height),
        color: backgroundColor ?? theme.colorScheme.background,
        child: SingleChildScrollView(
          physics: mediaQuery.height > 800
              ? const NeverScrollableScrollPhysics()
              : AlwaysScrollableScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children),
        ));
  }

  @override
  ViewStandardModel viewModelBuilder(
    BuildContext context,
  ) =>
      ViewStandardModel();
}
