import 'package:flutter/material.dart';
import '../utils/music_player.dart';

class LoveMusicButton extends StatefulWidget {
  const LoveMusicButton({super.key});

  @override
  State<LoveMusicButton> createState() => _LoveMusicButtonState();
}

class _LoveMusicButtonState extends State<LoveMusicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller,
      child: GestureDetector(
        onTap: () async {
          if (MusicPlayer.isPlaying) {
            await MusicPlayer.pause();
          } else {
            await MusicPlayer.playNormal();
          }
          setState(() {});
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.pink.shade100,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            MusicPlayer.isPlaying ? Icons.pause : Icons.headphones,
            color: Colors.pink.shade700,
          ),
        ),
      ),
    );
  }
}
