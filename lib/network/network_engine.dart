import 'package:dio/dio.dart';
import 'package:litchat/network/network_configuration.dart';
import 'package:litchat/network/network_request.dart';
import 'package:litchat/network/network_response.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import 'network_api.dart';

class NetworkEngine {
  // Global options
  final _options = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),

    // All subsequent fields are optional.

    // Default.
    policy: CachePolicy.request,
    // Overrides any HTTP directive to delete entry past this duration.
    // Useful only when origin server has no cache config or custom behaviour is desired.
    // Defaults to [null].
    maxStale: const Duration(minutes: 1),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended when [true].
    allowPostMethod: false,
  );

  final Dio _dio = Dio();

  NetworkConfiguration _configuration =
      NetworkConfiguration(rootUrl: 'https://api.github.com');

  //  单例
  NetworkEngine._internal() {
      _dio.interceptors.add(DioCacheInterceptor(options: _options));
      if (_configuration.enableLog) {
        _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
      }
  }

  factory NetworkEngine() => _instance;

  static final NetworkEngine _instance = NetworkEngine._internal();

  void setConfiguration(NetworkConfiguration configuration) {
    _configuration = configuration;
  }

  Future<NetworkResponse<T>> sendRquest<T>(NetworkRequest request) async {
    String url = _configuration.rootUrl + request.api.uri;

    //  请求头
    Map<String, dynamic>? headers;
    if (_configuration.headerConfigureCallback != null) {
      headers = _configuration.headerConfigureCallback!(request);
    }

    Options option = Options(
        headers: headers,
        sendTimeout: Duration(seconds: _configuration.timeout),
        responseType: ResponseType.json);

    Response<dynamic>? r;
    switch (request.api.requestType) {
      case NetworkRequestType.get:
        if (!request.api.enableCache) {
          option = _options.copyWith(policy: CachePolicy.refresh).toOptions();
        }
        r = await _dio.get(url,
            queryParameters: request.params, options: option);
        break;
      case NetworkRequestType.post:
        r = await _dio.post(url,
            queryParameters: request.params, options: option);
        break;
      default:
        break;
    }

    NetworkResponse<T> res;
    if (r != null) {
      res = NetworkResponse<T>.fromJson(r.data);
    } else {
      res = NetworkResponse<T>();
      res.error = 'request type error';
    }

    if (res.status != 0) {
      if (_configuration.errorCallback != null) {
        _configuration.errorCallback!(request, res);
      }
      return throw res.error ?? 'unknown error';
    } else {
      return res;
    }
  }

  Future<void> download(String url, String destinationPath,
      void Function(int count, int total) progressCallback) async {
     await _dio.download(url, onReceiveProgress: progressCallback,
        destinationPath);
  }

}
