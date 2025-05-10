import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_app_2/utils/retreive_token.dart';

class AuthService {
  static Future<dynamic> signUp(String username,String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/unauthenticated/sign-up'),
      body: jsonEncode({"name":username,"email": email, "password": password}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> resData = jsonDecode(response.body);
      return {
        "success":true,
        ...resData
      };
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<dynamic> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/unauthenticated/sign-in'),
      body: jsonEncode({"email": email, "password": password}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> resData = jsonDecode(response.body);
      return {
        "success":true,
        ...resData
      };
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<dynamic> getUserInfo() async {
    final token = await RetreiveToken.getAuthTokenHeader();
    final response = await http.get(
        Uri.parse('http://localhost:3000/authenticated/user/info'),
        headers: {...token});

    if (response.statusCode == 200) {
      final Map<String, dynamic> resData = jsonDecode(response.body);
      return resData['userInfo'];
    } else {
      throw Exception('Failed to Fetch');
    }
  }
}
