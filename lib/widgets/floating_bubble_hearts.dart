import 'dart:math';
import 'package:flutter/material.dart';

import '../data/bubble_heart.dart';
import '../data/heart.dart';

class FloatingBubbleHearts extends StatefulWidget {
  const FloatingBubbleHearts({super.key});

  @override
  State<FloatingBubbleHearts> createState() =>
      _FloatingBubbleHeartsState();
}

class _FloatingBubbleHeartsState extends State<FloatingBubbleHearts>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();
  late List<BubbleHeart> bubbles;

  @override
  void initState() {
    super.initState();

    bubbles = List.generate(50, (_) {
      return BubbleHeart(
        startX: _random.nextDouble(),
        size: 12 + _random.nextDouble() * 26, // เล็ก-ใหญ่
        speed: 0.12 + _random.nextDouble() * 0.18,
        opacity: 0.2 + _random.nextDouble() * 0.35,
        sway: 8 + _random.nextDouble() * 15,
        offset: _random.nextDouble(),

      );
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18), // นุ่มสุด
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            children: bubbles.map((b) {
              /*final progress = (_controller.value + b.speed * _controller.value) % 1;

              // แกว่งซ้ายขวาแบบ sine
              final dx = sin(progress * 2 * pi) * b.sway;

              return Positioned(
                left: size.width * b.startX + dx,
                bottom: (size.height + 100) * progress - 100,
                child: Opacity(
                  opacity: b.opacity * (1 - progress),
                  child: Text(
                    '💗',
                    style: TextStyle(fontSize: b.size),
                  ),
                ),
              );*/
              // final progress = _controller.value;
              final progress = (_controller.value + b.offset) % 1;

              // ความเร็วแต่ละดวง
              final move = progress * b.speed;

              // แกว่งแบบ sine
              final dx = sin(progress * 2 * pi) * b.sway;

              return Positioned(
                left: size.width * b.startX + dx,
                bottom: (size.height + 100) * progress - 100,
                child: Opacity(
                  opacity: (1 - progress) * b.opacity,
                  child: Text(
                    '💗',
                    style: TextStyle(fontSize: b.size),
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

