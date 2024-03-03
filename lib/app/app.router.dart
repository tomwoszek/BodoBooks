// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bodobox/ui/views/book_detail/book_detail_view.dart' as _i15;
import 'package:bodobox/ui/views/buy/buy_view.dart' as _i13;
import 'package:bodobox/ui/views/home/home_view.dart' as _i2;
import 'package:bodobox/ui/views/legals/legals_view.dart' as _i14;
import 'package:bodobox/ui/views/listen/listen_view.dart' as _i17;
import 'package:bodobox/ui/views/login/login_view.dart' as _i6;
import 'package:bodobox/ui/views/master/master_view.dart' as _i9;
import 'package:bodobox/ui/views/pagelist/pagelist_view.dart' as _i11;
import 'package:bodobox/ui/views/read/read_view.dart' as _i16;
import 'package:bodobox/ui/views/register/register_view.dart' as _i5;
import 'package:bodobox/ui/views/register_book/register_book_view.dart' as _i10;
import 'package:bodobox/ui/views/settings/settings_view.dart' as _i7;
import 'package:bodobox/ui/views/startup/startup_view.dart' as _i3;
import 'package:bodobox/ui/views/test/test_view.dart' as _i8;
import 'package:bodobox/ui/views/title/title_view.dart' as _i4;
import 'package:bodobox/ui/views/upload_page/upload_page_view.dart' as _i12;
import 'package:bodobox/utils/enums.dart' as _i20;
import 'package:bodobox/utils/models/book_model.dart' as _i19;
import 'package:flutter/material.dart' as _i18;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i21;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const titleView = '/title-view';

  static const registerView = '/register-view';

  static const loginView = '/login-view';

  static const settingsView = '/settings-view';

  static const testView = '/test-view';

  static const masterView = '/master-view';

  static const registerBookView = '/register-book-view';

  static const pagelistView = '/pagelist-view';

  static const uploadPageView = '/upload-page-view';

  static const buyView = '/buy-view';

  static const legalsView = '/legals-view';

  static const bookDetailView = '/book-detail-view';

  static const readView = '/read-view';

  static const listenView = '/listen-view';

  static const all = <String>{
    homeView,
    startupView,
    titleView,
    registerView,
    loginView,
    settingsView,
    testView,
    masterView,
    registerBookView,
    pagelistView,
    uploadPageView,
    buyView,
    legalsView,
    bookDetailView,
    readView,
    listenView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.titleView,
      page: _i4.TitleView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i5.RegisterView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i6.LoginView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i7.SettingsView,
    ),
    _i1.RouteDef(
      Routes.testView,
      page: _i8.TestView,
    ),
    _i1.RouteDef(
      Routes.masterView,
      page: _i9.MasterView,
    ),
    _i1.RouteDef(
      Routes.registerBookView,
      page: _i10.RegisterBookView,
    ),
    _i1.RouteDef(
      Routes.pagelistView,
      page: _i11.PagelistView,
    ),
    _i1.RouteDef(
      Routes.uploadPageView,
      page: _i12.UploadPageView,
    ),
    _i1.RouteDef(
      Routes.buyView,
      page: _i13.BuyView,
    ),
    _i1.RouteDef(
      Routes.legalsView,
      page: _i14.LegalsView,
    ),
    _i1.RouteDef(
      Routes.bookDetailView,
      page: _i15.BookDetailView,
    ),
    _i1.RouteDef(
      Routes.readView,
      page: _i16.ReadView,
    ),
    _i1.RouteDef(
      Routes.listenView,
      page: _i17.ListenView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.TitleView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.TitleView(),
        settings: data,
      );
    },
    _i5.RegisterView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.RegisterView(),
        settings: data,
      );
    },
    _i6.LoginView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.LoginView(),
        settings: data,
      );
    },
    _i7.SettingsView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.SettingsView(),
        settings: data,
      );
    },
    _i8.TestView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.TestView(),
        settings: data,
      );
    },
    _i9.MasterView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.MasterView(),
        settings: data,
      );
    },
    _i10.RegisterBookView: (data) {
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.RegisterBookView(),
        settings: data,
      );
    },
    _i11.PagelistView: (data) {
      final args = data.getArgs<PagelistViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.PagelistView(args.booklink, key: args.key),
        settings: data,
      );
    },
    _i12.UploadPageView: (data) {
      final args = data.getArgs<UploadPageViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.UploadPageView(args.bookLink, key: args.key),
        settings: data,
      );
    },
    _i13.BuyView: (data) {
      final args = data.getArgs<BuyViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i13.BuyView(args.book, args.bookId, key: args.key),
        settings: data,
      );
    },
    _i14.LegalsView: (data) {
      final args = data.getArgs<LegalsViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.LegalsView(args.type, key: args.key),
        settings: data,
      );
    },
    _i15.BookDetailView: (data) {
      final args = data.getArgs<BookDetailViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i15.BookDetailView(args.book, args.bookId, key: args.key),
        settings: data,
      );
    },
    _i16.ReadView: (data) {
      final args = data.getArgs<ReadViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.ReadView(args.bookId, key: args.key),
        settings: data,
      );
    },
    _i17.ListenView: (data) {
      final args = data.getArgs<ListenViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i17.ListenView(args.bookLink, args.book, key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class PagelistViewArguments {
  const PagelistViewArguments({
    required this.booklink,
    this.key,
  });

  final String booklink;

  final _i18.Key? key;

  @override
  String toString() {
    return '{"booklink": "$booklink", "key": "$key"}';
  }

  @override
  bool operator ==(covariant PagelistViewArguments other) {
    if (identical(this, other)) return true;
    return other.booklink == booklink && other.key == key;
  }

  @override
  int get hashCode {
    return booklink.hashCode ^ key.hashCode;
  }
}

class UploadPageViewArguments {
  const UploadPageViewArguments({
    required this.bookLink,
    this.key,
  });

  final String bookLink;

  final _i18.Key? key;

  @override
  String toString() {
    return '{"bookLink": "$bookLink", "key": "$key"}';
  }

  @override
  bool operator ==(covariant UploadPageViewArguments other) {
    if (identical(this, other)) return true;
    return other.bookLink == bookLink && other.key == key;
  }

  @override
  int get hashCode {
    return bookLink.hashCode ^ key.hashCode;
  }
}

class BuyViewArguments {
  const BuyViewArguments({
    required this.book,
    required this.bookId,
    this.key,
  });

  final _i19.BodoBook book;

  final String bookId;

  final _i18.Key? key;

  @override
  String toString() {
    return '{"book": "$book", "bookId": "$bookId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant BuyViewArguments other) {
    if (identical(this, other)) return true;
    return other.book == book && other.bookId == bookId && other.key == key;
  }

  @override
  int get hashCode {
    return book.hashCode ^ bookId.hashCode ^ key.hashCode;
  }
}

class LegalsViewArguments {
  const LegalsViewArguments({
    required this.type,
    this.key,
  });

  final _i20.LegalTexts type;

  final _i18.Key? key;

  @override
  String toString() {
    return '{"type": "$type", "key": "$key"}';
  }

  @override
  bool operator ==(covariant LegalsViewArguments other) {
    if (identical(this, other)) return true;
    return other.type == type && other.key == key;
  }

  @override
  int get hashCode {
    return type.hashCode ^ key.hashCode;
  }
}

class BookDetailViewArguments {
  const BookDetailViewArguments({
    required this.book,
    required this.bookId,
    this.key,
  });

  final _i19.BodoBook book;

  final String bookId;

  final _i18.Key? key;

  @override
  String toString() {
    return '{"book": "$book", "bookId": "$bookId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant BookDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.book == book && other.bookId == bookId && other.key == key;
  }

  @override
  int get hashCode {
    return book.hashCode ^ bookId.hashCode ^ key.hashCode;
  }
}

class ReadViewArguments {
  const ReadViewArguments({
    required this.bookId,
    this.key,
  });

  final String bookId;

  final _i18.Key? key;

  @override
  String toString() {
    return '{"bookId": "$bookId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ReadViewArguments other) {
    if (identical(this, other)) return true;
    return other.bookId == bookId && other.key == key;
  }

  @override
  int get hashCode {
    return bookId.hashCode ^ key.hashCode;
  }
}

class ListenViewArguments {
  const ListenViewArguments({
    required this.bookLink,
    required this.book,
    this.key,
  });

  final String bookLink;

  final _i19.BodoBook book;

  final _i18.Key? key;

  @override
  String toString() {
    return '{"bookLink": "$bookLink", "book": "$book", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ListenViewArguments other) {
    if (identical(this, other)) return true;
    return other.bookLink == bookLink && other.book == book && other.key == key;
  }

  @override
  int get hashCode {
    return bookLink.hashCode ^ book.hashCode ^ key.hashCode;
  }
}

extension NavigatorStateExtension on _i21.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTitleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.titleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.testView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMasterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.masterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterBookView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerBookView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPagelistView({
    required String booklink,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.pagelistView,
        arguments: PagelistViewArguments(booklink: booklink, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUploadPageView({
    required String bookLink,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.uploadPageView,
        arguments: UploadPageViewArguments(bookLink: bookLink, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBuyView({
    required _i19.BodoBook book,
    required String bookId,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.buyView,
        arguments: BuyViewArguments(book: book, bookId: bookId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLegalsView({
    required _i20.LegalTexts type,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.legalsView,
        arguments: LegalsViewArguments(type: type, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBookDetailView({
    required _i19.BodoBook book,
    required String bookId,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.bookDetailView,
        arguments:
            BookDetailViewArguments(book: book, bookId: bookId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToReadView({
    required String bookId,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.readView,
        arguments: ReadViewArguments(bookId: bookId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToListenView({
    required String bookLink,
    required _i19.BodoBook book,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.listenView,
        arguments:
            ListenViewArguments(bookLink: bookLink, book: book, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTitleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.titleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTestView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.testView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMasterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.masterView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterBookView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerBookView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPagelistView({
    required String booklink,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.pagelistView,
        arguments: PagelistViewArguments(booklink: booklink, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUploadPageView({
    required String bookLink,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.uploadPageView,
        arguments: UploadPageViewArguments(bookLink: bookLink, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBuyView({
    required _i19.BodoBook book,
    required String bookId,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.buyView,
        arguments: BuyViewArguments(book: book, bookId: bookId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLegalsView({
    required _i20.LegalTexts type,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.legalsView,
        arguments: LegalsViewArguments(type: type, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBookDetailView({
    required _i19.BodoBook book,
    required String bookId,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.bookDetailView,
        arguments:
            BookDetailViewArguments(book: book, bookId: bookId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithReadView({
    required String bookId,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.readView,
        arguments: ReadViewArguments(bookId: bookId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithListenView({
    required String bookLink,
    required _i19.BodoBook book,
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.listenView,
        arguments:
            ListenViewArguments(bookLink: bookLink, book: book, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
