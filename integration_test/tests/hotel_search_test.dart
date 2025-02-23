import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import '../pages/search_page.dart';
import 'package:hotel_booking/main.dart' as app;

void main() {
  late SearchPage searchPage;

  setUp(() async {
    await GetIt.I
        .reset(dispose: true); // Fully reset and dispose registered instances
    app.main();
  });

  group('Search Page Widget Tests', () {
    testWidgets('Verify Search Results', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      searchPage = SearchPage(tester);
      expect(await searchPage.verifySearchResults(), true);
    });
    testWidgets('Verify Clear Results', (WidgetTester tester) async {
      await tester.pumpAndSettle();
      searchPage = SearchPage(tester);
      expect(await searchPage.verifyClearSearch(), false);
    });
  });
}
