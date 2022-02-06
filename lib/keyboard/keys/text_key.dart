import 'package:flutter/material.dart';
import 'package:wordie/keyboard/keys/input_key.dart';

class TextKey extends InputKey {
  final String text;
  final ValueSetter<String> onTextInput;

  const TextKey({
    Key? key,
    required this.text,
    required this.onTextInput,
    required Color backgroundColor,
    int flex = 1,
  }) : super(key: key, flex: flex, backgroundColor: backgroundColor);

  @override
  void handleOnTap() {
    onTextInput.call(text);
  }

  @override
  Widget contentWidget(BuildContext context) {
    return Text(text, 
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.white, 
        fontWeight: FontWeight.bold, 
        fontSize: 12,
      ),
    );
  }
}