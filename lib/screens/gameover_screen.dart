import 'package:cookie_fly/game/assets.dart';
import 'package:cookie_fly/game/cookie_fly_game.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameOverScreen extends StatefulWidget {
  final CookieFlyGame game;
  static const String id = 'gameOver';

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  _GameOverScreenState createState() => _GameOverScreenState();
}

class _GameOverScreenState extends State<GameOverScreen> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  /// Loads a banner ad.
  void _loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: '', 
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.game.pauseEngine();

    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pontos: ${widget.game.cookie.score}',
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontFamily: 'Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                reiniciar();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(203, 77, 186, 1)),
              child: const Text(
                'Reiniciar',
                style: TextStyle(
                    fontSize: 20, color: Colors.white, fontFamily: 'Game'),
              ),
            ),
            const SizedBox(height: 30),
            if (_bannerAd != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void reiniciar() {
    widget.game.cookie.reset();
    widget.game.overlays.remove('gameOver');
    widget.game.resetPipes();
    widget.game.resumeEngine();
    widget.game.cookie.score = 0;
  }
}
