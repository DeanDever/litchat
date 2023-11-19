
import 'package:litchat/network/network_api.dart';
import 'package:litchat/network/network_engine.dart';
import 'package:litchat/network/network_request.dart';
import 'package:litchat/network/network_response.dart';

class NetworkHandler {
  static Future<NetworkResponse> sendRequest(NetworkAPI api, {Map<String, dynamic>? params}) async {
    NetworkRequest request = NetworkRequest(api, params);
    return NetworkEngine().sendRquest(request);
  }
}