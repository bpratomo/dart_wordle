import 'package:dart_wordle/src/models/word.dart';
import 'package:dart_wordle/src/components/word/char_grid.dart';
import 'package:dart_wordle/src/store.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:uuid/uuid.dart';

part 'word_empty.over_react.g.dart';

var uuid = Uuid();

UiFactory<WordEmptyProps> WordEmpty =
    castUiFactory(_$WordEmpty); // ignore: undefined_identifier

mixin WordEmptyPropsMixin on UiProps {}

class WordEmptyProps = UiProps with WordEmptyPropsMixin;

mixin WordEmptyStateMixin on UiState {}

class WordEmptyState = UiState with WordEmptyStateMixin;

class WordEmptyComponent
    extends UiStatefulComponent2<WordEmptyProps, WordEmptyState> {
  @override
  render() {
    List<ReactElement> childrenEl = [];
    for (var i = 0; i < 5; i++) {
      childrenEl.add(_renderItem(' '));
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
      ..empty = true
      ..key = uuid.v1())();
  }
}
