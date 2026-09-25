import 'package:flutter_test/flutter_test.dart';
import 'package:contigo/main.dart';

void main() {
  testWidgets('ContiGO onboarding shows brand', (tester) async {
    await tester.pumpWidget(const ContigoApp());
    expect(find.text('ContiGO'), findsOneWidget);
    expect(find.textContaining('Lo demás se aprende'), findsOneWidget);
  });
}
