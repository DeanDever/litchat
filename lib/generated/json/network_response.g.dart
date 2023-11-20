import 'package:litchat/generated/json/base/json_convert_content.dart';
import 'package:litchat/network/network_response.dart';

NetworkResponse<T> $NetworkResponseFromJson<T>(Map<String, dynamic> json) {
  final NetworkResponse<T> networkResponse = NetworkResponse<T>();
  final int? status = jsonConvert.convert<int>(json['status']);
  if (status != null) {
    networkResponse.status = status;
  }
  final Map<String, dynamic>? content =
  (json['content'] as Map<String, dynamic>?)?.map(
          (k, e) => MapEntry(k, e == null ? null : e));
  if (content != null) {
    networkResponse.content = content;
  }
  final String? error = jsonConvert.convert<String>(json['error']);
  if (error != null) {
    networkResponse.error = error;
  }
  final T? object = jsonConvert.convert<T>(json['object']);
  if (object != null) {
    networkResponse.object = object;
  }
  return networkResponse;
}

Map<String, dynamic> $NetworkResponseToJson(NetworkResponse entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['status'] = entity.status;
  data['content'] = entity.content;
  data['error'] = entity.error;
  data['object'] = entity.object?.toJson();
  return data;
}

extension NetworkResponseExtension<T> on NetworkResponse {
  NetworkResponse copyWith({
    int? status,
    Map<String, dynamic>? content,
    String? error,
    T? object,
  }) {
    return NetworkResponse<T>()
      ..status = status ?? this.status
      ..content = content ?? this.content
      ..error = error ?? this.error
      ..object = object ?? this.object;
  }
}