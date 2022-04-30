// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    json['wordToGuess'] as String,
    (json['guesses'] as List)
        ?.map(
            (e) => e == null ? null : Word.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['guess'] as String,
    (json['validWords'] as List)?.map((e) => e as String)?.toList(),
    json['isFinished'] as bool,
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'wordToGuess': instance.wordToGuess,
      'guesses': instance.guesses?.map((e) => e?.toJson())?.toList(),
      'guess': instance.guess,
      'validWords': instance.validWords,
      'isFinished': instance.isFinished,
    };
