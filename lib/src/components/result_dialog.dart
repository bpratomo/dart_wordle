import 'package:dart_wordle/src/actions.dart';
import 'package:dart_wordle/src/models/word.dart';
import 'package:dart_wordle/src/components/char_grid.dart';
import 'package:dart_wordle/src/store.dart';
import 'package:over_react/over_react.dart';
import 'package:over_react/over_react_redux.dart';
import 'package:uuid/uuid.dart';

part 'result_dialog.over_react.g.dart';

var uuid = Uuid();

UiFactory<ResultDialogProps> ResultDialog =
    connect<AppState, ResultDialogProps>(mapStateToProps: (state) {
  return (ResultDialog()
    ..guesses = state.guesses
    ..isFinished = state.isFinished
    ..wordToGuess = state.wordToGuess
    ..win = state.isFinished
        ? state.guesses.last.word.toLowerCase() == state.wordToGuess
        : false);
}, mapDispatchToProps: (dispatch) {
  return (ResultDialog()
    ..resetGame = () {
      dispatch(ResetGameAction(true));
    });
})(castUiFactory(_$ResultDialog)); // ignore: undefined_identifier

mixin ResultDialogPropsMixin on UiProps {
  bool isFinished;
  List<Word> guesses;
  String wordToGuess;
  bool win;
  dynamic resetGame;
}

class ResultDialogProps = UiProps with ResultDialogPropsMixin;

mixin ResultDialogStateMixin on UiState {}

class ResultDialogState = UiState with ResultDialogStateMixin;

class ResultDialogComponent
    extends UiStatefulComponent2<ResultDialogProps, ResultDialogState> {
  @override
  render() {
    DomProps dom1 = Dom.div();
    String baseClass =
        'flex flex-col justify-around absolute bg-black h-1/3 w-1/3 inset-0 m-auto fixed text-white text-3xl p-1 text-center items-center';

    if (props.isFinished == false) {
      baseClass += ' hidden';
    }
    dom1.className = baseClass;

    DomProps textContainer = Dom.div();
    DomProps resetGameButton = Dom.button();

    dynamic Function(SyntheticMouseEvent) resetGame = (SyntheticMouseEvent e) {
      props.resetGame();
    };

    resetGameButton.onClick = resetGame;
    resetGameButton.className =
        'bg-slate-800 text-white text-sm w-1/2 h-1/4 min-w-fit';

    String result;
    if (props.isFinished == true &&
        props.guesses.last.word.toLowerCase() == props.wordToGuess) {
      result = 'You win!';
    } else {
      result =
          'The answer is ${props.wordToGuess.toUpperCase()}. Better luck next time!';
    }

    return dom1(textContainer(result), resetGameButton('Reset Game'));
  }
}
