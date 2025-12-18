import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:insta_app/models/book.dart';

class BaseClient {
  String baseUrl = "http://localhost:5000/api/books";

  Future<List<Book>> getBooks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/get'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Book.fromJson(json)).toList();


      } else {
        return [];
      }
    } catch (err) {
      print(err);
      return [];
    }
  }
}
