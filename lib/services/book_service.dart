import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/prefs_service.dart';
import 'package:bodobox/services/request_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookService {
  final PrefsService _prefsService = locator<PrefsService>();
  final RequestService _requestService = locator<RequestService>();

  Future<bool> buyBook(String bookId, bool bundle) async {
    // Revenue Chat einbinden
    final userId = _prefsService.getUserId();
    if (userId == null) return false;
    final status = await _requestService.buyBook(userId, bookId, bundle);
    return status.status;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAudios(String bookId,)  {
    final audios = _requestService.getAudios(bookId);
    return audios;
  }

  Future<bool> hasBundle( String bookId) async {
    final userId = _prefsService.getUserId();
    return await _requestService.hasBundle(userId!, bookId);
  }
}
