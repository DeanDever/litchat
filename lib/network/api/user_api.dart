import 'package:litchat/network/network_api.dart';

enum UserAPIType {
  login,
  phoneLigin,
  emailLogin,
  resetPassword,
  register,
  signOut,
}
class UserAPI extends NetworkAPI {

  final UserAPIType type;

  UserAPI({required this.type});

  @override
  String get uri {
    switch (type) {
      case UserAPIType.login:
        return '';
      case UserAPIType.phoneLigin:
        return '';
      case UserAPIType.emailLogin:
        return '';
      case UserAPIType.resetPassword:
        return '';
      case UserAPIType.register:
        return '';
      case UserAPIType.signOut:
        return '';
    }
  }

  @override
  NetworkRequestType get requestType {
    switch (type) {
      case UserAPIType.login:
      case UserAPIType.phoneLigin:
      case UserAPIType.emailLogin:
      case UserAPIType.resetPassword:
      case UserAPIType.register:
      case UserAPIType.signOut:
      default:
        return NetworkRequestType.get;
    }
  }

  @override
  NetworkDataSerializableType get serializableType {
    switch (type) {
      default:
        return NetworkDataSerializableType.json;
    }
  }
}