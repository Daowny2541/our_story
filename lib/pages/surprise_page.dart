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

class _SurprisePageState extends State<SurprisePage> with SingleTickerProviderStateMixin {
  bool unlocked = false;
  LoveQuestion? currentQuestion;
  bool answered = false;
  bool _isMusicPlaying = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _loadQuestion();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _loadQuestion() async {
    final q = await QuestionManager.getRandomQuestion();
    if (q == null) {
      // ตอบครบแล้ว! เริ่มเล่นเพลงพิเศษโดยอัตโนมัติ
      await MusicPlayer.playSpecial();
      if (mounted) {
        setState(() {
          currentQuestion = null;
          _isMusicPlaying = true;
        });
        _pulseController.repeat();
      }
    } else {
      if (mounted) {
        setState(() {
          currentQuestion = q;
          answered = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          // หยุดเพลงเมื่อออกจากหน้า
          await MusicPlayer.pause();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.pink.shade50,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('เซอร์ไพรส์ 💝', style: TextStyle(color: Colors.pink)),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.pink),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
        // ใช้รูปภาพแทน Icon
        Image.asset(
          'assets/image/love.png',
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16),
        const Text(
          'มีบางอย่างรอคุณอยู่... 💌',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 5,
          ),
          onPressed: () => setState(() => unlocked = true),
          child: const Text('เปิดดูเลย ✨', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  Widget _loveMessage() {
    return SingleChildScrollView(
      child: Container(
        key: const ValueKey('unlocked'),
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.favorite, color: Colors.pink, size: 40),
            const SizedBox(height: 20),
            Text(
              getTimeMessage(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 10),
            _questionCard(),
            const SizedBox(height: 30),
            if (currentQuestion == null) musicButton(),
          ],
        ),
      ),
    );
  }

  Widget _questionCard() {
    if (currentQuestion == null) {
      return Column(
        children: const [
          Divider(height: 40),
          Text(
            'เย้! ตอบครบทุกข้อแล้วนะ 💖',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.pink,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'เพลงพิเศษนี้มอบให้คุณคนเดียว\nลองกดฟังดูนะ...',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
          ),
        ],
      );
    }

    final q = currentQuestion!;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.pink.shade50.withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.pink.shade100),
      ),
      child: Column(
        children: [
          Text(
            q.question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.pink,
            ),
          ),
          const SizedBox(height: 20),
          ...q.answers.map(
            (a) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.pink,
                    elevation: 0,
                    side: const BorderSide(color: Colors.pinkAccent),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: answered
                      ? null
                      : () async {
                          setState(() => answered = true);
                          await QuestionManager.saveAnswer(q.id);

                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(q.reply),
                                backgroundColor: Colors.pinkAccent,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }

                          Future.delayed(const Duration(seconds: 1), _loadQuestion);
                        },
                  child: Text(a, style: const TextStyle(fontSize: 15)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget musicButton() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            if (_isMusicPlaying) {
              await MusicPlayer.pause();
              _pulseController.stop();
            } else {
              await MusicPlayer.playSpecial();
              _pulseController.repeat();
            }
            setState(() {
              _isMusicPlaying = MusicPlayer.isPlaying;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pulse Effect
              if (_isMusicPlaying)
                ...List.generate(3, (index) => AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final progress = (_pulseController.value + (index * 0.33)) % 1.0;
                    return Container(
                      width: 70 + (progress * 50),
                      height: 70 + (progress * 50),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.pink.withOpacity(0.3 * (1 - progress)),
                      ),
                    );
                  },
                )),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: _isMusicPlaying
                        ? [Colors.pinkAccent, Colors.pink]
                        : [Colors.pink.shade200, Colors.pink.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  _isMusicPlaying ? Icons.pause_rounded : Icons.headphones_rounded,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _isMusicPlaying ? 'กำลังเปิดเพลงพิเศษให้คุณฟัง... 🎶' : 'กดเพื่อฟังเพลงพิเศษ 🎧',
          style: TextStyle(
            color: Colors.pink.shade300,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
