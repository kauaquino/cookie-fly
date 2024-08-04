import 'package:cookie_fly/game/assets.dart';
import 'package:cookie_fly/game/cookie_fly_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final CookieFlyGame game;
  static const String id = 'gameOver';
  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pontos: ${game.cookie.score}',
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontFamily: 'Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                reiniciar();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(203, 77, 186, 1)),
              child: const Text(
                'Reiniciar',
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontFamily: 'Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void reiniciar() {
    game.cookie.reset();
    game.overlays.remove('gameOver');
    game.resetPipes();
    game.resumeEngine();
    game.cookie.score = 0;
  }
}
