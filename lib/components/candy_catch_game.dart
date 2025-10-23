import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'player_character.dart';
import 'candy.dart';
import 'pumpkin.dart';

class CandyCatchGame extends FlameGame
    with KeyboardEvents, TapDetector, HasCollisionDetection {
  final BuildContext context;
  
  late PlayerCharacter player;
  late TextComponent scoreText;
  late TextComponent livesText;
  
  int score = 0;
  int lives = 3;
  double spawnTimer = 0;
  double spawnInterval = 1.5;
  final Random random = Random();
  
  late AudioPlayer bgmPlayer;
  late AudioPlayer sfxPlayer;
  bool isBgmPlaying = false;

  CandyCatchGame({required this.context});

  @override
  Color backgroundColor() => const Color(0xFF1a0033);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // 배경음악 초기화 및 재생
    try {
      bgmPlayer = AudioPlayer();
      await bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await bgmPlayer.play(AssetSource('audio/halloween_bgm.mp3'));
      await bgmPlayer.setVolume(0.3);
      isBgmPlaying = true;
    } catch (e) {
      if (kDebugMode) {
        debugPrint('배경음악 재생 실패: $e');
      }
    }

    // 플레이어 캐릭터 생성
    player = PlayerCharacter()
      ..position = Vector2(size.x / 2, size.y - 120);
    await add(player);

    // 점수 텍스트
    scoreText = TextComponent(
      text: '점수: $score',
      position: Vector2(20, 40),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
    await add(scoreText);

    // 생명 텍스트
    livesText = TextComponent(
      text: '❤️ $lives',
      position: Vector2(size.x - 100, 40),
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
    await add(livesText);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 난이도 자동 증가 (점수가 높을수록 스폰 간격 감소)
    spawnInterval = max(0.5, 1.5 - (score / 50));

    // 캔디/호박 스폰
    spawnTimer += dt;
    if (spawnTimer >= spawnInterval) {
      spawnTimer = 0;
      _spawnFallingObject();
    }

    // 생명이 0이 되면 게임 오버
    if (lives <= 0) {
      gameOver();
    }
  }

  void _spawnFallingObject() {
    final x = random.nextDouble() * (size.x - 60) + 30;

    // 30% 확률로 호박, 70% 확률로 캔디
    if (random.nextDouble() < 0.3) {
      // 호박 생성
      final pumpkin = Pumpkin()..position = Vector2(x, -50);
      add(pumpkin);
    } else {
      // 캔디 생성
      final candy = Candy()..position = Vector2(x, -50);
      add(candy);
    }
  }

  void collectCandy(int points) async {
    score += points;
    scoreText.text = '점수: $score';
    
    // 캔디 수집 효과음 재생
    try {
      sfxPlayer = AudioPlayer();
      await sfxPlayer.play(AssetSource('audio/candy_collect.mp3'));
      await sfxPlayer.setVolume(0.5);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('캔디 수집 효과음 재생 실패: $e');
      }
    }
  }

  void missCandy() async {
    lives--;
    livesText.text = '❤️ $lives';
    
    // 캔디 놓침 효과음 재생
    try {
      sfxPlayer = AudioPlayer();
      await sfxPlayer.play(AssetSource('audio/candy_miss.mp3'));
      await sfxPlayer.setVolume(0.5);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('캔디 놓침 효과음 재생 실패: $e');
      }
    }
  }

  void gameOver() async {
    pauseEngine();
    
    // 배경음악 정지
    if (isBgmPlaying) {
      bgmPlayer.stop();
      isBgmPlaying = false;
    }
    
    // 게임오버 효과음 재생
    try {
      sfxPlayer = AudioPlayer();
      await sfxPlayer.play(AssetSource('audio/game_over.mp3'));
      await sfxPlayer.setVolume(0.6);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('게임오버 효과음 재생 실패: $e');
      }
    }

    // BuildContext가 여전히 마운트되어 있는지 확인
    if (!context.mounted) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1a0033),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.orange, width: 3),
          ),
          title: const Text(
            '게임 오버!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '🎃',
                style: TextStyle(fontSize: 60),
              ),
              const SizedBox(height: 20),
              Text(
                '최종 점수',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 18,
                ),
              ),
              Text(
                '$score',
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  '메인으로',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        player.moveLeft();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        player.moveRight();
      }
    }

    return KeyEventResult.handled;
  }

  @override
  void onTapDown(TapDownInfo info) {
    final tapX = info.eventPosition.global.x;
    final centerX = size.x / 2;

    if (tapX < centerX) {
      player.moveLeft();
    } else {
      player.moveRight();
    }
  }

  @override
  void onRemove() {
    if (isBgmPlaying) {
      bgmPlayer.stop();
      bgmPlayer.dispose();
    }
    super.onRemove();
  }
}
