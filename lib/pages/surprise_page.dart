import 'package:flutter/material.dart';

class SurprisePage extends StatefulWidget {
  const SurprisePage({super.key});

  @override
  State<SurprisePage> createState() => _SurprisePageState();
}

class _SurprisePageState extends State<SurprisePage> {
  bool unlocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'ยังไม่เปิดนะ 😊',
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
      child: const Text(
        'รักเธอมากกว่าที่คำพูดจะอธิบายได้\nอยู่ด้วยกันไปนาน ๆ นะ 💖',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
