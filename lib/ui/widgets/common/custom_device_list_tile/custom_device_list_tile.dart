import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'custom_device_list_tile_model.dart';

class CustomDeviceListTile extends StackedView<CustomDeviceListTileModel> {
  CustomDeviceListTile({
    super.key,
    this.onPressedCallback,
    this.title,
    this.description,
    this.onDismissedCallback,
  });

  void Function()? onPressedCallback;
  void Function(DismissDirection)? onDismissedCallback;
  String? title;
  String? description;

  @override
  Widget builder(
    BuildContext context,
    CustomDeviceListTileModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    return Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        onDismissed: onDismissedCallback,
        background: Container(
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(20)),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Container(
            decoration: BoxDecoration(
                color: theme.colorScheme.onBackground,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.smartphone),
                  horizontalSpaceMedium,
                  SizedBox(
                    width: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? "Gerät",
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          description ?? "Imei Nummer",
                          style: theme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onPressedCallback,
                    icon: const Icon(
                      Icons.delete,
                    ),
                    color: Colors.red,
                  )
                ],
              ),
            )));
  }

  @override
  CustomDeviceListTileModel viewModelBuilder(
    BuildContext context,
  ) =>
      CustomDeviceListTileModel();
}
