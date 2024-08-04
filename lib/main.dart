import 'package:cookie_fly/game/cookie_fly_game.dart';
import 'package:cookie_fly/screens/gameover_screen.dart';
import 'package:cookie_fly/screens/menu_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Importar para verificar a plataforma

void main() {
  final game = CookieFlyGame();

  Widget gameWidget = GameWidget(
    game: game,
    initialActiveOverlays: const [MenuScreen.id],
    overlayBuilderMap: {
      'menu': (context, _) => MenuScreen(game: game),
      'gameOver': (context, _) => GameOverScreen(game: game)
    },
  );

  if (kIsWeb) {
    gameWidget = Container(
      decoration: BoxDecoration(color: Colors.black),
      child: Center(
        child: Container(
          width: 512,
          height: 1024,
          child: gameWidget,
        ),
      ),
    );
  }

  runApp(MaterialApp(
    home: Scaffold(
      body: gameWidget,
    ),
  ));
}
