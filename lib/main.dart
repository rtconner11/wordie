import 'package:flutter/material.dart';
import 'package:wordie/game/game.dart';
import 'package:wordie/game_board/board_row.dart';
import 'package:wordie/game_board/game_tile.dart';
import 'package:wordie/keyboard/keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wordie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameWindow(),
    );
  }
}

class GameWindow extends StatelessWidget {

  const GameWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: WordieGame(
            word: "PENIS",
            numberOfGuesses: 6,
          ),
        ),
      ),
    );
  }
}