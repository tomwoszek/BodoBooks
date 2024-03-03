// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/book_service.dart';
import '../services/crypt_service.dart';
import '../services/device_service.dart';
import '../services/house_hold_service.dart';
import '../services/master_service.dart';
import '../services/prefs_service.dart';
import '../services/request_service.dart';
import '../services/theme_service.dart';
import '../services/user_servie_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => UserServieService());
  locator.registerLazySingleton(() => DeviceService());
  locator.registerLazySingleton(() => RequestService());
  locator.registerLazySingleton(() => PrefsService());
  locator.registerLazySingleton(() => HouseHoldService());
  locator.registerLazySingleton(() => ThemeService());
  locator.registerLazySingleton(() => MasterService());
  locator.registerLazySingleton(() => BookService());
  locator.registerLazySingleton(() => CryptService());
}
