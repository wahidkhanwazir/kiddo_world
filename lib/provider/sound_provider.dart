import 'package:flutter/cupertino.dart';

class SoundProvider extends ChangeNotifier {
  List<String> _soundList = [];

  List get soundList => _soundList;

  void updateSound(List<String> sounds) {
    _soundList = sounds;
    notifyListeners();
  }
}