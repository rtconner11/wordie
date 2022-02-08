class GameState {
  final String word;
  final int numberOfGuesses;

  const GameState({
    required this.word,
    required this.numberOfGuesses,
  });

  factory GameState.emptyState() => const GameState(
        word: '',
        numberOfGuesses: 0,
      );

  GameState copyWith({
    String? word,
    int? numberOfGuesses,
  }) =>
      GameState(
        word: word ?? this.word,
        numberOfGuesses: numberOfGuesses ?? this.numberOfGuesses,
      );
}
