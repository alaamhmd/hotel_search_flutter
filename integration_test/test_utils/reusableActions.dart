import 'package:flutter_test/flutter_test.dart';

Future<void> waitForElement(
    WidgetTester tester,
    Finder element, {
      Duration timeout = const Duration(seconds: 10),
      Duration interval = const Duration(milliseconds: 500),
    }) async {
  final endTime = DateTime.now().add(timeout);

  while (DateTime.now().isBefore(endTime)) {
    await tester.pumpAndSettle();

    if (element
        .evaluate()
        .isNotEmpty) {
      return; // means element found
    }

    await Future.delayed(interval); // Retry after the interval
  }

  // Throw error if the element is not found within the timeout
  throw TestFailure(
    'Element not found within ${timeout.inSeconds} seconds: $element',
  );
}
  //  Check if an element exists
  Future<bool> checkElementExists(WidgetTester tester, Finder element) async {
    await tester.pumpAndSettle(); // Wait for UI to stabilize
    return element
        .evaluate()
        .isNotEmpty;
  }

  //  Tap on an element after confirming it exists
  Future<void> tapOnElement(WidgetTester tester, Finder element) async {
    bool exists = await checkElementExists(tester, element);

    if (exists) {
      await tester.tap(element);
      await tester.pumpAndSettle(); // Wait for animations to complete
    } else {
      throw Exception("Element not found: $element");
    }
  }

Future<void> typeIntoTextBox(String searchText, Finder locator, WidgetTester tester) async {
  await waitForElement(tester, locator);
  await tester.enterText(locator, searchText);
  await tester.pumpAndSettle();
}

Future<void> waitFor(int milliseconds) async {
  await Future.delayed(Duration(milliseconds: milliseconds));
}



