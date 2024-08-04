import 'package:cookie_fly/components/background.dart';
import 'package:cookie_fly/components/cookie.dart';
import 'package:cookie_fly/components/ground.dart';
import 'package:cookie_fly/components/pipe_group.dart';
import 'package:cookie_fly/game/config_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:flutter/material.dart';

class CookieFlyGame extends FlameGame with TapDetector, HasCollisionDetection {
  CookieFlyGame();

  late Cookie cookie;
  late TextComponent score;
  Timer interval = Timer(ConfigGame.pipeInterval, repeat: true);

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      score = buildScore(),
      Ground(),
      cookie = Cookie(),
    ]);

    interval.onTick = () => add(PipeGroup());
  }

  TextComponent buildScore() {
    return TextComponent(
      text: 'Pontos: 0',
      position: Vector2(size.x / 2, size.y / 2 * 0.2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Game'),
      ),
      priority: 10,
    );
  }

  @override
  void onTap() {
    super.onTap();
    cookie.fly();
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);

    score.text = 'Pontos: ${cookie.score}';
  }

  void resetPipes() {
    children.whereType<PipeGroup>().toList().forEach(remove);
  }
}
