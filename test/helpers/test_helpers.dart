import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bodobox/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bodobox/services/user_servie_service.dart';
import 'package:bodobox/services/device_service.dart';
import 'package:bodobox/services/request_service.dart';
import 'package:bodobox/services/prefs_service.dart';
import 'package:bodobox/services/house_hold_service.dart';
import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/services/master_service.dart';
import 'package:bodobox/services/book_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<UserServieService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DeviceService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<RequestService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<PrefsService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<HouseHoldService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<ThemeService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<MasterService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BookService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterUserServieService();
  getAndRegisterDeviceService();
  getAndRegisterRequestService();
  getAndRegisterPrefsService();
  getAndRegisterHouseHoldService();
  getAndRegisterThemeService();
  getAndRegisterMasterService();
  getAndRegisterBookService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockUserServieService getAndRegisterUserServieService() {
  _removeRegistrationIfExists<UserServieService>();
  final service = MockUserServieService();
  locator.registerSingleton<UserServieService>(service);
  return service;
}

MockDeviceService getAndRegisterDeviceService() {
  _removeRegistrationIfExists<DeviceService>();
  final service = MockDeviceService();
  locator.registerSingleton<DeviceService>(service);
  return service;
}

MockRequestService getAndRegisterRequestService() {
  _removeRegistrationIfExists<RequestService>();
  final service = MockRequestService();
  locator.registerSingleton<RequestService>(service);
  return service;
}

MockPrefsService getAndRegisterPrefsService() {
  _removeRegistrationIfExists<PrefsService>();
  final service = MockPrefsService();
  locator.registerSingleton<PrefsService>(service);
  return service;
}

MockHouseHoldService getAndRegisterHouseHoldService() {
  _removeRegistrationIfExists<HouseHoldService>();
  final service = MockHouseHoldService();
  locator.registerSingleton<HouseHoldService>(service);
  return service;
}

MockThemeService getAndRegisterThemeService() {
  _removeRegistrationIfExists<ThemeService>();
  final service = MockThemeService();
  locator.registerSingleton<ThemeService>(service);
  return service;
}

MockMasterService getAndRegisterMasterService() {
  _removeRegistrationIfExists<MasterService>();
  final service = MockMasterService();
  locator.registerSingleton<MasterService>(service);
  return service;
}

MockBookService getAndRegisterBookService() {
  _removeRegistrationIfExists<BookService>();
  final service = MockBookService();
  locator.registerSingleton<BookService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
