import 'dart:math';

import 'package:cookie_fly/components/pipe.dart';
import 'package:cookie_fly/game/assets.dart';
import 'package:cookie_fly/game/config_game.dart';
import 'package:cookie_fly/game/cookie_fly_game.dart';
import 'package:cookie_fly/game/pipe_position.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class PipeGroup extends PositionComponent with HasGameRef<CookieFlyGame> {
  PipeGroup();

  final _random = Random();

  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightExceptGround = gameRef.size.y - ConfigGame.groundHeight;
    final spacing = 100 + _random.nextDouble() * (heightExceptGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightExceptGround - spacing);

    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2),
      Pipe(
          pipePosition: PipePosition.bottom,
          height: heightExceptGround - (centerY + spacing / 2)),
    ]);
  }

  void updateScore(){
    gameRef.cookie.score += 1;
    FlameAudio.play(Assets.point);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= ConfigGame.gameSpeed * dt;

    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }
  }
}
