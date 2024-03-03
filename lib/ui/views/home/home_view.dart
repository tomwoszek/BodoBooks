import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/widgets/common/view_standard/view_standard.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:bodobox/ui/widgets/common/custom_loading_indicator/custom_loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:stacked/stacked.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    final _theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: dummyAppBar(),
      body: viewModel.isBusy
          ? const Center(
              child: CustomLoadingIndicator(),
            )
          : ViewStandard(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hallo ${viewModel.user?.name},",
                      style: _theme.textTheme.bodyLarge!.copyWith(fontSize: 27),
                      textAlign: TextAlign.start,
                    ),
                    IconButton(
                      onPressed: () {
                        viewModel.settings();
                      },
                      icon: const Icon(Icons.person),
                      color: _theme.primaryColor,
                      iconSize: 35,
                    ),
                  ],
                ),
                SizedBox(
                  height: mediaQuery.size.height * 0.75,
                  child: StreamBuilder(
                    stream: viewModel.getBooks(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return CarouselSlider.builder(
                        options: CarouselOptions(
                          viewportFraction: 0.8,
                          aspectRatio: 2.4 / 3,
                          initialPage: viewModel.currentPage,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          onPageChanged: (index, CarouselPageChangedReason) {
                            viewModel.updateIndex(index);
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                        itemCount: viewModel.bookIndex,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var bookData = snapshot.data!.docs[itemIndex].data()
                              as Map<String, dynamic>;
                          var imageUrl = bookData['bookCover'] as String;

                          return Column(
                            children: [
                              Hero(
                                tag: snapshot.data!.docs[itemIndex].id,
                                child: GestureDetector(
                                  onTap: () async {
                                    await viewModel.gotToDetailView(
                                        BodoBook(
                                          title: bookData['bookTitle'],
                                          description:
                                              bookData['bookDescription'],
                                          coverLink: bookData['bookCover'],
                                        ),
                                        snapshot.data!.docs[itemIndex].id,
                                        viewModel.isBookAvailable(
                                            snapshot.data!.docs[itemIndex].id));
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        imageUrl,
                                        height: 450,
                                        width: 300,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ).animate().fadeIn(
                                      delay: const Duration(milliseconds: 140)),
                                ),
                              ),
                              verticalSpaceSmall,
                              viewModel.isBookAvailable(
                                      snapshot.data!.docs[itemIndex].id)
                                  ? Text(
                                      "Lessen",
                                      style: _theme.textTheme.bodySmall
                                          ?.copyWith(fontSize: 18),
                                    )
                                  : Text(
                                      "12€",
                                      style: _theme.textTheme.bodySmall
                                          ?.copyWith(fontSize: 18),
                                    )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
