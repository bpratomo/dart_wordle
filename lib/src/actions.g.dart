// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewGuessAction _$AddNewGuessActionFromJson(Map<String, dynamic> json) {
  return AddNewGuessAction(
    json['value'] == null
        ? null
        : Word.fromJson(json['value'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddNewGuessActionToJson(AddNewGuessAction instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
