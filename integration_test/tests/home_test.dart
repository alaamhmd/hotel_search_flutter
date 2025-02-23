import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import '../pages/home_page.dart';
import 'package:hotel_booking/main.dart' as app;

void main() {
  late HomePage homePage;

  setUp(() async {
    await GetIt.I
        .reset(dispose: true); // Fully reset and dispose registered instances
    app.main();
  });

  group('Home Page Widget Tests', () {
    testWidgets('Verify presence of all tabs', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      homePage = HomePage(tester);

      // Verify each tab is visible
      expect(await homePage.verifyHotelIconVisibility(), true);
      expect(await homePage.verifyAccountIconVisibility(), true);
      expect(await homePage.verifyOverviewIconVisibility(), true);
      expect(await homePage.verifyFavoritesIconVisibility(), true);
    });

    testWidgets('Tap on Hotels tab', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      homePage = HomePage(tester);

      // Verify search icon visibility
      expect(await homePage.verifySearchIconVisibility(), true);
    });
  });
}
