import 'package:flutter/material.dart';

class FloatingHeart extends StatefulWidget {
  const FloatingHeart({super.key});

  @override
  State<FloatingHeart> createState() => _FloatingHeartState();
}

class _FloatingHeartState extends State<FloatingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: -200).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) {
        return Positioned(
          bottom: 100 + animation.value,
          left: MediaQuery.of(context).size.width / 2 - 20,
          child: Opacity(
            opacity: 1 - controller.value,
            child: const Text(
              '❤️',
              style: TextStyle(fontSize: 40),
            ),
          ),
        );
      },
    );
  }
}
