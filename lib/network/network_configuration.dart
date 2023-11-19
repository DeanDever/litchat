
typedef HeaderConfigureCallback = Map<String, dynamic>? Function();
class NetworkConfiguration {
  //  域名
  String rootUrl = 'https://api.litdate.vip';
  // log
  bool enableLog = false;
  //  超时
  int timeout = 10;
  // 请求头配置回调
  HeaderConfigureCallback? headerConfigureCallback;

}