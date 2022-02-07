import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordie/game/bloc/game_state.dart';

abstract class GameEvent {}

class NewGameRequested extends GameEvent {
  final String word;
  final int numberOfGuesses;

  NewGameRequested({
    required this.word,
    required this.numberOfGuesses,
  });
}

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
    emit(GameState(
      word: event.word,
      numberOfGuesses: event.numberOfGuesses,
    ));
  }
}
