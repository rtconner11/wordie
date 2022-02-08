import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class WordRepository {
  List<String> words = [];
  late Box? _wordBox;

  WordRepository();

  Future<void> loadWords() async {
    _wordBox = await Hive.openBox('words');

    if (_wordBox?.isEmpty ?? false) {
      final answers = await rootBundle.loadString('assets/answer_words.txt');
      final additionalWords =
          await rootBundle.loadString('assets/additional_words.txt');

      final answersMap = groupBy<String, String>(
        answers.split('\n'),
        (word) => word.characters.first,
      );
      final additionalWordsMap = groupBy<String, String>(
        additionalWords.split('\n'),
        (word) => word.characters.first,
      );

      await _wordBox?.put('answerWords', answersMap);
      await _wordBox?.put('additionalWords', additionalWordsMap);
    }
  }

  String? getNewAnswerWord() {
    final letter = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z',
    ]..shuffle();
    final wordMap = _wordBox?.get('answerWords') as Map<String, List<String>>?;
    final wordsForLetter = wordMap?[letter];

    if (wordsForLetter != null) {
      wordsForLetter.shuffle();

      return wordsForLetter.first;
    }

    return null;
  }
}
