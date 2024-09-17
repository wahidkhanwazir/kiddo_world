import 'package:flutter/cupertino.dart';

class CorrectAnswerProvider extends ChangeNotifier {
  String _correctAnswer = '';

  String get correctAnswer => _correctAnswer;

  void updateCorrectAnswer(String newAnswer) {
    _correctAnswer = newAnswer;
    notifyListeners();
  }
}