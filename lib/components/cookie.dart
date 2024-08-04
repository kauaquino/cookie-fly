import 'package:cookie_fly/components/ground.dart';
import 'package:cookie_fly/components/pipe.dart';
import 'package:cookie_fly/game/assets.dart';
import 'package:cookie_fly/game/config_game.dart';
import 'package:cookie_fly/game/cookie_fly_game.dart';
import 'package:cookie_fly/game/cookie_moviment.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/extensions.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class Cookie extends SpriteGroupComponent<CookieMoviment>
    with HasGameRef<CookieFlyGame>, CollisionCallbacks {
  Cookie();

  bool collisionInGround = false;
  int score = 0;

  @override
  Future<void> onLoad() async {

    //Animações futuras
    final cookie = await gameRef.loadSprite(Assets.cookie);
    final cookieUp = await gameRef.loadSprite(Assets.cookie);
    final cookieBottom = await gameRef.loadSprite(Assets.cookie);

    size = Vector2(50, 50);
    current = CookieMoviment.middle;
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    sprites = {
      CookieMoviment.middle: cookie,
      CookieMoviment.up: cookieUp,
      CookieMoviment.down: cookieBottom,
    };

    add(CircleHitbox());
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, ConfigGame.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        onComplete: () => current = CookieMoviment.down,
      ),
    );

    current = CookieMoviment.up;
    FlameAudio.play(Assets.flying);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!collisionInGround) {
      position.y += ConfigGame.cookieVelocity * dt;
    }

    if (position.y < 1) {
      gameOver();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Pipe) {
      gameOver();
    }

    if (other is Ground) {
      collisionInGround = true;
      current = CookieMoviment.middle;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (other is Ground) {
      collisionInGround = false;
    }
  }

  void gameOver() {
    FlameAudio.play(Assets.collision);
    gameRef.overlays.add('gameOver');
  }

  void reset() {
    current = CookieMoviment.middle;
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
  }
}
