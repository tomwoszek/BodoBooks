import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/request_service.dart';
import 'package:bodobox/utils/models/book_model.dart';
import 'package:bodobox/utils/models/page_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class MasterService {
  static final RequestService _requestService = locator<RequestService>();

  Future<String?> uploadBook(BodoBook book) async {
    final status = await _requestService.registerBook(book);
    return status.string;
  }

  Future<String?> uploadAudio(String audioFilePath, String audioName,
      String bucketId, String bookId) async {
    final link =
        await _requestService.uploadAudio(audioFilePath, audioName, bucketId);
    _requestService.regsiterAudio(bookId, "music", audioName, link.string);
    return link.string;
  }

  Future<String?> uploadMusic(String audioFilePath, String audioName,
      String bucketId, String bookId) async {
    final link =
        await _requestService.uploadAudio(audioFilePath, audioName, bucketId);
    _requestService.regsiterAudio(bookId, "music", audioName, link.string);
    return link.string;
  }

  Future<int?> getPageIndex(String bookId) async {
    final pageIndex = await _requestService.getPageIndex(bookId);
    return pageIndex;
  }

  Future<String?> uploadImage(XFile image, String bucketId) async {
    final link = _requestService.uploadImage(image, bucketId);
    return link;
  }

  Future<int> getUserIndex() async {
    final userIndex = _requestService.getUserIndex();
    return userIndex;
  }

  Future<int> getBookIndex() async {
    final bookIndex = _requestService.getBookIndex();
    return bookIndex;
  }

  Future<bool> uploadPage(String bookId, BodoBookPage page) async {
    final status = await _requestService.uploadPage(bookId, page);
    return status.status;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPages(String bookId) {
    final pages = _requestService.getPages(bookId);
    return pages;
  }

  Future<bool> setBookLive(String bookId) async {
    final status = await _requestService.uploadBook(bookId);
    return status.status;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getBooks() {
    final books = _requestService.getBooks();
    return books;
  }

  Future<bool> deleteBook(String bookId) async {
    final status = await _requestService.deleteBook(bookId);
    return status.status;
  }
}
