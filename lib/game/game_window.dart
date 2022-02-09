import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wordie/game/bloc/game_bloc.dart';
import 'package:wordie/game/bloc/game_state.dart';
import 'package:wordie/game/game.dart';

class GameWindow extends StatelessWidget {
  const GameWindow({Key? key}) : super(key: key);

  void _onNewGamePressed(BuildContext context) {
    final yesButton = TextButton(
      child: const Text(
        'Yes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        context.read<GameBloc>().add(NewGameRequested());
      },
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New Game'),
          content: const Text('Would you like to start a new game?'),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            yesButton,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordie'),
        actions: [
          IconButton(
            onPressed: () => _onNewGamePressed(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: SizedBox.expand(
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return WordieGame(
                word: state.word,
                numberOfGuesses: state.numberOfGuesses,
              );
            },
          ),
        ),
      ),
    );
  }
}
