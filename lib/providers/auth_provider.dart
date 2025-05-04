import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:chat_app_2/services/auth_service.dart';
import 'package:chat_app_2/utils/retreive_token.dart';
import 'package:jwt_decoder/jwt_decoder.dart';


class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String _authUserId='';
  final LocalStorage storage = LocalStorage('my_app_storage');
  // Public getter
  bool get isAuthenticated => _isAuthenticated;
  String get authUserId => _authUserId;

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

  Future<void> setAuthUserId()async{
    final LocalStorage storage = LocalStorage('my_app_storage');
    await storage.ready;
    final token = await storage.getItem('token');
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    _authUserId=decodedToken['_id'];
    notifyListeners();
  }




}