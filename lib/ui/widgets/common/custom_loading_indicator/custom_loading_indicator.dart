import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stacked/stacked.dart';

import 'custom_loading_indicator_model.dart';

class CustomLoadingIndicator extends StackedView<CustomLoadingIndicatorModel> {
  const CustomLoadingIndicator({super.key});

  @override
  Widget builder(
    BuildContext context,
    CustomLoadingIndicatorModel viewModel,
    Widget? child,
  ) {
    final _theme = Theme.of(context);
    return SpinKitThreeBounce(
      color: _theme.colorScheme.primary,
      size: 50.0,
      // controller: AnimationController(vsync: , duration: const Duration(milliseconds: 1200)),
    );
  }

  @override
  CustomLoadingIndicatorModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomLoadingIndicatorModel();
}
