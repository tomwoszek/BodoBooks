// ignore_for_file: must_be_immutable

import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'custom_title_model.dart';

class CustomTitle extends StackedView<CustomTitleModel> {
  CustomTitle(
      {super.key, required this.title, required this.body, required this.icon});

  IconData icon;
  String body;
  String title;
  @override
  Widget builder(
    BuildContext context,
    CustomTitleModel viewModel,
    Widget? child,
  ) {
    final _theme = Theme.of(context);
    final _mediaData = MediaQuery.of(context).size;
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 45,
          ),
          horizontalSpaceMedium,
          SizedBox(
            width: _mediaData.width * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    title, 
                    style: _theme.textTheme.titleMedium,
                    overflow: TextOverflow.clip,
                  )
                 ),
                SizedBox(
                  width: _mediaData.width * 0.6,
                  height: 100,
                  child: Text(
                    body,
                    style: _theme.textTheme.bodySmall,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          )
        ]);
  }

  @override
  CustomTitleModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomTitleModel();
}
