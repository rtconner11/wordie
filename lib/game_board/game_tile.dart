import 'package:flutter/material.dart';

class GameTile extends StatelessWidget {
  final GameTileState tileState;
  final String? letter;

  const GameTile({
    Key? key,
    required this.tileState,
    this.letter,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: _borderColorForTileState(tileState)),
        color: _backgroundColorForTileState(tileState),
      ),
      child: letter != null 
        ? Center(
            child: Text(letter!, 
              style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ) 
        : const SizedBox(),
    );
  }
}

enum GameTileState {
  empty,
  pending,
  incorrect,
  outOfPosition,
  correct
}

Color _backgroundColorForTileState(GameTileState tileState) {
  switch (tileState) {
    case GameTileState.empty:
    case GameTileState.pending:
      return Colors.black;
    case GameTileState.incorrect:
      return Colors.black38;
    case GameTileState.outOfPosition:
      return Colors.yellow;
    case GameTileState.correct:
      return Colors.green;
  }
}

Color _borderColorForTileState(GameTileState tileState) {
  switch (tileState) {
    case GameTileState.empty:
      return Colors.grey;
    case GameTileState.pending:
      return Colors.blueGrey;
    case GameTileState.incorrect:
      return Colors.black38;
    case GameTileState.outOfPosition:
      return Colors.yellow;
    case GameTileState.correct:
      return Colors.green;
  }
}