import 'package:flutter_test/flutter_test.dart';
import 'package:bodobox/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('UpdateNameSheetModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}