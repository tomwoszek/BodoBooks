import 'package:bodobox/services/prefs_service.dart';
import 'package:bodobox/services/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:bodobox/app/app.bottomsheets.dart';
import 'package:bodobox/app/app.dialogs.dart';
import 'package:bodobox/app/app.locator.dart';
import 'package:bodobox/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeService.appThemeLight,
      darkTheme: ThemeService.appThemeLight,
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
