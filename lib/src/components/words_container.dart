import 'package:dart_wordle/src/components/word_empty.dart';
import 'package:dart_wordle/src/components/word_grids.dart';
import 'package:dart_wordle/src/components/word_input.dart';
import 'package:dart_wordle/src/models/word.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:dart_wordle/src/store.dart';

part 'words_container.over_react.g.dart';

UiFactory<WordsContainerProps> WordsContainer =
    connect<AppState, WordsContainerProps>(mapStateToProps: (state) {
  return (WordsContainer()
    ..guesses = state.guesses
    ..maxGuess = 5
    ..wordToGuess = state.wordToGuess
    ..isFinished = state.isFinished);
})(castUiFactory(_$WordsContainer)); // ignore: undefined_identifier

mixin WordsContainerPropsMixin on UiProps {
  List<Word> guesses;
  int maxGuess;
  String wordToGuess;
  bool isFinished;
}

class WordsContainerProps = UiProps with WordsContainerPropsMixin;

mixin WordsContainerStateMixin on UiState {}

class WordsContainerState = UiState with WordsContainerStateMixin;

class WordsContainerComponent
    extends UiStatefulComponent2<WordsContainerProps, WordsContainerState> {
  // @override
  // get defaultProps => (newProps());

  @override
  render() {
    List<ReactElement> children = [];
    children.addAll(props.guesses.map(_renderItem).toList());
    if (props.maxGuess - children.length > 0 && !props.isFinished) {
      children.add((WordInput()..key = props.maxGuess - children.length)());
    }

    while (children.length < props.maxGuess) {
      children.add((WordEmpty()..key = props.maxGuess - children.length)());
    }

    DomProps container = Dom.div();
    container.className = 'w-4/5 mt-5 m-auto text-4xl flex flex-col max-w-2xl';

    return (container(children));
  }

  ReactElement _renderItem(Word word) {
    return (WordGrids()
      ..model = word
      ..key = word.word)();
  }
}
