import 'package:json_annotation/json_annotation.dart';
part 'word.g.dart';

class ResultEnum {
  static String NotFound = 'NotFound';
  static String Missed = 'Missed';
  static String Correct = 'Correct';
}

var resultEnum = ResultEnum();

@JsonSerializable()
class Word {
  String word;
  String wordToGuess;
  Map<int, String> result;

  Map<int, String> generateResult(String rawWord, String rawWordToGuess) {
    Map<int, String> temp = {};
    String word = rawWord.toLowerCase();
    String wordToGuess = rawWordToGuess.toLowerCase();
    
    for (int i = 0; i < word.length; i++) {
      if (word[i] == wordToGuess[i]) {
        temp[i] = ResultEnum.Correct;
      } else if (wordToGuess.contains(word[i])) {
        temp[i] = ResultEnum.Missed;
      } else {
        temp[i] = ResultEnum.NotFound;
      }
      ;
    }
    ;
    return temp;
  }

  Word(String word, String wordToGuess) {
    this.word = word.toUpperCase();
    this.wordToGuess = wordToGuess.toUpperCase();
    result = generateResult(word, wordToGuess);
  }

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
  Map<String, dynamic> toJson() => _$WordToJson(this);
}
