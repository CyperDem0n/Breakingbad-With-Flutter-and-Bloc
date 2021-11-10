part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersErrorCase extends CharactersState {
  
}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  CharactersLoaded({required this.characters});
}

class QuotesLoaded extends CharactersState {
  final List<Quotes> quotes;
  QuotesLoaded({required this.quotes});
}