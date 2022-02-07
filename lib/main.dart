import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:wordie/game/game.dart';

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

class GameWindow extends StatefulWidget {
  const GameWindow({Key? key}) : super(key: key);

  @override
  State<GameWindow> createState() => _GameWindowState();
}

class _GameWindowState extends State<GameWindow> {
  String _word = '';

  @override
  void initState() {
    super.initState();

    final words = all.where((element) => element.length == 5).toList()
      ..shuffle();
    _word = words.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: const SafeArea(
        child: SizedBox.expand(
          child: WordieGame(
            word: "CAUSE",
            numberOfGuesses: 6,
          ),
        ),
      ),
    );
  }
}
