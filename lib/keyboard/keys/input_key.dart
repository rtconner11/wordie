import 'package:flutter/material.dart';

abstract class InputKey extends StatelessWidget {
  final Color backgroundColor;
  final int flex;

  const InputKey({
    Key? key,
    required this.backgroundColor,
    this.flex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          color: backgroundColor,
          child: InkWell(
            onTap: () {
              handleOnTap();
            },
            child: SizedBox(
              height: 55,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: Center(
                  child: contentWidget(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Abstract Members

  void handleOnTap();

  Widget contentWidget(BuildContext context);
}