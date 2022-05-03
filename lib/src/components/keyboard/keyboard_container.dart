import 'package:dart_wordle/src/components/keyboard/keyboard_row.dart';
import 'package:over_react/over_react.dart';

part 'keyboard_container.over_react.g.dart';

UiFactory<KeyboardContainerProps> KeyboardContainer =
    castUiFactory(_$KeyboardContainer); // ignore: undefined_identifier

mixin KeyboardContainerPropsMixin on UiProps {}

class KeyboardContainerProps = UiProps with KeyboardContainerPropsMixin;

class KeyboardContainerComponent extends UiComponent2<KeyboardContainerProps> {
  @override
  get defaultProps => (newProps());

  @override
  render() {
    DomProps container = Dom.div();
    container.className =
        'fixed h-1/4 w-full bg-slate-800 inset-x-0 bottom-0 flex flex-col justify-center align-center px-[5%] py-[3%] ';
    dynamic topRow = KeyboardRow()..chars = 'QWERTYUIOP'.split('');
    dynamic middleRow = KeyboardRow()..chars = 'ASDFGHJKL'.split('');
    dynamic bottomRow = KeyboardRow()
      ..chars = ['Enter'] + 'ZXCVBNM'.split('') + ['Backspace'];
    return container(topRow(), middleRow(), bottomRow());
  }
}
