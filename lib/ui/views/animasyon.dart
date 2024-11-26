import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:urunler/ui/views/anasayfa.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // AnimationController'ı oluşturuyoruz
    _controller = AnimationController(vsync: this);
    // Animasyon bittiğinde başka sayfaya geçiş
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Anasayfa()),
        );
      }
    });
  }

  @override
  void dispose() {
    // AnimationController'ı serbest bırakıyoruz
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'lib/assets/animations/animation.json',
          controller: _controller,
          onLoaded: (composition) {
            // AnimationController'ın süresini ayarlıyoruz
            _controller.duration = composition.duration;
            _controller.forward(); // Animasyonu başlatıyoruz
          },
        ),
      ),
    );
  }
}


