import 'package:flutter/material.dart';
import 'package:our_story/widgets/floating_bubble_hearts.dart';
import '../widgets/floating_hearts_background.dart';
import '../widgets/love_card.dart';
import '../widgets/floating_heart.dart';
import '../widgets/love_music_button.dart';
import 'surprise_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showHeart = false;

  void _openSurprise() {
    setState(() => showHeart = true);

    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SurprisePage()),
      );
      setState(() => showHeart = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Stack(
        children: [
          /// 🌈 พื้นหลังไล่สี
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFE4EC),
                  Color(0xFFFFF1F6),
                ],
              ),
            ),
          ),

          /// 💖 หัวใจลอย
          const FloatingBubbleHearts(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: LoveCard(onPressed: _openSurprise),
            ),
          ),
          if (showHeart) const FloatingHeart(),
        ],
      ),
    );
  }
}
