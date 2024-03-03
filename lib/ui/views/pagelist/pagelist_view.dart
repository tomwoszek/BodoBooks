import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'pagelist_viewmodel.dart';

class PagelistView extends StackedView<PagelistViewModel> {
  const PagelistView(this.booklink, {Key? key}) : super(key: key);
  final String booklink;

  @override
  Widget builder(
    BuildContext context,
    PagelistViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: dummyAppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      body: Container(
          padding: pagePaddingwithAppBar(mediaQuery.width),
          child: Column(
            children: [
              Text("Seitenstruktur", style: theme.textTheme.titleLarge),
              verticalSpaceMedium,
              Expanded(
                child: StreamBuilder(
                    stream: viewModel.getPages(booklink),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView(
                          scrollDirection: Axis.vertical,
                          children: snapshot.data!.docs.map((data2) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    data2["link-page"],
                                    height: 275,
                                    width: 500,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }).toList());
                    }),
              ),
              verticalSpaceMedium,
              CustomButton(
                invert: true,
                label: "Seite hochladen",
                onPressedCallback: () async {
                  await viewModel.createPage(booklink);
                },
              ),
              verticalSpaceSmall,
              CustomButton(
                invert: false,
                label: "Buch veröfentlichen",
                onPressedCallback: () async {
                  await viewModel.uploadBook(booklink);
                },
              ),
              verticalSpaceMedium,
            ],
          )),
    );
  }

  @override
  PagelistViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PagelistViewModel();
}
