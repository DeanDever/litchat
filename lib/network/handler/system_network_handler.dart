
import 'package:litchat/network/api/system_api.dart';
import 'package:litchat/network/network_handler.dart';

class SystemNetworkHandler extends NetworkHandler {

  static Future<Map<String, dynamic>?> getConfiguration() async {
    SystemAPI api = SystemAPI(type: SystemAPIType.configurationCenter);
    var response = await NetworkHandler.sendRequest(api);
    return response.content;
  }

}