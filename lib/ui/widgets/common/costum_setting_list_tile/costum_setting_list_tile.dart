import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'costum_setting_list_tile_model.dart';

class CostumSettingListTile extends StackedView<CostumSettingListTileModel> {
  const CostumSettingListTile({
    super.key,
    required this.icon,
    required this.onTapCallback,
    required this.label,
    required this.leadingWiget,
    required this.top,
    required this.bottom,
  });

  final bool top;
  final bool bottom;
  final IconData icon;
  final void Function()? onTapCallback;
  final String label;
  final dynamic leadingWiget;

  @override
  Widget builder(
    BuildContext context,
    CostumSettingListTileModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.only(
            topLeft: top ? const Radius.circular(20) : const Radius.circular(0),
            topRight:
                top ? const Radius.circular(20) : const Radius.circular(0),
            bottomLeft:
                bottom ? const Radius.circular(20) : const Radius.circular(0),
            bottomRight:
                bottom ? const Radius.circular(20) : const Radius.circular(0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 35,
                  ),
                  horizontalSpaceSmall,
                  Text(label, style: theme.textTheme.titleMedium),
                ],
              ),
              leadingWiget,
            ],
          ),
        ),
      ),
    );
  }

  @override
  CostumSettingListTileModel viewModelBuilder(
    BuildContext context,
  ) =>
      CostumSettingListTileModel();
}
