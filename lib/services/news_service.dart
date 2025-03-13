import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiKey = '1cac7d5de7f24a18bafb819f66306200';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  static Future<List<Map<String, String>>> fetchNews() async {
    final url = Uri.parse("$_baseUrl?category=business&language=en&apiKey=$_apiKey");

    try {
      final response = await http.get(url);
      print("API Response: ${response.body}"); // Debugging log

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Handle API errors or empty responses
        if (data["status"] != "ok" || data["articles"] == null) {
          print("Error fetching news: ${data["message"] ?? "Unknown error"}");
          return [];
        }

        final articles = data["articles"] as List;

        return articles.map<Map<String, String>>((article) {
          return {
            "title": article["title"] ?? "No Title",
            "source": article["source"]?["name"] ?? "Unknown",
            "time": article["publishedAt"]?.substring(0, 10) ?? "Unknown", // Extract only the date
            "url": article["url"] ?? "", // Optional: Add article URL
            "image": article["urlToImage"] ?? "", // Optional: Add thumbnail image
          };
        }).toList();
      } else {
        throw Exception("Failed to load news data");
      }
    } catch (e) {
      print("Error fetching news: $e");
      return [];
    }
  }
}
