import 'package:bodobox/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:bodobox/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:bodobox/ui/views/home/home_view.dart';
import 'package:bodobox/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:bodobox/services/user_servie_service.dart';
import 'package:bodobox/services/device_service.dart';
import 'package:bodobox/services/request_service.dart';
import 'package:bodobox/ui/dialogs/error/error_dialog.dart';
import 'package:bodobox/services/prefs_service.dart';
import 'package:bodobox/services/house_hold_service.dart';
import 'package:bodobox/ui/views/title/title_view.dart';
import 'package:bodobox/services/theme_service.dart';
import 'package:bodobox/ui/views/register/register_view.dart';
import 'package:bodobox/ui/views/login/login_view.dart';
import 'package:bodobox/ui/views/settings/settings_view.dart';
import 'package:bodobox/ui/bottom_sheets/update_name/update_name_sheet.dart';
import 'package:bodobox/ui/bottom_sheets/show_devices/show_devices_sheet.dart';
import 'package:bodobox/ui/views/test/test_view.dart';
import 'package:bodobox/services/master_service.dart';
import 'package:bodobox/ui/views/master/master_view.dart';
import 'package:bodobox/ui/views/register_book/register_book_view.dart';
import 'package:bodobox/ui/views/pagelist/pagelist_view.dart';
import 'package:bodobox/ui/views/upload_page/upload_page_view.dart';
import 'package:bodobox/ui/views/buy/buy_view.dart';
import 'package:bodobox/ui/views/legals/legals_view.dart';
import 'package:bodobox/services/book_service.dart';
import 'package:bodobox/ui/views/book_detail/book_detail_view.dart';
import 'package:bodobox/ui/views/read/read_view.dart';
import 'package:bodobox/ui/views/listen/listen_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: TitleView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: TestView),
    MaterialRoute(page: MasterView),
    MaterialRoute(page: RegisterBookView),
    MaterialRoute(page: PagelistView),
    MaterialRoute(page: UploadPageView),
    MaterialRoute(page: BuyView),
    MaterialRoute(page: LegalsView),
    MaterialRoute(page: BookDetailView),
    MaterialRoute(page: ReadView),
    MaterialRoute(page: ListenView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: UserServieService),
    LazySingleton(classType: DeviceService),
    LazySingleton(classType: RequestService),
    LazySingleton(classType: PrefsService),
    LazySingleton(classType: HouseHoldService),
    LazySingleton(classType: ThemeService),
    LazySingleton(classType: MasterService),
    LazySingleton(classType: BookService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: UpdateNameSheet),
    StackedBottomsheet(classType: ShowDevicesSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: ErrorDialog),
// @stacked-dialog
  ],
)
class App {}
