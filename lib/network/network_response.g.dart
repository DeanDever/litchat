// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkResponse _$NetworkResponseFromJson(Map<String, dynamic> json) =>
    NetworkResponse(
      status: json['status'] as int,
      content: json['content'] as Map<String, dynamic>?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$NetworkResponseToJson(NetworkResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'content': instance.content,
      'error': instance.error,
    };
