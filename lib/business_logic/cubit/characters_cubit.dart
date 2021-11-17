import 'package:bloc/bloc.dart';
import '../../data/models/char_quotes.dart';
import '../../data/models/characters.dart';
import '../../data/repository/characters_repo.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepository.fetchAllCharacters().then((fetchedCharacters) {
      emit(CharactersLoaded(characters: fetchedCharacters));
      this.characters = fetchedCharacters;
    });
    return characters;
  }

  void getAllQuotes(String authName) {
    charactersRepository.fetchAllQuotes(authName).then((fetchedQuotes) {
      emit(QuotesLoaded(quotes: fetchedQuotes));
    });
  }
}
