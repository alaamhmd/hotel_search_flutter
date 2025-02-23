import 'package:flutter_test/flutter_test.dart';
import '../test_utils/reusableActions.dart';
import 'search_page.dart';

class HomePage {
  final WidgetTester tester;
  late SearchPage searchPage;

  HomePage(this.tester) {
    searchPage = SearchPage(tester);
  }

  // Locators
  Finder get hotelsIcon => find.text('Hotels');
  Finder get favoritesIcon => find.text('Favorites');
  Finder get overviewIcon => find.text('Overview');
  Finder get accountIcon => find.text('Account');

  // Actions
  Future<void> tapHotelsIcon() async {
    await tapOnElement(tester, hotelsIcon);
  }

  // Verifications

  // Function to wait and check element visibility
  Future<bool> verifyHotelIconVisibility() async {
    await waitForElement(tester, hotelsIcon);
    return await checkElementExists(tester, hotelsIcon);
  }

  Future<bool> verifyAccountIconVisibility() async {
    await waitForElement(tester, accountIcon);
    return await checkElementExists(
        tester, accountIcon);
  }

  Future<bool> verifyOverviewIconVisibility() async {
    await waitForElement(
        tester, overviewIcon);
    return await checkElementExists(
        tester, overviewIcon);
  }

  Future<bool> verifyFavoritesIconVisibility() async {
    await waitForElement(
        tester, favoritesIcon);
    return await checkElementExists(
        tester, favoritesIcon);
  }

  Future<bool> verifySearchIconVisibility() async {
    await tapHotelsIcon();
    await waitForElement(
        tester, searchPage.searchBox);
    return await checkElementExists(
        tester, searchPage.searchBox);
  }
}
