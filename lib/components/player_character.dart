import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlayerCharacter extends PositionComponent with HasGameReference {
  static const double moveSpeed = 400;
  static const double playerSize = 80;
  
  Vector2 velocity = Vector2.zero();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // 충돌 감지용 히트박스
    final hitbox = RectangleHitbox(
      size: Vector2(playerSize, playerSize),
    );
    add(hitbox);
    
    size = Vector2(playerSize, playerSize);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // 위치 업데이트
    position += velocity * dt;
    
    // 화면 경계 체크
    if (position.x < playerSize / 2) {
      position.x = playerSize / 2;
    } else if (position.x > game.size.x - playerSize / 2) {
      position.x = game.size.x - playerSize / 2;
    }
    
    // 속도 감소 (부드러운 이동)
    velocity *= 0.9;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // 마법사 모자 (파란색 뾰족한 모자)
    final hatPaint = Paint()
      ..color = const Color(0xFF0066ff)
      ..style = PaintingStyle.fill;
    
    final hatPath = Path()
      ..moveTo(-playerSize / 2, -playerSize / 4)
      ..lineTo(0, -playerSize / 1.5)
      ..lineTo(playerSize / 2, -playerSize / 4)
      ..close();
    canvas.drawPath(hatPath, hatPaint);
    
    // 모자 테두리
    final hatBorderPaint = Paint()
      ..color = const Color(0xFF0044cc)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(hatPath, hatBorderPaint);
    
    // 모자 별 장식
    final starPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, -playerSize / 2), 5, starPaint);
    
    // 얼굴 (둥근 원)
    final facePaint = Paint()
      ..color = const Color(0xFFffdbac)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(0, 0), playerSize / 3, facePaint);
    
    // 눈
    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(-playerSize / 8, -5), 4, eyePaint);
    canvas.drawCircle(Offset(playerSize / 8, -5), 4, eyePaint);
    
    // 미소
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    
    final smilePath = Path()
      ..moveTo(-playerSize / 6, 5)
      ..quadraticBezierTo(0, playerSize / 6, playerSize / 6, 5);
    canvas.drawPath(smilePath, smilePaint);
    
    // 몸통 (파란색 로브)
    final bodyPaint = Paint()
      ..color = const Color(0xFF0066ff)
      ..style = PaintingStyle.fill;
    
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(0, playerSize / 3),
        width: playerSize / 1.5,
        height: playerSize / 2,
      ),
      const Radius.circular(10),
    );
    canvas.drawRRect(bodyRect, bodyPaint);
    
    // 'M' 로고
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'M',
        style: TextStyle(
          color: Colors.lightBlue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, playerSize / 3 - textPainter.height / 2),
    );
  }

  void moveLeft() {
    velocity.x = -moveSpeed;
  }

  void moveRight() {
    velocity.x = moveSpeed;
  }
}
