import 'package:cookie_fly/game/assets.dart';
import 'package:cookie_fly/game/cookie_fly_game.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  final CookieFlyGame game;
  static const String id = 'menu';
  const MenuScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          game.overlays.remove('menu');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.menu), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
