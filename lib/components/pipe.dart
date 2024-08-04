import 'package:cookie_fly/game/assets.dart';
import 'package:cookie_fly/game/config_game.dart';
import 'package:cookie_fly/game/cookie_fly_game.dart';
import 'package:cookie_fly/game/pipe_position.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Pipe extends SpriteComponent with HasGameRef<CookieFlyGame> {
  Pipe({
    required this.pipePosition,
    required this.height,
  });

  @override
  final double height;
  final PipePosition pipePosition;

  Future<void> onLoad() async {
    final pipe = await Flame.images.load(Assets.pipe);
    final pipeRotated = await Flame.images.load(Assets.pipeRotated);
    size = Vector2(50, height);

    switch (pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.bottom:
        position.y = gameRef.size.y - size.y - ConfigGame.groundHeight;
        sprite = Sprite(pipe);
        break;
    }
    
    add(RectangleHitbox());
  }
}
