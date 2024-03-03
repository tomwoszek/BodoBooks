import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/widgets/common/custom_button/custom_button.dart';
import 'package:bodobox/ui/widgets/common/custom_master_book_tile/custom_master_book_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'master_viewmodel.dart';

class MasterView extends StackedView<MasterViewModel> {
  const MasterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MasterViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarWithLeadingText(
          leadingTitle: 'Master View',
          icon: Icon(Icons.arrow_back_ios),
          leadingWidth: 300,
          onPressedCallback: () {
            viewModel.back();
          }),
      body: viewModel.hasError
          ? const Center(
              child: Text("Es ist ein fehler aufgetretten."),
            )
          : Container(
              child: Padding(
                padding:
                    pagePaddingwithAppBar(mediaQuery.width, mediaQuery.height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpaceLarge,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            AnimatedFlipCounter(
                                duration: Duration(milliseconds: 500),
                                value: viewModel.bookIndex,
                                textStyle: theme.textTheme.titleLarge),
                            verticalSpaceSmall,
                            Container(
                              width: 35,
                              height: 1,
                              color: Colors.green,
                            ),
                            verticalSpaceTiny,
                            viewModel.bookIndex <= 1
                                ? Text(
                                    "Buch",
                                    style: theme.textTheme.titleMedium,
                                  )
                                : Text(
                                    "Bücher",
                                    style: theme.textTheme.titleMedium,
                                  ),
                          ],
                        ),
                        horizontalSpaceLarge,
                        Column(
                          children: [
                            AnimatedFlipCounter(
                                curve: Curves.easeOut,
                                duration: Duration(milliseconds: 500),
                                value: viewModel.userIndex,
                                textStyle: theme.textTheme.titleLarge),
                            verticalSpaceSmall,
                            Container(
                              width: 35,
                              height: 1,
                              color: Colors.grey,
                            ),
                            verticalSpaceTiny,
                            Text(
                              "Nutzer",
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                    verticalSpaceLarge,
                    horizontalSpaceMedium,
                    Expanded(
                      child: StreamBuilder(
                          stream: viewModel.getBooks(),
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
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Dismissible(
                                          key: UniqueKey(),
                                          direction:
                                              DismissDirection.endToStart,
                                          onDismissed: (direction) {
                                            viewModel.deleteBook(data2.id);
                                          },
                                          background: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            alignment: Alignment.centerRight,
                                            padding: EdgeInsets.all(8),
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: CustomMasterBookTile(
                                              data2["bookTitle"])));
                                }).toList());
                          }),
                    ),
                    verticalSpaceMedium,
                    CustomButton(
                      height: 50,
                      invert: false,
                      label: "Buch hinzufügen",
                      onPressedCallback: () {
                        viewModel.registerBook();
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
  MasterViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MasterViewModel();
}
