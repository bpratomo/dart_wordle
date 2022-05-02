import 'package:dart_wordle/src/components/keyboard/keyboard_key.dart';
import 'package:over_react/over_react.dart';

part 'keyboard_row.over_react.g.dart';

UiFactory<KeyboardRowProps> KeyboardRow =
    castUiFactory(_$KeyboardRow); // ignore: undefined_identifier

mixin KeyboardRowPropsMixin on UiProps {
  List<String> chars;
}

class KeyboardRowProps = UiProps with KeyboardRowPropsMixin;

mixin KeyboardRowStateMixin on UiState {}

class KeyboardRowState = UiState with KeyboardRowStateMixin;

class KeyboardRowComponent
    extends UiStatefulComponent2<KeyboardRowProps, KeyboardRowState> {
  @override
  get defaultProps => (newProps());

  @override
  get initialState => (newState());

  @override
  render() {
    List<ReactElement> children =
        props.chars.map((e) => _renderItem(e)).toList();
    DomProps container = Dom.div();
    container.className = 'flex flex-row justify-center text-lg p-0.5 h-1/3';
    return container(children);
  }
}

ReactElement _renderItem(String char) {
  var component = KeyboardKey();
  component.char = char;
  component.key = char;
  return component();
}
