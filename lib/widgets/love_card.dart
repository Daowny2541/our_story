import 'package:flutter/material.dart';

class LoveCard extends StatefulWidget {
  final VoidCallback onPressed;

  const LoveCard({super.key, required this.onPressed});

  @override
  State<LoveCard> createState() => _LoveCardState();
}

class _LoveCardState extends State<LoveCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: -12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: _cardBody(),
    );
  }

  Widget _cardBody() {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ถึงคนพิเศษของเรา 💖',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'ไม่รู้อนาคตจะเป็นยังไง แต่วันนี้ดีมากเพราะมีเธออยู่ตรงนี้ 😊💖 '
            'และพวกเราก็ทำความรู้จักกันผ่านมา 1 เดือนแล้วในฐานคนของใจของกันและกัน '
            'ไม่ว่าอดีตพวกเราจะพบเจออะไรก็ตามให้ทิ้งไป และมอบทุกอย่างให้พระเจ้านำพาพวกเรา '
            'ขอบคุณที่รักกันนะ\n'
            'เว็บนี้ทำมาให้เธอคนเดียวเลยนะ 🥰',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.4),
          ),
          const SizedBox(height: 24),

          /// 🎁 ปุ่มเปิดเซอร์ไพรส์
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 36,
                vertical: 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 6,
            ),
            onPressed: widget.onPressed,
            child: const Text(
              'เปิดเซอร์ไพรส์ 🎁',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
