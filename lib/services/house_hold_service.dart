import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/services/request_service.dart';
import 'package:bodobox/utils/models/user_model.dart';

class HouseHoldService {
  static final RequestService _requestService = locator<RequestService>();

  Future<bool> changeMode(
    bool mode,
    BodoboxUser user,
  ) async {
    if (mode == true) {
      final ipAdress = await _requestService.getHousHoldIpAdress();
      _requestService.registerHouseHold(
          user, ipAdress!, user.owningBooks ?? []);
      _requestService.updateSharingMode(user, mode);
      return true;
    } else {
      final ipAdress = await _requestService.getHousHoldIpAdress();
      _requestService.deleteHouseHold(ipAdress!);
      _requestService.updateSharingMode(user, mode);
      return true;
    }
  }

  Future<List> getBooks() async {
    final ipAdress = await _requestService.getHousHoldIpAdress();
    final books = await _requestService.getHousBooks(ipAdress!);
    return books;
  }
}
