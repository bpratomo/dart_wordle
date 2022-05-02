import 'dart:html';

import 'package:dart_wordle/src/store.dart';
import 'package:dart_wordle/src/models/word.dart';
import 'package:dart_wordle/src/actions.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:dart_wordle/src/models/dictionary.dart';

part 'keyboard_key.over_react.g.dart';

UiFactory<KeyboardKeyProps> KeyboardKey = connect<AppState, KeyboardKeyProps>(
  mapStateToProps: (state) {
    return (KeyboardKey()
      ..wordToGuess = state.wordToGuess
      ..guess = state.guess
      ..guesses = state.guesses);
  },
  mapDispatchToProps: (dispatch) => (KeyboardKey()
    ..updateCurrentGuess = (key) {
      dispatch(UpdateCurrentGuessAction(key));
    }
    ..addNewGuess = (String guess, String wordToGuess) {
      dispatch(AddNewGuessAction(Word(guess, wordToGuess)));
    }
    ..clearCurrentGuess = (action) {
      dispatch(ClearCurrentGuessAction(action));
    }
    ..markGameAsFinished = () {
      dispatch(SetGameStatusAction(true));
    }),
)(castUiFactory(_$KeyboardKey)); // ignore: undefined_identifier

mixin KeyboardKeyProps on UiProps {
  String char;
  dynamic updateCurrentGuess;
  dynamic addNewGuess;
  dynamic clearCurrentGuess;
  dynamic markGameAsFinished;
  String guess;
  String wordToGuess;
  List<Word> guesses;
}

class KeyboardKeyComponent extends UiComponent2<KeyboardKeyProps> {
  @override
  get defaultProps => (newProps());

  @override
  render() {
    dynamic Function(SyntheticMouseEvent) dispatchRouter =
        (SyntheticMouseEvent e) {
      if (props.char == 'Enter') {
        if (props.guess.length < 5) {
          window.alert('Only word with 5 character allowed');
        } else if (!isWordValid(props.guess)) {
          window.alert('Not a valid word');
          props.clearCurrentGuess(props.guess);
        } else if (props.guesses.map((e) => e.word).contains(props.guess)) {
          window.alert('Word already guessed');
          props.clearCurrentGuess(props.guess);
        } else if (props.guess.toLowerCase() == props.wordToGuess) {
          props.markGameAsFinished();
          props.addNewGuess(props.guess, props.wordToGuess);
          props.clearCurrentGuess(props.guess);
        } else if (props.guesses.length == 4) {
          props.markGameAsFinished();
        } else {
          props.addNewGuess(props.guess, props.wordToGuess);
          props.clearCurrentGuess(props.guess);
        }
      } else {
        props.updateCurrentGuess(props.char);
      }
    };
    DomProps container = Dom.div();
    container.className =
        'flex flex-col justify-center align-center p-2 border border-slate-100';

    dynamic getStatusCount = (Word word, String char, String resultToCheck) {
      List<int> correctIndices = ({...word.result}
            ..removeWhere((key, value) => value != resultToCheck))
          .keys
          .toList();
      List<String> correctChars =
          correctIndices.map((e) => word.word[e]).toList();
      int correctCount = (correctChars
            ..removeWhere(
                (element) => element.toLowerCase() != char.toLowerCase()))
          .length;
      return correctCount;
    };

    // ignore: omit_local_variable_types
    int successCount = [...props.guesses].fold(
        0,
        (previousValue, element) =>
            previousValue +
            getStatusCount(element, props.char, ResultEnum.Correct));

    // ignore: omit_local_variable_types
    int missedCount = [...props.guesses].fold(
        0,
        (previousValue, element) =>
            previousValue +
            getStatusCount(element, props.char, ResultEnum.Missed));

    // ignore: omit_local_variable_types
    int notFoundCount = [...props.guesses].fold(
        0,
        (previousValue, element) =>
            previousValue +
            getStatusCount(element, props.char, ResultEnum.NotFound));

    ;

    if (successCount > 0) {
      container.className += ' bg-green-900 text-white ';
    } else if (missedCount > 0) {
      container.className += ' bg-yellow-400 text-white ';
    } else if (notFoundCount > 0) {
      container.className += ' bg-slate-800 text-white';
    } else {
      container.className += ' bg-white text-black';
    }
    container.onClick = dispatchRouter;

    DomProps letter = Dom.div();
    if (props.char == 'Enter') {
      container.className += ' mr-2';
    } else if (props.char == 'Backspace') {
      container.className += ' ml-2';
    }
    return (container(letter(props.char)));
  }
}
