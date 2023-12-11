import 'dart:convert';
import 'package:eightplabs/constants/urls.dart';
import 'package:eightplabs/services/services.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, dynamic>?> fetchUserDetails(String token) async {
    final String url = "${AppUrls.baseUrl}/account";
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return Map<String, dynamic>.from(json.decode(response.body));
    } else {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchClasses(String token) async {
    final ClassCache classCache = ClassCache();

    final String url = "${AppUrls.baseUrl}/school-classes";
    List<Map<String, dynamic>>? cachedData = classCache.getClasses(token);
    if (cachedData != null) {
      return cachedData;
    }
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load classes');
    }
  }
}
