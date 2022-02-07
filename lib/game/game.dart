import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wordie/game/bloc/game_bloc.dart';
import 'package:wordie/game/bloc/game_state.dart';
import 'package:wordie/game_board/board_row.dart';
import 'package:wordie/keyboard/keyboard.dart';
import 'package:wordie/util/toast_util.dart';

class WordieGame extends StatefulWidget {
  final String word;
  final int numberOfGuesses;

  final int _wordLength;

  const WordieGame({
    Key? key,
    required this.word,
    required this.numberOfGuesses,
  })  : _wordLength = word.length,
        super(key: key);

  @override
  State<WordieGame> createState() => _WordieGameState();
}

class _WordieGameState extends State<WordieGame> {
  // Game Board State
  late List<String> _guesses;
  late String _currentInput;
  late bool _isSolved;

  // Keyboard State
  late Set<String> _incorrectLetters;
  late Set<String> _correctLetters;
  late Set<String> _outOfPositionLetters;

  @override
  void initState() {
    super.initState();

    _resetState();
  }

  void _resetState() {
    // Game Board State
    _guesses = [];
    _currentInput = '';
    _isSolved = false;

    // Keyboard State
    _incorrectLetters = {};
    _correctLetters = {};
    _outOfPositionLetters = {};
  }

  void _onTextInputted(String newText) {
    if (_isSolved) return;

    if (_currentInput.length < widget._wordLength) {
      setState(() {
        _currentInput += newText;
      });
    }
  }

  void _onEnterPressed() {
    if (_currentInput.length == widget._wordLength) {
      if (all
          .where((word) => word.length == widget._wordLength)
          .contains(_currentInput.toLowerCase())) {
        _handleSubmission();
      } else {
        showToast('Please enter a valid ${widget._wordLength}-letter word');
        setState(() {
          _currentInput = '';
        });
      }
    } else {
      showToast('Please enter a ${widget._wordLength}-letter word');
    }
  }

  void _onBackspacePressed() {
    if (_currentInput.isNotEmpty) {
      setState(() {
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      });
    }
  }

  void _handleSubmission() {
    final word = widget.word.toUpperCase();
    final isSolved = _currentInput == word;

    Set<String> correct = {};
    Set<String> incorrect = {};
    Set<String> outOfPosition = {};

    for (int i = 0; i < _currentInput.length; i++) {
      if (word.contains(_currentInput[i])) {
        for (int j = 0; j < word.length; j++) {
          if (word[j] == _currentInput[i] && word[j] == _currentInput[j]) {
            correct.add(_currentInput[i]);
          }
        }

        if (!correct.contains(_currentInput[i])) {
          outOfPosition.add(_currentInput[i]);
        }
      } else {
        incorrect.add(_currentInput[i]);
      }
    }

    setState(() {
      _guesses.add(_currentInput);
      _isSolved = isSolved;
      _currentInput = '';

      _correctLetters.addAll(correct);
      _outOfPositionLetters.removeAll(correct);

      _incorrectLetters.addAll(incorrect);

      _outOfPositionLetters.addAll(outOfPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state.word != widget.word) {
          setState(() {
            _resetState();
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ..._buildBoardRows(),
            const Spacer(),
            WordieKeyboard(
              correctLetters: _correctLetters,
              incorrectLetters: _incorrectLetters,
              outOfPositionLetters: _outOfPositionLetters,
              onTextInput: _onTextInputted,
              onEnter: _onEnterPressed,
              onBackspace: _onBackspacePressed,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBoardRows() {
    return List.generate(widget.numberOfGuesses, (index) {
      String? guess;
      if (index < _guesses.length) {
        guess = _guesses[index];
      }

      String? rowInput;
      if (guess != null) {
        rowInput = guess;
      } else {
        if (index == _guesses.length) {
          rowInput = _currentInput;
        } else {
          rowInput = null;
        }
      }

      return BoardRow(
        key: Key('board_row_$index'),
        targetWord: widget.word.toUpperCase(),
        currentInput: rowInput,
        isSubmitted: guess != null,
      );
    });
  }
}
