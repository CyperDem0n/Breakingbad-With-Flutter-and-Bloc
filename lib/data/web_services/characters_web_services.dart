import 'dart:convert';

import '../../constants/strings.dart';

import 'package:http/http.dart' as http;

class CharactersWebServices {
  Future<List<dynamic>> fetchAllCharacters() async {
    try {
      final http.Response response =
          await http.get(Uri.parse('$baseUrl/characters'));
      if (response.statusCode == 200) {
        final dataParsed = json.decode(response.body) as List<dynamic>;
        return dataParsed;
      } else {
        throw Exception('Connection Error Occured!');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> fetchAllQuotes(String authorName) async {
    try {
      final http.Response response = await http
          .get(Uri.parse('$baseUrl/quote/random?author=$authorName'));
      if (response.statusCode == 200) {
        final dataParsed = json.decode(response.body) as List<dynamic>;
        return dataParsed;
      } else {
        throw Exception('Connection Error Occured!');
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
