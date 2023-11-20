import 'package:litchat/generated/json/base/json_field.dart';
import 'package:litchat/generated/json/app_configuration.g.dart';
import 'dart:convert';
export 'package:litchat/generated/json/app_configuration.g.dart';

@JsonSerializable()
class AppConfiguration {
	@JSONField(name: "min_app_version")
	String appMinVersion = '999.999.999';
	@JSONField(name: "current_app_version")
	String appVersion = '1.0.0';
	@JSONField(name: "sensitive_version")
	int sensitiveWordVersion = 0;
	@JSONField(name:"gift_material_version")
	int svgaResourceVersion = 0;
	@JSONField(name: "gift_material_url")
	String? svgaResourceUrl;
	@JSONField(name: "plane_count_down")
	double paperPlaneCountDownTime = 60;
	@JSONField(name: "tag_choose_count_limit")
	int maxUserTagCount = 10;
	@JSONField(name: "tag_create_word_limit")
	int maxUserTagLength = 20;
	@JSONField(name: "enable_accosted_match")
	bool enableChatUp = false;
	@JSONField(name: "enable_toolbar_summoned")
	bool enableRoomConvene = false;
	@JSONField(name: "h5_domain")
	String webRootUrl = 'https://api.litdate.vip';
	@JSONField(name:"share_type")
	List<String> suppertSharePlatform = ['FB'];
	@JSONField(name: "enable_room_share_facebook")
	bool enableShareRoomToFB = false;
	@JSONField(name: "enable_room_share_web")
	bool enableShareRoomToWeb = false;

	AppConfiguration();

	factory AppConfiguration.fromJson(Map<String, dynamic> json) => $AppConfigurationFromJson(json);

	Map<String, dynamic> toJson() => $AppConfigurationToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}