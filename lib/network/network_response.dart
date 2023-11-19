// import 'litchat.g.dart';

@JsonSerializable()
class NetworkResponse {

  @JsonKey(name: 'statue')
  int status = -1;
  @JsonKey(name: 'content')
  Map? content;
  @JsonKey(name: 'error')
  String? error;

  // factory NetworkResponse.fromJson(Map<String, dynamic> json) => _$NetworkResponseFromJson(json);
  // Map<String, dynamic> toJson() => _$NetworkResponseToJson(this);

// NetworkResponse.fromJson(Map<String, dynamic> json)
  //     : status = json['status'],
  //       content = json['content'],
  //       error = json['error'];
}