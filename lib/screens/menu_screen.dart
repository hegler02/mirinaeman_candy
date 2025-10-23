import 'package:flutter/material.dart';
import 'game_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // PC에서 모바일 화면 크기로 중앙 배치 (450x932px)
    return Scaffold(
      body: Center(
        child: Container(
          width: 450,
          height: 932,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey[800]!, width: 8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1a0033),
                    Color(0xFF330066),
                    Color(0xFF1a0033),
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 타이틀
                    const Text(
                      '🎃',
                      style: TextStyle(fontSize: 80),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '할로윈',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(3, 3),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      '캔디 캐치',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.orange,
                            offset: Offset(2, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    
                    // 시작 버튼
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                      ),
                      child: const Text(
                        '게임 시작',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // 게임 설명
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '🍭 조작 방법',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'PC: 방향키 ← →\n모바일: 화면 터치',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            '캔디를 받아 점수를 올리세요!\n생명 3개, 놓치면 -1',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 60),
                    
                    // 개발자 정보
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            '개발자',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '미리내맨 김준호',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withValues(alpha: 0.9),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '동서울대학교 전기공학과',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
