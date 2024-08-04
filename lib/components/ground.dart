import 'package:cookie_fly/game/assets.dart';
import 'package:cookie_fly/game/config_game.dart';
import 'package:cookie_fly/game/cookie_fly_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';

class Ground extends ParallaxComponent<CookieFlyGame> with HasGameRef<CookieFlyGame>{
  Ground();

  @override
  Future<void> onLoad() async{
    final ground = await Flame.images.load(Assets.ground);
    parallax =  Parallax([
        ParallaxLayer(
          ParallaxImage(ground, fill: LayerFill.none)
        )
    ]);

    add(
      RectangleHitbox(
        position: Vector2(0, gameRef.size.y - ConfigGame.groundHeight),
        size: Vector2(gameRef.size.x, ConfigGame.groundHeight),
      )
    );
  }

  @override 
  void update(double dt){
    super.update(dt);
    parallax?.baseVelocity.x = ConfigGame.gameSpeed;
  }
}