import 'package:json_annotation/json_annotation.dart';
part 'network_response.g.dart';

@JsonSerializable()
class NetworkResponse {

  @JsonKey(name: 'status')
  int status = -1;
  @JsonKey(name: 'content')
  Map<String, dynamic>? content;
  @JsonKey(name: 'error')
  String? error;

  NetworkResponse({required this.status, this.content, this.error});

  factory NetworkResponse.fromJson(Map<String, dynamic> json) => _$NetworkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkResponseToJson(this);
}