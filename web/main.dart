import 'dart:html';
import 'package:over_react/over_react_flux.dart';
import 'package:over_react/react_dom.dart' as react_dom;

// Example of where the `Foo` component might be exported from
import 'package:dart_wordle/dart_wordle.dart';

void main() {
  // Mount / render your component/application.
  final container = querySelector('#react_mount_point');
  final app = (ReduxProvider()..store = getStore())(Wordle()());
  react_dom.render(
    app,
    container
  );
}
