import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'buy_viewmodel.dart';

class BuyView extends StackedView<BuyViewModel> {
  const BuyView(this.book, this.bookId, {Key? key}) : super(key: key);
  final BodoBook book;
  final String bookId;

  @override
  Widget builder(
    BuildContext context,
    BuyViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarWithLeadingText(
          leadingTitle: book.title!,
          icon: const Icon(Icons.arrow_back_ios),
          leadingWidth: 300,
          onPressedCallback: () {
            viewModel.back();
          }),
      body: Container(
        color: theme.colorScheme.background,
        child: Padding(
          padding: pagePaddingwithAppBar(mediaQuery.width, mediaQuery.height),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpaceMedium,
              Hero(
                tag: bookId,
                child: Material(
                  color: Colors.transparent,
                  elevation: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      book.coverLink!,
                      height: 350,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Text(
                book.description!,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                height: 55,
                invert: true,
                label: "Buch für 12,99€ kaufen.",
                onPressedCallback: () async {
                  await viewModel.buySingleBook(bookId);
                },
              ),
              verticalSpaceSmall,
              CustomButton(
                height: 55,
                invert: false,
                label: "Bundle für 16,99€ kaufen.",
                onPressedCallback: () async {
                  await viewModel.buyBundle(bookId);
                },
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }

  @override
  BuyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BuyViewModel();
}
