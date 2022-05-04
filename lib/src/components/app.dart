import 'dart:html';

import 'package:dart_wordle/src/actions.dart';
import 'package:dart_wordle/src/components/keyboard/keyboard_container.dart';
import 'package:dart_wordle/src/components/result_dialog.dart';
import 'package:dart_wordle/src/models/dictionary.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:dart_wordle/src/store.dart';
import 'package:dart_wordle/src/components/word/words_container.dart';
import 'package:dart_wordle/src/components/app_bar.dart';
import 'package:dart_wordle/src/models/word.dart';

part 'app.over_react.g.dart';

UiFactory<WordleProps> Wordle =
    connect<AppState, WordleProps>(mapStateToProps: (state) {
  return (Wordle()
    ..wordToGuess = state.wordToGuess
    ..guess = state.guess
    ..guesses = state.guesses
    ..isFinished = state.isFinished);
}, mapDispatchToProps: (dispatch) {
  return (Wordle()
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
    });
})(castUiFactory(_$Wordle)); // ignore: undefined_identifier

mixin WordlePropsMixin on UiProps {
  String wordToGuess;
  String guess;
  List<Word> guesses;
  dynamic Function(String) updateCurrentGuess;
  dynamic Function(String, String) addNewGuess;
  dynamic clearCurrentGuess;
  dynamic markGameAsFinished;
  bool isFinished;
}

class WordleProps = UiProps with WordlePropsMixin;

class WordleComponent extends UiComponent2<WordleProps> {
  @override
  void componentDidMount() {
    document.getElementById('container').focus();
    props.clearCurrentGuess(props.guess);
  }

  render() {
    dynamic Function(SyntheticKeyboardEvent) dispatchRouter =
        (SyntheticKeyboardEvent e) {
      if (props.isFinished) {
        return;
      }

      if (e.key == 'Enter') {
        if (props.guess.length < 5) {
          window.alert('Only word with 5 character allowed');
        } else if (!isWordValid(props.guess)) {
          window.alert('Not in word list');
          props.clearCurrentGuess(props.guess);
        } else if (props.guesses.map((e) => e.word).contains(props.guess)) {
          window.alert('Word already guessed');
          props.clearCurrentGuess(props.guess);
        } else if (props.guess.toLowerCase() == props.wordToGuess) {
          props.markGameAsFinished();
          props.addNewGuess(props.guess, props.wordToGuess);
          props.clearCurrentGuess(props.guess);
        } else if (props.guesses.length == 5) {
          props.addNewGuess(props.guess, props.wordToGuess);
          props.markGameAsFinished();
        } else {
          props.addNewGuess(props.guess, props.wordToGuess);
          props.clearCurrentGuess(props.guess);
        }
      } else {
        props.updateCurrentGuess(e.key);
      }
    };

    DomProps container = Dom.div();
    container.className =
        'bg-slate-300 h-full w-full sticky top-0 left-0 min-h-max touch-manipulation ';
    container.tabIndex = 0;
    container.onKeyDown = dispatchRouter;
    container.id = 'container';

    return container(AppBar()(), WordsContainer()(), ResultDialog()(),
        KeyboardContainer()());
  }
}
