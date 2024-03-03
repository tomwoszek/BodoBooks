import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'custom_master_book_tile_model.dart';

class CustomMasterBookTile extends StackedView<CustomMasterBookTileModel> {
  const CustomMasterBookTile(this.bookTitle, {super.key});
  final String bookTitle;

  @override
  Widget builder(
    BuildContext context,
    CustomMasterBookTileModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    return Material(
        color: theme.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.book,
              ),
              horizontalSpaceMedium,
              Text(bookTitle, style: theme.textTheme.bodyMedium),
            ],
          ),
        ));
  }

  @override
  CustomMasterBookTileModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomMasterBookTileModel();
}
