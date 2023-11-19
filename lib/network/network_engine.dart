import 'package:dio/dio.dart';
import 'package:litchat/network/network_configuration.dart';
import 'package:litchat/network/network_request.dart';
import 'package:litchat/network/network_response.dart';

class NetworkEngine {
  static final Dio _dio = Dio();

  static NetworkConfiguration _configuration = NetworkConfiguration();

  static Future<NetworkResponse> sendRquest(NetworkRequest request) async {
    String url = _configuration.rootUrl + request.api.uri();

    //  请求头
    Map<String, dynamic>? headers;
    if (_configuration.headerConfigureCallback != null) {
      _configuration.headerConfigureCallback!();
    }

    final option = Options(
        headers: headers,
        sendTimeout: Duration(seconds: _configuration.timeout),
        responseType: ResponseType.json);

    final r = await _dio.get(url, queryParameters: request.params, options: option);
    // switch (request.api.requestType) {
    //   case NetworkRequestType.get:
    //     r = await _dio.get(url, request);
    //     break;
    //   case NetworkRequestType.post:
    //     r = await _dio.post(url);
    //     break;
    //   default:
    //     break;
    // }

    return NetworkResponse.fromJson(r.data);
  }

  static void download(String url) async {}

  static void updload() async {}

  static void setConfiguration(NetworkConfiguration configuration) {
    _configuration = configuration;
  }
}
