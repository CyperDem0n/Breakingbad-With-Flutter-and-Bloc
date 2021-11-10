import 'data/models/characters.dart';

import 'business_logic/cubit/characters_cubit.dart';

import 'data/repository/characters_repo.dart';
import 'data/web_services/characters_web_services.dart';

import 'presentation/screens/characters_screen.dart';
import 'presentation/screens/characters_details.dart';

import 'constants/strings.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository =
        CharactersRepository(charactersWebServices: CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharacterScreen(),
          ),
        );
      case characterDetailScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => CharactersCubit(charactersRepository),
            child: CharactersDetailScreen(
              character: character,
            ),
          ),
        );
    }
  }
}
