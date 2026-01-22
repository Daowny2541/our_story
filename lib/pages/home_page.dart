import 'package:flutter/material.dart';
import '../widgets/love_card.dart';
import '../widgets/floating_heart.dart';
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
