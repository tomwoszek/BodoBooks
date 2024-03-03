import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/common/ui_helpers.dart';
import 'package:bodobox/ui/widgets/common/custom_loading_indicator/custom_loading_indicator.dart';
import 'package:bodobox/ui/widgets/common/view_standard/view_standard.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'listen_viewmodel.dart';

class ListenView extends StackedView<ListenViewModel> {
  const ListenView(this.bookLink, this.book, {Key? key}) : super(key: key);
  final String bookLink;
  final BodoBook book;

  @override
  Widget builder(
    BuildContext context,
    ListenViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: dummyAppBar(),
      backgroundColor: theme.colorScheme.background,
      body: ViewStandard(
        children: [

          Hero(
            tag: bookLink,
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

          verticalSpaceMedium,
          viewModel.isBusy
          ? const CustomLoadingIndicator()
          : Text(
            viewModel.currentAudioName ?? "Keine Audio Ausgewählt",
            style: theme.textTheme.bodyLarge,
          ),

          verticalSpaceMedium,

          Row(
            children: [
              Text(
                "Wähle bitte eine Audio aus",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),

          SizedBox(
            height: 500,
                child: StreamBuilder(
                    stream: viewModel.getAudios(bookLink),
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
                            return snapshot.data!.docs.isEmpty
                            ? Text(
                              "Leider existieren zu diesem Buch keine Audios.",
                              style: theme.textTheme.bodyLarge,
                            )
                            :Padding(
                              padding: const EdgeInsets.all(10.0),
                              child:  Material(
                                  color: theme.colorScheme.onBackground,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                
                                        viewModel.currentAudio == data2.id
                                        ? GestureDetector( 
                                          onTap: () async{
                                             await viewModel.stopAudio();
                                          },
                                          child: Icon(
                                          Icons.pause,
                                          size: 40,
                                          color: theme.colorScheme.primary
                                        ))
                                        : GestureDetector(
                                          onTap: () async { 
                                           await viewModel.selectAndPlayAudio(data2["audioTitle"], data2["audioLink"],data2.id);
                                          },
                                          child: Icon(
                                          Icons.play_arrow,
                                          size: 40,
                                          color: theme.colorScheme.primary
                                        ),),

                                        
                                
                                        horizontalSpaceMedium,
                                
                                        Text(
                                          data2["audioTitle"],
                                          style: theme.textTheme.titleMedium
                                        )
                                
                                      ],
                                    )
                                  )
                                ),
                            
                            );
                          }).toList());
                    }),
              ),
        ],)
    );
  }

  @override
  ListenViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ListenViewModel();
}
