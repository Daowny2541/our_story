import 'dart:math';
import 'package:flutter/material.dart';

import '../data/heart.dart';

class FloatingHeartsBackground extends StatefulWidget {
  const FloatingHeartsBackground({super.key});

  @override
  State<FloatingHeartsBackground> createState() =>
      _FloatingHeartsBackgroundState();
}

class _FloatingHeartsBackgroundState extends State<FloatingHeartsBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  late List<Heart> hearts;

  @override
  void initState() {
    super.initState();

    hearts = List.generate(12, (_) {
      return Heart(
        x: _random.nextDouble(),
        size: 14 + _random.nextDouble() * 18,
        speed: 0.15 + _random.nextDouble() * 0.2, // 🔻 ช้ามาก
        opacity: 0.25 + _random.nextDouble() * 0.35,
      );
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30), // 🔻 ยาวขึ้น = ช้าลง
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            children: hearts.map((heart) {
              final progress =
                  (_controller.value * heart.speed) % 1;

              return Positioned(
                left: width * heart.x,
                bottom: height * progress - 50,
                child: Opacity(
                  opacity: heart.opacity,
                  child: Text(
                    '💗',
                    style: TextStyle(fontSize: heart.size),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
