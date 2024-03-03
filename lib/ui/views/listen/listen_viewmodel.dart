import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/book_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';

class ListenViewModel extends FutureViewModel {
  final BookService _bookService = locator<BookService>();
  String _currentAudio = "";
  String get currentAudio => _currentAudio;
  String? _currentAudioName;
  String? get currentAudioName => _currentAudioName;
  String? _currentAudioLink;
  String? get currentAudioLink => _currentAudioLink;
  double _maxValue = 0;
  double get maxValue => _maxValue;
  double _currentValue = 0;
  double get currentValue => _currentValue;
  FlutterSoundPlayer _player = FlutterSoundPlayer();
  FlutterSoundPlayer get player => _player;

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  AudioPlayer audioPlayer = AudioPlayer();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAudios(String bookId) {
    return _bookService.getAudios(bookId);
  }

  Future<void> selectAndPlayAudio(
      String audioName, String audioLink, String docId) async {
    print("helllo");
    setBusy(true);
    _currentAudioLink = audioLink;
    _currentAudio = docId;
    _currentAudioName = audioName;
    _isPlaying = true;
    await _player.openPlayer();
    await _player.startPlayer(fromURI: audioLink);
    setBusy(false);
    rebuildUi();
  }

  Future<void> stopAudio() async {
    print("helllo");
    _currentAudioLink = null;
    _currentAudio = "";
    _currentAudioName = null;
    _isPlaying = false;
    await _player.closePlayer();
    rebuildUi();
  }

  @override
  Future futureToRun() async {
    _player = FlutterSoundPlayer();
    if (_player.onProgress != null) {
      _player.onProgress!.listen((e) {
        _currentValue = e.position.inMilliseconds.toDouble();
        _maxValue = e.duration.inMilliseconds.toDouble();
      });
    }
  }
}
