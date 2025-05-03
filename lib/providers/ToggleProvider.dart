import 'package:flutter/material.dart';

class ToggleProvider with ChangeNotifier {
  bool _isToggled = false;

  // Public getter
  bool get isToggled => _isToggled;

  // Toggle method
  void toggle() {
    _isToggled = !_isToggled;
    notifyListeners();
    debugPrint('Toggle state changed to: $_isToggled');
  }

  // Optional: Set specific value
  void setValue(bool value) {
    if (_isToggled != value) {
      _isToggled = value;
      notifyListeners();
    }
  }
}