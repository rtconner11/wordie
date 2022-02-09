import 'package:flutter/material.dart';
import 'package:wordie/game/widgets/game_tile.dart';

class BoardRow extends StatelessWidget {
  final String targetWord;
  final String? currentInput;
  final bool isSubmitted;

  final int _wordLength;

  const BoardRow({
    Key? key,
    required this.targetWord,
    required this.currentInput,
    required this.isSubmitted,
  })  : _wordLength = targetWord.length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: List.generate(_wordLength, (index) {
          final letter = currentInput != null
              ? index < currentInput!.length
                  ? currentInput![index]
                  : null
              : null;

          bool isCorrect = false;
          bool isInWord = false;

          if (letter != null && targetWord.contains(letter)) {
            if (letter == targetWord[index]) {
              isCorrect = true;
            }

            final numLetterToThisPoint = currentInput!
                .substring(0, index + 1)
                .characters
                .where((it) => it == letter)
                .length;
            final numLetterInWord =
                targetWord.characters.where((it) => it == letter).length;

            if (!isCorrect &&
                targetWord.indexOf(letter) < currentInput!.length &&
                currentInput![targetWord.indexOf(letter)] != letter &&
                numLetterToThisPoint <= numLetterInWord) {
              isInWord = true;
            }
          }

          GameTileState tileState = GameTileState.empty;

          if (isSubmitted && isCorrect) {
            tileState = GameTileState.correct;
          } else if (isSubmitted && isInWord) {
            tileState = GameTileState.outOfPosition;
          } else if (isSubmitted) {
            tileState = GameTileState.incorrect;
          } else if (letter != null) {
            tileState = GameTileState.pending;
          }

          return Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: GameTile(
                key: Key('game_tile_$index'),
                letter: letter,
                tileState: tileState,
              ),
            ),
          );
        }),
      ),
    );
  }
}
