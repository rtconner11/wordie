import 'package:flutter/material.dart';
import 'package:wordie/game/widgets/game_tile.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 0.0),
            child: Text.rich(
              TextSpan(
                text: '',
                children: <TextSpan>[
                  TextSpan(
                    text: 'GUESS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' valid 5-letter words and find the answer within 6 tries.',
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
                'Green and yellow tiles tell you which letters are in the answer.'),
          ),
          Row(
            children: _buildWordExampleTiles(),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text.rich(
              TextSpan(
                text: 'In this guess, the letter ',
                children: <TextSpan>[
                  TextSpan(
                    text: 'P',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text:
                        ' is in the answer and in the correct position.\n\nThe letter ',
                  ),
                  TextSpan(
                    text: 'A',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text:
                          ' is in the answer, but in the wrong position.\n\n'),
                  TextSpan(
                    text: 'E, C, and H',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' are not in the answer at all.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildWordExampleTiles() {
    const word = 'PEACH';

    return word.characters.map(
      (letter) {
        GameTileState tileState = GameTileState.incorrect;
        if (letter == 'P') {
          tileState = GameTileState.correct;
        } else if (letter == 'A') {
          tileState = GameTileState.outOfPosition;
        }

        return Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: GameTile(
              tileState: tileState,
              letter: letter,
            ),
          ),
        );
      },
    ).toList();
  }
}
