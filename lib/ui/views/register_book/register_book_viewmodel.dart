import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:bodobox/services/master_service.dart';
import 'package:bodobox/ui/views/register_book/register_book_view.form.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterBookViewModel extends FormViewModel {
  final MasterService _masterService = locator<MasterService>();
  final NavigationService _navigationService = locator<NavigationService>();
  bool _isBookUploaded = false;
  bool get isBookUploaded => _isBookUploaded;
  String _coverLink = "";
  String get coverLink => _coverLink;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  Future<void> uploadCover() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final coverLin = await _masterService.uploadImage(image, "bookcovers");
    if (coverLin == null) return;
    _coverLink = coverLin;
    _isBookUploaded = true;
    rebuildUi();
  }

  Future<void> uploadBook() async {
    final book = BodoBook(
      title: titleValue,
      description: descriptionValue,
      coverLink: _coverLink,
      testMode: true,
      pageIndex: 0,
    );
    final bookLink = await _masterService.uploadBook(book);
    if (bookLink != null) {
      await _navigationService.navigateToPagelistView(booklink: bookLink);
    }
  }
}
