import 'package:localstorage/localstorage.dart';

class RetreiveToken {
  static Future<Map<String, String>> getAuthTokenHeader() async {
    final LocalStorage storage = LocalStorage('my_app_storage');
    await storage.ready;
    final token = await storage.getItem('token');

    return {
      'Authorization': 'Bearer $token',
    };
  }
}