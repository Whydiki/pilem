import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiService{
  static const String baseUrl = 'hhtps://api.themoviedb.org/3';
  static const String apiKey = '9b863548472ab5fb588c7a23ba305b24';

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/now_playing?api.key=$apiKey'));
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/week?api.key=$apiKey'));
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/popular?api.key=$apiKey'));
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }
}