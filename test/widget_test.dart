import 'package:flutter_test/flutter_test.dart';
import 'package:contigo/main.dart';

void main() {
  testWidgets('ContiGO splash shows brand', (tester) async {
    await tester.pumpWidget(const ContigoApp());
    expect(find.text('ContiGO'), findsOneWidget);
    expect(
      find.text('Conecta ideas. Encuentra personas. Crea juntos.'),
      findsOneWidget,
    );
  });
}
