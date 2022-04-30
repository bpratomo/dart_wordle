import 'package:dart_wordle/src/actions.dart';
import 'package:dart_wordle/src/models/word.dart';
import 'package:dart_wordle/src/store.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';

part 'app_bar.over_react.g.dart';

UiFactory<AppBarProps> AppBar =
    connect<AppState, AppBarProps>(mapDispatchToProps: (dispatch) {
  return AppBar()
    ..resetGame = () {
      dispatch(ResetGameAction(true));
    };
})(castUiFactory(_$AppBar)); // ignore: undefined_identifier

mixin AppBarPropsMixin on UiProps {
  dynamic resetGame;
}

class AppBarProps = UiProps with AppBarPropsMixin;

class AppBarComponent extends UiComponent2<AppBarProps> {
  render() {
    dynamic Function(SyntheticMouseEvent) resetGame = (SyntheticMouseEvent e) {
      props.resetGame();
    };
    DomProps dom1 = Dom.div();
    String baseClass =
        'py-2 px-5 bg-black text-white w-full h-14 text-left align-middle text-3xl flex flex-row justify-between';
    dom1.className = baseClass;

    DomProps textDiv = Dom.div();
    DomProps newGameButton = Dom.button();
    newGameButton.className = 'bg-slate-800 text-white text-sm py-1 px-2';
    newGameButton.onClick = resetGame;

    return (dom1(textDiv('Dart Wordle'), newGameButton('Reset game')));
  }
}
