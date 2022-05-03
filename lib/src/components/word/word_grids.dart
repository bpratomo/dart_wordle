import 'package:dart_wordle/src/models/word.dart';
import 'package:dart_wordle/src/components/word/char_grid.dart';
import 'package:dart_wordle/src/store.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:uuid/uuid.dart';

part 'word_grids.over_react.g.dart';

var uuid = Uuid();

UiFactory<WordGridsProps> WordGrids =
    castUiFactory(_$WordGrids); // ignore: undefined_identifier

mixin WordGridsPropsMixin on UiProps {
  Word model;
}

class WordGridsProps = UiProps with WordGridsPropsMixin;

mixin WordGridsStateMixin on UiState {}

class WordGridsState = UiState with WordGridsStateMixin;

class WordGridsComponent
    extends UiStatefulComponent2<WordGridsProps, WordGridsState> {
  @override
  render() {
    List<String> charList = props.model.word.split('');
    Map<int, String> resultMap = props.model.result;
    List<ReactElement> childrenEl = [];
    for (var i = 0; i < charList.length; i++) {
      childrenEl.add(_renderItem(charList[i], resultMap[i]));
    }

    DomProps dom1 = Dom.div();
    dom1.className = 'flex flex-nowrap justify-evenly';
    return dom1(
      childrenEl,
    );
  }

  ReactElement _renderItem(String char, String result) {
    return (CharGrid()
      ..char = char
      ..result = result
      ..key = uuid.v1())();
  }
}
