import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static late SharedPreferences _preferences;

  static const _keyUserId = "userId";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  Future setUserId(
    String userId,
  ) async =>
      await _preferences.setString(_keyUserId, userId);

  String? getUserId() => _preferences.getString(_keyUserId);

  Future<bool> deletUserId() => _preferences.remove(_keyUserId);
}
