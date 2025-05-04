import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_app_2/utils/retreive_token.dart';

class ChatsService {
  static Future<dynamic> getChats() async {
    final token=await RetreiveToken.getAuthTokenHeader();
    final response = await http.get(
      Uri.parse('http://localhost:3000/authenticated/user/chat'),
      headers: {
        ...token
      }
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> resData = jsonDecode(response.body);
      final List<dynamic> chats = resData['chats'];

      return chats;

    } else {
      throw Exception('Failed to Fetch');
    }
  }


}
