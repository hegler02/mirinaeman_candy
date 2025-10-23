import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Halloween Candy Catch game smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const HalloweenCandyCatchApp());
    
    // 메인 화면 확인
    expect(find.text('할로윈'), findsOneWidget);
    expect(find.text('캔디 캐치'), findsOneWidget);
    expect(find.text('게임 시작'), findsOneWidget);
  });
}
