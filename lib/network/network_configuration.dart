import 'package:litchat/network/network_request.dart';
import 'package:litchat/network/network_response.dart';

typedef HeaderConfigureCallback = Map<String, dynamic>? Function();
typedef NetworkErrorPluginCallback = void Function(
    NetworkRequest request, NetworkResponse response);

class NetworkConfiguration {
  //  域名
  final String rootUrl;

  // log
  bool enableLog = false;

  //  超时
  int timeout = 5;

  // 请求头配置回调
  HeaderConfigureCallback? headerConfigureCallback;

  // 错误毁掉
  NetworkErrorPluginCallback? errorCallback;

  NetworkConfiguration(
      {required this.rootUrl,
      this.timeout = 5,
      this.enableLog = false,
      this.headerConfigureCallback,
      this.errorCallback});
}
