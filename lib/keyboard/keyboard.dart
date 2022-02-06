import 'package:flutter/material.dart';
import 'package:wordie/keyboard/keys/keys.dart';

class WordieKeyboard extends StatelessWidget {
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onEnter;
  final VoidCallback? onBackspace;

  final Set<String> correctLetters;
  final Set<String> incorrectLetters;
  final Set<String> outOfPositionLetters;

  const WordieKeyboard({
    Key? key,
    this.onTextInput,
    this.onEnter,
    this.onBackspace,
    required this.correctLetters,
    required this.incorrectLetters,
    required this.outOfPositionLetters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(_buildKeys(['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'])),
        _buildRow(_buildKeys(['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'])),
        _buildRow([
          EnterKey(onEnter: _enterHandler, flex: 3),
          ..._buildKeys(['Z', 'X', 'C', 'V', 'B', 'N', 'M'], flex: 2),
          BackspaceKey(onBackspace: _backspaceHandler, flex: 3),
        ]),
      ],
    );
  }

  Row _buildRow(List<Widget> keys) {
    return Row(
      children: keys,
    );
  }

  List<Widget> _buildKeys(List<String> letters, {int flex = 1}) {
    return letters.map((letter) {
      Color keyColor = Colors.grey;

      if (correctLetters.contains(letter)) {
        keyColor = Colors.green;
      } else if (outOfPositionLetters.contains(letter)) {
        keyColor = Colors.yellow;
      } else if (incorrectLetters.contains(letter)) {
        keyColor = Colors.black;
      }

      return TextKey(
        flex: flex,
        text: letter, 
        backgroundColor: keyColor,
        onTextInput: _textInputHandler,
      );
    }).toList().cast<Widget>();
  }

  void _textInputHandler(String text) => onTextInput?.call(text);

  void _enterHandler() => onEnter?.call();

  void _backspaceHandler() => onBackspace?.call();
}