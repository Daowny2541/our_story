/*
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../data/love_questions.dart';
import '../utils/music_player.dart';
import '../utils/question_manager.dart';
import '../utils/time_message.dart';

class SurprisePage extends StatefulWidget {
  const SurprisePage({super.key});

  @override
  State<SurprisePage> createState() => _SurprisePageState();
}

class _SurprisePageState extends State<SurprisePage> {
  bool unlocked = false;

  LoveQuestion? currentQuestion;
  bool answered = false;

  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  // bool isUnlocked = false;


  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  Future<void> _loadQuestion() async {
    final q = await QuestionManager.getRandomQuestion();
    setState(() {
      currentQuestion = q;
      answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (didPop) {
          await QuestionManager.reset();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.pink.shade50,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('เซอร์ไพรส์ 💝'),
        ),
        body: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: unlocked ? _loveMessage() : _lockedView(),
          ),
        ),
      ),
    );
  }

  Widget _lockedView() {
    return Column(
      key: const ValueKey('locked'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.lock, size: 80, color: Colors.pink),
        const SizedBox(height: 16),
        const Text(
          'ยังไม่เปิดนะ 😊 ลองอีกครั้ง',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
          ),
          onPressed: () => setState(() => unlocked = true),
          child: const Text('ปลดล็อก 💌'),
        ),
      ],
    );
  }

  Widget _loveMessage() {
    return Container(
      key: const ValueKey('unlocked'),
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.2),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            getTimeMessage(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          _questionCard(),

          const SizedBox(height: 16),
          musicButton(),
        ],
      ),
    );
  }

  Widget _questionCard() {
    if (currentQuestion == null) {
      MusicPlayer.playSpecial();

      return Column(
        children: const [
          SizedBox(height: 16),
          Text(
            'เราตอบคำถามของเราครบแล้วนะ 💖\nเพลงนี้คือของขวัญจากใจเรา',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    final q = currentQuestion!;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            q.question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...q.answers.map(
                (a) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ElevatedButton(
                onPressed: answered
                    ? null
                    : () async {
                  setState(() => answered = true);
                  await QuestionManager.saveAnswer(q.id);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(q.reply)),
                  );

                  // โหลดคำถามใหม่
                  Future.delayed(const Duration(seconds: 1), _loadQuestion);
                },
                child: Text(a),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget musicButton() {
    if (!unlocked) return const SizedBox(); // ยังไม่ตอบครบ = ไม่ให้เล่น

    return GestureDetector(
      onTap: () async {
        if (_isPlaying) {
          await _player.pause();
        } else {
          await _player.play(
            AssetSource('music/Hers-little_by_little.mp3'),
            volume: 1.0,
          );
        }

        setState(() {
          _isPlaying = !_isPlaying;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _isPlaying ? Colors.pinkAccent : Colors.pink.shade200,
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.4),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          _isPlaying ? Icons.pause : Icons.headphones,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }

}
*/
