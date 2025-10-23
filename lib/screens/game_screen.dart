import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../components/candy_catch_game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late CandyCatchGame game;

  @override
  void initState() {
    super.initState();
    game = CandyCatchGame(context: context);
  }

  @override
  Widget build(BuildContext context) {
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
            child: GameWidget(game: game),
          ),
        ),
      ),
    );
  }
}
