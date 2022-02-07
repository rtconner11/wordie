import 'package:flutter/material.dart';
import 'package:wordie/keyboard/keys/input_key.dart';

class EnterKey extends InputKey {
  final VoidCallback onEnter;

  const EnterKey({
    Key? key,
    required this.onEnter,
    int flex = 1,
  }) : super(key: key, flex: flex, backgroundColor: Colors.grey);

  @override
  void handleOnTap() {
    onEnter.call();
  }

  @override
  Widget contentWidget(BuildContext context) {
    return Text(
      'ENTER',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
    );
  }
}
