
import 'package:litchat/network/network_api.dart';

enum SystemAPIType {
  configurationCenter,
  sensitiveWords,
}
class SystemAPI extends NetworkAPI {

  final SystemAPIType type;

  SystemAPI({required this.type});

  @override
  String get uri {
    switch (type) {
      case SystemAPIType.configurationCenter:
        return '';
      case SystemAPIType.sensitiveWords:
        return '';
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