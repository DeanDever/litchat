
import 'package:litchat/network/network_api.dart';

class NetworkRequest {

  final NetworkAPI api;

  final Map<String, dynamic>? params;

  const NetworkRequest(this.api, this.params);

}