import 'package:litchat/generated/json/base/json_field.dart';

import '../generated/json/network_response.g.dart';

@JsonSerializable()
class NetworkResponse<T> {
	//	状态码
	int status = -1;
	//	返回体
	Map<String, dynamic>? content;
	//	错误信息
	String? error;
	// 序列化对象
	T? object;

	NetworkResponse();

	factory NetworkResponse.fromJson(Map<String, dynamic> json) => $NetworkResponseFromJson<T>(json);

	Map<String, dynamic> toJson() => $NetworkResponseToJson(this);

}