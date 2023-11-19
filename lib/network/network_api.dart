
enum NetworkRequestType {
  get,
  post,
  download,
  upload
}

enum NetworkDataSerializableType {
  JSON,
  HTTP
}

abstract class NetworkAPI {

  NetworkRequestType requestType = NetworkRequestType.get;

  NetworkDataSerializableType serializableType = NetworkDataSerializableType.JSON;

  String uri();

}