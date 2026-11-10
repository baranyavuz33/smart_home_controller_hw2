import 'package:flutter_test/flutter_test.dart';

import 'package:smart_home_controller/main.dart';

void main() {
  testWidgets('Smart Home Controller smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SmartHomeApp());
    expect(find.text('Smart Home Controller'), findsOneWidget);
  });
}
