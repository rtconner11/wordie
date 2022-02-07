import 'package:flutter/material.dart';
import 'package:wordie/colors.dart';

class GameTile extends StatelessWidget {
  final GameTileState tileState;
  final String? letter;

  const GameTile({
    Key? key,
    required this.tileState,
    this.letter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _borderColorForTileState(tileState),
            width: 3,
          ),
          color: _backgroundColorForTileState(tileState),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: letter != null
            ? Center(
                child: Text(
                  letter!,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}

enum GameTileState { empty, pending, incorrect, outOfPosition, correct }

Color _backgroundColorForTileState(GameTileState tileState) {
  switch (tileState) {
    case GameTileState.empty:
    case GameTileState.pending:
      return Colors.transparent;
    case GameTileState.incorrect:
      return WordieColors.darkGrey;
    case GameTileState.outOfPosition:
      return WordieColors.yellow;
    case GameTileState.correct:
      return WordieColors.green;
  }
}

Color _borderColorForTileState(GameTileState tileState) {
  switch (tileState) {
    case GameTileState.empty:
      return WordieColors.darkGrey;
    case GameTileState.pending:
      return Colors.grey.shade700;
    case GameTileState.incorrect:
      return WordieColors.darkGrey;
    case GameTileState.outOfPosition:
      return WordieColors.yellow;
    case GameTileState.correct:
      return WordieColors.green;
  }
}
