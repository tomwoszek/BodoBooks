import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/master_service.dart';
import 'package:bodobox/utils/models/page_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class UploadPageViewModel extends BaseViewModel {
  final MasterService _masterService = locator<MasterService>();
  final NavigationService _navigationService = locator<NavigationService>();
  String? _pageLink;
  String? get pageLink => _pageLink;
  String? _audioLink;
  String? get audioLink => _audioLink;
  String? _musicLink;
  String? get musicLink => _musicLink;

  Future<void> uploadSite() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final bucketLink = await _masterService.uploadImage(image, "bookpages");
    if (bucketLink == null) return;
    _pageLink = bucketLink;
    rebuildUi();
  }

  Future<void> uploadAudio(String bookId) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'ogg'],
    );
    if (result == null) return;
    final bucketLink = await _masterService.uploadAudio(
        result.paths.first!, result.names.first!, "bookaudios", bookId);
    if (bucketLink == null) return;
    _audioLink = bucketLink;
    rebuildUi();
  }

  Future<void> uploadMusic(String bookId) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'ogg'],
    );
    if (result == null) return;
    final bucketLink = await _masterService.uploadAudio(
        result.paths.first!, result.names.first!, "bookmusic", bookId);
    if (bucketLink == null) return;
    _musicLink = bucketLink;
    rebuildUi();
  }

  Future<void> uploadPage(String bookId) async {
    if (_pageLink == null) return;
    final pageIndex = await _masterService.getPageIndex(bookId);
    if (pageIndex == null) return;
    final page = BodoBookPage(
      audioLink: _audioLink,
      musicLink: _musicLink,
      pageLink: _pageLink,
      pageIndex: pageIndex + 1,
    );
    final serverStatus = await _masterService.uploadPage(bookId, page);
    if (serverStatus == true) {
      _navigationService.back();
    }
  }
}
