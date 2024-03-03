import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'test_viewmodel.dart';

class TestView extends StackedView<TestViewModel> {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TestViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Center(child: Text("Test Widget")),
      ),
    );
  }

  @override
  TestViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TestViewModel();
}
