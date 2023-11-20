
import 'package:litchat/business/common/model/app_configuration.dart';
import 'package:litchat/network/network_api.dart';
import 'package:litchat/network/network_handler.dart';
import 'package:litchat/network/network_response.dart';

enum SystemAPIType {
  configurationCenter,
  sensitiveWords,
}

extension SystemAPITypeExtension on SystemAPIType {
  Future<NetworkResponse> configurationCenter() {
    return _sendRequest<AppConfiguration>();
  }

  Future<NetworkResponse<T>> _sendRequest<T>({Map<String, dynamic>? params}) {
    var api = SystemAPI(type: this);
    return NetworkHandler.sendRequest<T>(api, params: params);
  }
}

class SystemAPI extends NetworkAPI {

  final SystemAPIType type;

  SystemAPI({required this.type});

  @override
  String get uri {
    switch (type) {
      case SystemAPIType.configurationCenter:
        return '/admin/systemVersionConfig/listAll';
      case SystemAPIType.sensitiveWords:
        return '/security/sensitiveWord/listAll';
    }
  }

  @override
  NetworkRequestType get requestType {
    switch (type) {
      default:
        return NetworkRequestType.get;
    }
  }

  @override
  NetworkDataSerializableType get serializableType {
    switch (type) {
      default:
        return NetworkDataSerializableType.json;
    }
  }
}