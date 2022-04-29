import 'package:dart_wordle/src/models/word.dart';
import 'package:dart_wordle/src/components/char_grid.dart';
import 'package:dart_wordle/src/store.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:uuid/uuid.dart';

part 'word_input.over_react.g.dart';

var uuid = Uuid();

UiFactory<WordInputProps> WordInput =
    connect<AppState, WordInputProps>(mapStateToProps: (state) {
  return (WordInput()..guess = state.guess);
})(castUiFactory(_$WordInput)); // ignore: undefined_identifier

mixin WordInputPropsMixin on UiProps {
  String guess;
}

class WordInputProps = UiProps with WordInputPropsMixin;

mixin WordInputStateMixin on UiState {}

class WordInputState = UiState with WordInputStateMixin;

class WordInputComponent
    extends UiStatefulComponent2<WordInputProps, WordInputState> {
  @override
  render() {
    String nullSafeGuess = props.guess ?? '';

    var filler =
        [for (var i = 1; i < 6 - nullSafeGuess.length ?? 0; i++) ' '].join();
    String toSplit = nullSafeGuess + filler;

    List<String> charList = toSplit.split('') ?? [];
    List<ReactElement> childrenEl = [];
    for (var i = 0; i < charList.length; i++) {
      childrenEl.add(_renderItem(charList[i]));
    }

    DomProps dom1 = Dom.div();
    dom1.className = 'flex flex-nowrap justify-center';
    return dom1(
      childrenEl,
    );
  }

  ReactElement _renderItem(String char) {
    return (CharGrid()
      ..char = char
      ..key = uuid.v1()
      ..isBeingWritten = true)();
  }
}
