import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'candy_catch_game.dart';
import 'player_character.dart';

class Candy extends PositionComponent
    with HasGameReference<CandyCatchGame>, CollisionCallbacks {
  static const double candySize = 40;
  static const double fallSpeed = 200;
  
  late Color candyColor;
  late Color stripeColor;
  final Random random = Random();
  
  // 6가지 랜덤 색상
  static const List<List<Color>> colorPairs = [
    [Color(0xFFff0066), Color(0xFFffccdd)], // 핑크
    [Color(0xFF00ccff), Color(0xFFccf0ff)], // 하늘색
    [Color(0xFF00ff66), Color(0xFFccffdd)], // 초록
    [Color(0xFFffcc00), Color(0xFFfff4cc)], // 노랑
    [Color(0xFFff6600), Color(0xFFffddcc)], // 주황
    [Color(0xFFcc00ff), Color(0xFFf0ccff)], // 보라
  ];

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // 랜덤 색상 선택
    final colorPair = colorPairs[random.nextInt(colorPairs.length)];
    candyColor = colorPair[0];
    stripeColor = colorPair[1];
    
    size = Vector2.all(candySize);
    anchor = Anchor.center;
    
    // 충돌 감지용 히트박스
    add(CircleHitbox(radius: candySize / 2));
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    // 아래로 떨어지기
    position.y += fallSpeed * dt;
    
    // 화면 밖으로 나가면 생명 감소 후 제거
    if (position.y > game.size.y + candySize) {
      game.missCandy();
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // 막대사탕 동그란 부분 (나선 무늬)
    final candyCircleRadius = candySize * 0.4;
    
    // 배경 원
    final bgPaint = Paint()
      ..color = stripeColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, candyCircleRadius, bgPaint);
    
    // 나선 무늬 (여러 개의 곡선 띠)
    final spiralPaint = Paint()
      ..color = candyColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    
    for (int i = 0; i < 8; i++) {
      final angle = (i * pi / 4);
      final startX = cos(angle) * candyCircleRadius;
      final startY = sin(angle) * candyCircleRadius;
      
      final path = Path()
        ..moveTo(0, 0)
        ..quadraticBezierTo(
          startX / 2,
          startY / 2,
          startX,
          startY,
        );
      canvas.drawPath(path, spiralPaint);
    }
    
    // 외곽선
    final borderPaint = Paint()
      ..color = candyColor.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset.zero, candyCircleRadius, borderPaint);
    
    // 막대기 부분
    final stickPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    final stickRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(0, candyCircleRadius + 10),
        width: 4,
        height: 20,
      ),
      const Radius.circular(2),
    );
    canvas.drawRRect(stickRect, stickPaint);
    
    // 막대기 테두리
    final stickBorderPaint = Paint()
      ..color = Colors.grey[400]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(stickRect, stickBorderPaint);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    
    if (other is PlayerCharacter) {
      game.collectCandy(10);
      removeFromParent();
    }
  }
}
