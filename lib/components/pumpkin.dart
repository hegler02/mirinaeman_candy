import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'candy_catch_game.dart';
import 'player_character.dart';

class Pumpkin extends PositionComponent
    with HasGameReference<CandyCatchGame>, CollisionCallbacks {
  static const double pumpkinSize = 50;
  static const double fallSpeed = 180;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    size = Vector2.all(pumpkinSize);
    anchor = Anchor.center;
    
    // 충돌 감지용 히트박스
    add(CircleHitbox(radius: pumpkinSize / 2));
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // 아래로 떨어지기
    position.y += fallSpeed * dt;
    
    // 화면 밖으로 나가면 생명 감소 후 제거
    if (position.y > game.size.y + pumpkinSize) {
      game.missCandy();
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    final pumpkinRadius = pumpkinSize * 0.45;
    
    // 호박 몸통 (주황색 타원)
    final pumpkinPaint = Paint()
      ..color = const Color(0xFFff8800)
      ..style = PaintingStyle.fill;
    
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: pumpkinRadius * 2,
        height: pumpkinRadius * 1.8,
      ),
      pumpkinPaint,
    );
    
    // 호박 줄무늬 (세로 선)
    final stripePaint = Paint()
      ..color = const Color(0xFFdd6600)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    for (int i = -1; i <= 1; i++) {
      final x = i * pumpkinRadius / 2;
      canvas.drawLine(
        Offset(x, -pumpkinRadius * 0.9),
        Offset(x, pumpkinRadius * 0.9),
        stripePaint,
      );
    }
    
    // 꼭지 (초록색)
    final stemPaint = Paint()
      ..color = const Color(0xFF228800)
      ..style = PaintingStyle.fill;
    
    final stemPath = Path()
      ..moveTo(-3, -pumpkinRadius * 0.9)
      ..lineTo(-2, -pumpkinRadius * 1.2)
      ..lineTo(2, -pumpkinRadius * 1.2)
      ..lineTo(3, -pumpkinRadius * 0.9)
      ..close();
    canvas.drawPath(stemPath, stemPaint);
    
    // 잭오랜턴 얼굴
    final facePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    
    // 왼쪽 눈 (삼각형)
    final leftEyePath = Path()
      ..moveTo(-pumpkinRadius * 0.4, -pumpkinRadius * 0.3)
      ..lineTo(-pumpkinRadius * 0.5, pumpkinRadius * 0.1)
      ..lineTo(-pumpkinRadius * 0.2, pumpkinRadius * 0.1)
      ..close();
    canvas.drawPath(leftEyePath, facePaint);
    
    // 오른쪽 눈 (삼각형)
    final rightEyePath = Path()
      ..moveTo(pumpkinRadius * 0.4, -pumpkinRadius * 0.3)
      ..lineTo(pumpkinRadius * 0.5, pumpkinRadius * 0.1)
      ..lineTo(pumpkinRadius * 0.2, pumpkinRadius * 0.1)
      ..close();
    canvas.drawPath(rightEyePath, facePaint);
    
    // 입 (지그재그 미소)
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    
    final mouthPath = Path()
      ..moveTo(-pumpkinRadius * 0.5, pumpkinRadius * 0.3)
      ..lineTo(-pumpkinRadius * 0.3, pumpkinRadius * 0.5)
      ..lineTo(-pumpkinRadius * 0.1, pumpkinRadius * 0.3)
      ..lineTo(pumpkinRadius * 0.1, pumpkinRadius * 0.5)
      ..lineTo(pumpkinRadius * 0.3, pumpkinRadius * 0.3)
      ..lineTo(pumpkinRadius * 0.5, pumpkinRadius * 0.5);
    canvas.drawPath(mouthPath, mouthPaint);
    
    // 외곽선
    final borderPaint = Paint()
      ..color = const Color(0xFFdd6600)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: pumpkinRadius * 2,
        height: pumpkinRadius * 1.8,
      ),
      borderPaint,
    );
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    
    if (other is PlayerCharacter) {
      game.collectCandy(20); // 호박은 20점!
      removeFromParent();
    }
  }
}
