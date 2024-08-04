import 'package:cookie_fly/game/assets.dart';
import 'package:cookie_fly/game/cookie_fly_game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Background extends SpriteComponent with HasGameRef<CookieFlyGame>{
  Background();

  @override
  Future<void> onLoad() async{
   final background = await Flame.images.load(Assets.background);
    size = gameRef.size;
    sprite = Sprite(background);

  }
}