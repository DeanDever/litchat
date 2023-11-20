import 'package:litchat/generated/json/base/json_convert_content.dart';
import 'package:litchat/business/common/model/app_configuration.dart';

AppConfiguration $AppConfigurationFromJson(Map<String, dynamic> json) {
  final AppConfiguration appConfiguration = AppConfiguration();
  final String? appMinVersion = jsonConvert.convert<String>(
      json['app_min_version']);
  if (appMinVersion != null) {
    appConfiguration.appMinVersion = appMinVersion;
  }
  return appConfiguration;
}

Map<String, dynamic> $AppConfigurationToJson(AppConfiguration entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['app_min_version'] = entity.appMinVersion;
  return data;
}

extension AppConfigurationExtension on AppConfiguration {
  AppConfiguration copyWith({
    String? appMinVersion,
  }) {
    return AppConfiguration()
      ..appMinVersion = appMinVersion ?? this.appMinVersion;
  }
}