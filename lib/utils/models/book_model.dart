import 'package:bodobox/utils/models/page_model.dart';

class BodoBook {
  BodoBook({
    this.title,
    this.description,
    this.pageIndex,
    this.coverLink,
    this.testMode,
    this.bookPages,
  });
  final String? title;
  final String? description;
  final int? pageIndex;
  final String? coverLink;
  final bool? testMode;
  final List<BodoBookPage>? bookPages;
}
