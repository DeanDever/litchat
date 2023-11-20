import 'package:litchat/network/network_request.dart';
import 'package:litchat/network/network_response.dart';

class NetworkExcpetion implements Exception {

  final NetworkRequest request;

  final NetworkResponse response;

  NetworkExcpetion({required this.request, required this.response});

  @override
  String toString() {
    return '${request.api.uri} => ${response.error} + ${response.status}';
  }
}