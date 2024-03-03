import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:bodobox/ui/widgets/common/view_standard/view_standard.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'book_detail_viewmodel.dart';

class BookDetailView extends StackedView<BookDetailViewModel> {
  const BookDetailView(this.book, this.bookId, {Key? key}) : super(key: key);
  final BodoBook book;
  final String bookId;

  @override
  Widget builder(
    BuildContext context,
    BookDetailViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: appBarWithLeadingText(
            leadingTitle: book.title!,
            icon: const Icon(Icons.arrow_back_ios),
            leadingWidth: 400,
            onPressedCallback: () {}),
        backgroundColor: theme.colorScheme.background,
        body: ViewStandard(children: [
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
          verticalSpaceMassive,
          CustomButton(
            height: 55,
            invert: true,
            label: "Lerninhalt",
            onPressedCallback: () async {},
          ),
          verticalSpaceSmall,
          viewModel.hasBundle
              ? CustomButton(
                  height: 55,
                  invert: true,
                  label: "Hörbuch anhören ",
                  onPressedCallback: () async {
                    await viewModel.listenToAudios(bookId, book);
                  },
                )
              : CustomButton(
                  height: 55,
                  invert: true,
                  label: "Bundel kaufen ",
                  onPressedCallback: () async {
                    await viewModel.buyBundle();
                  },
                ),
          verticalSpaceSmall,
          CustomButton(
            height: 55,
            invert: false,
            label: "Buch lessen",
            onPressedCallback: () async {
              await viewModel.readPage(bookId);
            },
          ),
        ]));
  }

  @override
  BookDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BookDetailViewModel(bookId: bookId);
}
