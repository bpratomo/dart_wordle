import 'dart:html';

import 'package:dart_wordle/src/local_storage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dart_wordle/src/models/word.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:dart_wordle/src/actions.dart';

part 'store.g.dart';

AppState initializeState() {
  wordleAppLocalStorage = WordleAppLocalStorage(generateEmptyState());
  return AppState.fromJson(wordleAppLocalStorage.currentStateJson);
}

DevToolsStore<AppState> getStore() => DevToolsStore<AppState>(appStateReducer,
    initialState: initializeState(),
    middleware: [overReactReduxDevToolsMiddleware, localStorageMiddleware()]);

Middleware<AppState> localStorageMiddleware() {
  return (store, action, next) {
    next(action);
    wordleAppLocalStorage.saveStateToLocal(store.state);
  };
}

@JsonSerializable(explicitToJson: true)
class AppState {
  String wordToGuess;
  List<Word> guesses;
  String guess;
  List<String> validWords;
  bool isFinished;

  AppState(this.wordToGuess, this.guesses, this.guess, this.validWords,
      this.isFinished);

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);
  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}

AppState appStateReducer(AppState state, dynamic action) {
  if (action is ResetGameAction) {
    var emptyState = generateEmptyState();
    wordleAppLocalStorage = WordleAppLocalStorage(emptyState);
    return emptyState;
  }
  return AppState(
      wordToGuessReducer(state.wordToGuess, action),
      guessesReducer(state.guesses, action),
      guessReducer(state.guess, action),
      validWordsReducer(state.validWords, action),
      isFinishedReducer(state.isFinished, action));
}

final wordToGuessReducer = combineReducers<String>([
  TypedReducer<String, SetWordToGuessAction>((wordToGuess, action) {
    return action.value;
  })
]);

final guessesReducer = combineReducers<List<Word>>([
  TypedReducer<List<Word>, AddNewGuessAction>((guesses, action) {
    return [...guesses, action.value];
  })
]);

final guessReducer = combineReducers<String>([
  TypedReducer<String, UpdateCurrentGuessAction>((guess, action) {
    String nullSafeGuess = guess ?? '';
    if (action.value == 'Backspace') {
      return guess.substring(0, guess.length - 1);
    } else if (nullSafeGuess.length == 5) {
      return guess;
    } else if (action.value.length == 1) {
      return nullSafeGuess + action.value.toUpperCase();
    } else {
      return guess;
    }
  }),
  TypedReducer<String, ClearCurrentGuessAction>((guess, action) {
    return '';
  })
]);

final isFinishedReducer = combineReducers<bool>([
  TypedReducer<bool, SetGameStatusAction>((isFinished, action) {
    return action.value;
  })
]);

final validWordsReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, SetValidWordsAction>((validWords, action) {
    return action.value;
  })
]);
