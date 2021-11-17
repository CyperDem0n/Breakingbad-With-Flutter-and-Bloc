import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/char_quotes.dart';
import 'package:flutter/material.dart';

import '../../data/models/characters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersDetailScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailScreen({Key? key, required this.character})
      : super(key: key);
  Widget buildSliverAppBar() {
    return SliverAppBar(
      //Controlls le Image + appBar
      pinned: true,
      expandedHeight: 600, //hieght if img
      stretch: true,
      backgroundColor: MyColors.Grey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          '${character.nickname}',
          style: TextStyle(color: MyColors.White),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInto(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$title : ',
            style: TextStyle(
              color: MyColors.White,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.White,
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endInd) {
    return Divider(
      color: MyColors.Yellow,
      height: 30,
      endIndent: endInd,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return Center(
        child: CircularProgressIndicator(color: MyColors.Yellow),
      );
    }
  }

  Widget displayRandomQuoteOrEmptySpace(QuotesLoaded state) {

    List<Quotes> quotesList = state.quotes;
    if (quotesList.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotesList.length);
      return Center(
        child: DefaultTextStyle(
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText('${quotesList[randomQuoteIndex].quote}'),
            ],
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.White,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.Yellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getAllQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.Grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            //The part which the other Details will appear
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // use join method to convert each job to string and concatenate them using the parameter
                      characterInto('Job', character.jobs.join(' / ')),
                      buildDivider(315),
                      characterInto('Appeared in', character.categoryForSeires),
                      buildDivider(250),
                      characterInto(
                          'Seasons', character.appearance.join(' / ')),
                      buildDivider(280),
                      characterInto('Status', character.statusIfDeadOrAlive),
                      buildDivider(300),
                      /* ================ Conditional Details ================= */
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInto('Better Call Saul Seasons',
                              character.betterCallSaulAppearance.join(' / ')),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(150),
                      characterInto('Actor/Actress', character.actorName),
                      buildDivider(235),
                      SizedBox(height: 20),

                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 350),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
