import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
