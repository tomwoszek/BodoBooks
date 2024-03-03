import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:photo_view/photo_view.dart';

import 'read_viewmodel.dart';

class ReadView extends StackedView<ReadViewModel> {
  const ReadView(this.bookId, {Key? key}) : super(key: key);
  final String bookId;

  @override
  Widget builder(
    BuildContext context,
    ReadViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: appBarWithButton(title: "", icon: Icon(Icons.arrow_back_ios)),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
            // padding: pagePaddingwithAppBar(),
            color: theme.colorScheme.background,
            child: Column(
              mainAxisAlignment: mediaQuery.size.height < mediaQuery.size.width
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: viewModel.getPages(bookId),
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
                        aspectRatio:
                            mediaQuery.size.height > mediaQuery.size.width
                                ? 10 / 5.5
                                : 6.5 / 2.5,
                        initialPage: viewModel.currentPage,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.4,
                        onPageChanged: (index, CarouselPageChangedReason) {
                          viewModel.updateIndex(index);
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        var bookData = snapshot.data!.docs[itemIndex].data()
                            as Map<String, dynamic>;
                        var imageUrl = bookData['link-page'] as String;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhotoView(
                                  imageProvider: NetworkImage(imageUrl),
                                  minScale: PhotoViewComputedScale.contained,
                                  maxScale: PhotoViewComputedScale.covered * 2,
                                  onTapUp: (context, details, controllerValue) {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                if (mediaQuery.size.height > mediaQuery.size.width) ...[
                  verticalSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Color.fromRGBO(185, 189, 200, 1),
                      ),
                      horizontalSpaceSmall,
                      SizedBox(
                        width: 200,
                        child: Text(
                          "Für eine bessere Ansciht das Handy quer nehmen.",
                          style: theme.textTheme.bodySmall,
                        ),
                      )
                    ],
                  ),
                  verticalSpaceMassive
                ],
              ],
            )));
  }

  @override
  ReadViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ReadViewModel();
}
