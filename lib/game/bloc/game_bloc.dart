import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordie/game/bloc/game_state.dart';
import 'package:wordie/repository/word_repository.dart';

abstract class GameEvent {}

class NewGameRequested extends GameEvent {}

class GameBloc extends Bloc<GameEvent, GameState> {
  final WordRepository wordRepository;

  GameBloc(
    this.wordRepository,
  ) : super(GameState(
          word: wordRepository.words.first,
          numberOfGuesses: wordRepository.words.first.length + 1,
        )) {
    on<NewGameRequested>(_onNewGameRequested);
  }

  void _onNewGameRequested(NewGameRequested event, Emitter<GameState> emit) {
    wordRepository.words.shuffle();
    final word = wordRepository.words.first;

    emit(GameState(
      word: word,
      numberOfGuesses: word.length + 1,
    ));
  }
}
