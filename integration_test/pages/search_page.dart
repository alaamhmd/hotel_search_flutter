import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import '../test_utils/reusableActions.dart';

class SearchPage {
  final WidgetTester tester;

  SearchPage(this.tester);

  final searchBox = find.byKey(const Key('searchBox'));
  final hotelFavoriteIcon = find.byKey(const Key('favorite'));
  final clearIcon = find.byKey(const Key('clear'));
  final searchDefaultPage = find.byKey(const Key('searchDefaultPage'));

  Finder get hotelsIcon => find.text('Hotels');

  Finder get pyramidsHotel => find.text('Pyramids Power Inn');


  // Actions
  Future<void> enterSearchQuery(String query) async {
    await typeIntoTextBox(query, searchBox, tester);
  }

  Future<void> tapHotelsIcon() async {
    await waitForElement(tester, hotelsIcon);
    await tapOnElement(tester, hotelsIcon);
  }

  Future<void> tapSearchButton() async {
    await tester.pumpAndSettle();
  }

  // Verifications

  Future<bool> verifySearchResults() async {
    await tapHotelsIcon();
    await tapSearchButton();
    await enterSearchQuery('egypt');
    await checkElementExists(tester, pyramidsHotel);
    return await checkElementExists(
        tester, pyramidsHotel);
  }

  Future<bool> verifyClearSearch() async {
    await verifySearchResults();
    await tapOnElement(tester, clearIcon);
    return await checkElementExists(
        tester, pyramidsHotel);
  }
}
