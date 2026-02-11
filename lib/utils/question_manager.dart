import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/love_questions.dart';

class QuestionManager {
  static const _answeredKey = 'answered_questions';

  /// ดึงคำถามที่ยังไม่เคยตอบ (สุ่ม)
  static Future<LoveQuestion?> getRandomQuestion() async {
    final prefs = await SharedPreferences.getInstance();
    final answeredIds = prefs.getStringList(_answeredKey) ?? [];

    final remaining = loveQuestions
        .where((q) => !answeredIds.contains(q.id))
        .toList();

    if (remaining.isEmpty) return null;

    return remaining[Random().nextInt(remaining.length)];
  }

  /// บันทึกว่าตอบแล้ว
  static Future<void> saveAnswer(String questionId) async {
    final prefs = await SharedPreferences.getInstance();
    final answeredIds = prefs.getStringList(_answeredKey) ?? [];

    if (!answeredIds.contains(questionId)) {
      answeredIds.add(questionId);
      await prefs.setStringList(_answeredKey, answeredIds);
    }
  }

  /// ล้างคำตอบ (ใช้ตอน dev)
  static Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_answeredKey);
  }

  static bool isAllAnswered(List<String> answeredIds) {
    return answeredIds.length >= loveQuestions.length;
  }

}
