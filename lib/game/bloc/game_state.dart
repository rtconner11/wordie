class GameState {
  final String word;
  final int numberOfGuesses;

  const GameState({
    required this.word,
    required this.numberOfGuesses,
  });

  GameState copyWith({
    String? word,
    int? numberOfGuesses,
  }) =>
      GameState(
        word: word ?? this.word,
        numberOfGuesses: numberOfGuesses ?? this.numberOfGuesses,
      );
}
