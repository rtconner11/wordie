import 'package:english_words/english_words.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordie/game/bloc/game_state.dart';

abstract class GameEvent {}

class NewGameRequested extends GameEvent {}

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(
    String word,
    int numberOfGuesses,
  ) : super(GameState(
          word: word,
          numberOfGuesses: numberOfGuesses,
        )) {
    on<NewGameRequested>(_onNewGameRequested);
  }

  void _onNewGameRequested(NewGameRequested event, Emitter<GameState> emit) {
    final words = all.where((element) => element.length == 5).toList()
      ..shuffle();
    final word = words.first;

    emit(GameState(
      word: word,
      numberOfGuesses: word.length + 1,
    ));
  }
}
