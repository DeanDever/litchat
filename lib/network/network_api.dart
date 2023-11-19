
enum NetworkRequestType {
  get,
  post,
  download,
  upload
}

enum NetworkDataSerializableType {
  json,
  http
}

abstract class NetworkAPI {

  NetworkRequestType get requestType {
    return NetworkRequestType.get;
  }

  NetworkDataSerializableType get serializableType {
    return NetworkDataSerializableType.json;
  }

  bool get enableCache {
    return false;
  }

  String get uri {
    return '';
  }

}