import 'package:json_annotation/json_annotation.dart';
import 'package:dart_wordle/src/models/word.dart';
part 'actions.g.dart';

class _Action<T> {
  _Action(this.value);
  final T value;
  dynamic toJson() {
    try {
      return (value as dynamic).toJson();
    } catch (_) {}

    return value;
  }
}

@JsonSerializable()
class AddNewGuessAction extends _Action<Word> {
  AddNewGuessAction(Word value) : super(value);
}

class UpdateCurrentGuessAction extends _Action<String> {
  UpdateCurrentGuessAction(String value) : super(value);
}

class ClearCurrentGuessAction extends _Action<String> {
  ClearCurrentGuessAction(String value) : super(value);
}

class SetWordToGuessAction extends _Action<String> {
  SetWordToGuessAction(String value) : super(value);
}

class SetValidWordsAction extends _Action<List<String>> {
  SetValidWordsAction(List<String> value) : super(value);
}

class SetGameStatusAction extends _Action<bool> {
  SetGameStatusAction(bool value) : super(value);
}

class ResetGameAction extends _Action<bool> {
  ResetGameAction(bool value) : super(value);
}
