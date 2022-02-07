import 'package:flutter/material.dart';
import 'package:wordie/keyboard/keys/input_key.dart';

class BackspaceKey extends InputKey {
  final VoidCallback onBackspace;

  const BackspaceKey({
    Key? key,
    required this.onBackspace,
    int flex = 1,
  }) : super(key: key, flex: flex, backgroundColor: Colors.grey);

  @override
  void handleOnTap() {
    onBackspace.call();
  }

  @override
  Widget contentWidget(BuildContext context) {
    return const Icon(
      Icons.backspace_outlined,
      color: Colors.white,
    );
  }
}
