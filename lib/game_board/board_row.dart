import 'package:flutter/material.dart';
import 'package:wordie/game_board/game_tile.dart';

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
  }) : _wordLength = targetWord.length, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _wordLength, 
        (index) {
          final letter = currentInput != null 
            ? index < currentInput!.length ? currentInput![index] : null
            : null;
          final isCorrect = letter != null && letter == targetWord[index];
          bool isInWord = !isCorrect && letter != null && targetWord.contains(letter);
          if (isInWord) {
            final letterCountInGuessSoFar = currentInput?.substring(0, index + 1)
              .characters
              .where((char) => char == letter)
              .length ?? 0;
            final letterCountInAnswer = targetWord.characters.where((char) => char == letter).length;

            // only count appearances of a given letter up to the number of times that letters appears in
            // the target word. For examples, if the target word is "PLEAT", only count the first "L"
            // in "HELLO". The second "L" is not considered to be in the target word and is therefore incorrect.
            isInWord = letterCountInGuessSoFar <= letterCountInAnswer;
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
        }
      ),
    );
  }
}