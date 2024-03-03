import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bodo',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                ).animate().moveX(begin: -100, end: 0, curve: Curves.easeInOut),
                Text(
                  'Books',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                ).animate().moveX(begin: 100, end: 0, curve: Curves.easeInOut)
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
