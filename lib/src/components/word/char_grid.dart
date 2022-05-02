import 'package:dart_wordle/src/models/word.dart';
import 'package:over_react/over_react.dart';

part 'char_grid.over_react.g.dart';

UiFactory<CharGridProps> CharGrid =
    castUiFactory(_$CharGrid); // ignore: undefined_identifier

mixin CharGridPropsMixin on UiProps {
  String char;
  String result;
  bool empty;
  bool isBeingWritten;
}

class CharGridProps = UiProps with CharGridPropsMixin;

class CharGridComponent extends UiComponent2<CharGridProps> {
  render() {
    DomProps dom1 = Dom.span();
    String baseClass =
        'm-0.5 border-2 border-white lg:w-24 lg:h-24 md:w-20 md:h-20 sm:w-16 sm:h-16 w-12 h-12 text-center align-middle flex justify-center flex-col ';
    if (props.isBeingWritten == true) {
      baseClass += 'bg-white text-black';
    } else if (props.empty == true) {
      baseClass += 'bg-slate-300';
    } else if (props.result == ResultEnum.Correct) {
      baseClass = baseClass + 'bg-green-900 text-white';
    } else if (props.result == ResultEnum.Missed) {
      baseClass = baseClass + 'bg-yellow-400 text-white';
    } else {
      baseClass += 'bg-slate-800 text-white';
    }

    dom1.className = baseClass;

    DomProps charDiv = Dom.div();
    return (dom1(charDiv(props.char)));
  }
}
