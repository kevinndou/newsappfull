import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static Future<List<dynamic>> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=API_KEY'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }

  static Future<List<dynamic>> fetchFinancialNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=financial&apiKey=API_KEY'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['articles'];
    } else {
      throw Exception('Failed to load financial news');
    }
  }

  static Future<List<dynamic>> fetchBitcoinNews() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=API_KEY'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['articles'];
    } else {
      throw Exception('Failed to load bitcoin news');
    }
  }

  static Future<List<dynamic>> fetchTeslaNews() async {
    final response = await http.get(
        Uri.parse('https://newsapi.org/v2/everything?q=tesla&apiKey=API_KEY'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['articles'];
    } else {
      throw Exception('Failed to load Tesla news');
    }
  }

  static Future<List<dynamic>> fetchSportNews() async {
    final response = await http.get(
        Uri.parse('https://newsapi.org/v2/everything?q=sports&apiKey=API_KEY'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['articles'];
    } else {
      throw Exception('Failed to load Sports news');
    }
  }

  static Future<List<dynamic>> fetchHealthNews() async {
    final response = await http.get(
        Uri.parse('https://newsapi.org/v2/everything?q=health&apiKey=API_KEY'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['articles'];
    } else {
      throw Exception('Failed to load Health news');
    }
  }
}
