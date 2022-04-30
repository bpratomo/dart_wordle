import 'dart:math';
import 'package:dart_wordle/src/models/word.dart';
import 'package:dart_wordle/src/store.dart';
import 'package:dart_wordle/src/models/dictionary.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:collection';

class Keys {
  static String localStorageKey = 'WordleState';
  static String defaultState = 'defaultState';
  //static String currentState = 'currentState';
  static String emptyState = 'emptyState';
}

WordleAppLocalStorage wordleAppLocalStorage;

class WordleAppLocalStorage {
  WordleAppLocalStorage([AppState initialState]) {
    if (isInitialized()) return;
    window.localStorage[Keys.localStorageKey] =
        json.encode(initialState.toJson());
  }
  void saveStateToLocal(AppState state) {
    window.localStorage[Keys.localStorageKey] = json.encode(state.toJson());
  }

  bool isInitialized() =>
      window.localStorage[Keys.localStorageKey] != null &&
      window.localStorage[Keys.localStorageKey].isNotEmpty;

  @override
  operator [](Object key) {
    return _proxiedMap[key];
  }

  Map<String, dynamic> get _proxiedMap =>
      json.decode(window.localStorage[Keys.localStorageKey]);

  Map<String, dynamic> get currentStateJson =>
      json.decode(window.localStorage[Keys.localStorageKey]);
}

AppState generateEmptyState() {
  return AppState(generateRandomWord(), <Word>[], null, wordleWords, false);
}
