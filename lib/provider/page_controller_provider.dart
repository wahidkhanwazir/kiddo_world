import 'package:flutter/material.dart';

class PageControllerProvider extends ChangeNotifier {
  late PageController pageController;

  PageControllerProvider() {
    pageController = PageController();
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    notifyListeners();
  }
}
