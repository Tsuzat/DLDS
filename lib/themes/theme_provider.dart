import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

class ThemeProvider with ChangeNotifier {
  bool isDark = true;
  WindowEffect effect = WindowEffect.transparent;

  setSelectedTheme(bool theme) {
    isDark = theme;
    notifyListeners();
  }

  setSelectedEffect(WindowEffect newEffect) {
    effect = newEffect;
    notifyListeners();
  }
}
