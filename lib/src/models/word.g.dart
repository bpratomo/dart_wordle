// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) {
  return Word(
    json['word'] as String,
    json['wordToGuess'] as String,
  )..result = (json['result'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as String),
    );
}

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'word': instance.word,
      'wordToGuess': instance.wordToGuess,
      'result': instance.result?.map((k, e) => MapEntry(k.toString(), e)),
    };
