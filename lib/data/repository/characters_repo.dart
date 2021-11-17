import '../models/char_quotes.dart';
import '../models/characters.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;
  CharactersRepository({required this.charactersWebServices});

  Future<List<Character>> fetchAllCharacters() async {
    final characters = await charactersWebServices.fetchAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }

  Future<List<Quotes>> fetchAllQuotes(String authorName) async {
    final quotes = await charactersWebServices.fetchAllQuotes(authorName);
    return quotes.map((quote) => Quotes.fromJson(quote)).toList();
  }
}
