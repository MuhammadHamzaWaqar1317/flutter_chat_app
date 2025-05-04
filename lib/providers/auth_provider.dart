import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:chat_app_2/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = true;
  final LocalStorage storage = LocalStorage('my_app_storage');
  // Public getter
  bool get isAuthenticated => _isAuthenticated;

  // Toggle method
  void toggle() {
    _isAuthenticated = !_isAuthenticated;
    notifyListeners();
    debugPrint('Toggle state changed to: $_isAuthenticated');
  }

  Future<void> signUp(String username,String email,String password)async{
    final authData=await AuthService.signUp(username, email, password);
    if(authData['success']){
      await storage.setItem('token', authData['token']);
      _isAuthenticated=true;
    }

    notifyListeners();
  }

  Future<void> signIn(String email,String password)async{
    final authData=await AuthService.signIn( email, password);
    if(authData['success']){
      await storage.setItem('token', authData['token']);
      print('here');
      _isAuthenticated=true;
    }

    notifyListeners();
  }



}