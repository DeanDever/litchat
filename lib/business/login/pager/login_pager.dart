import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:litchat/generated/l10n.dart';
import 'package:svgaplayer_flutter/parser.dart';
import 'package:svgaplayer_flutter/player.dart';

import '../../../network/api/system_api.dart';

class LoginPager extends StatefulWidget {
  const LoginPager({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPagerState();
}

class _LoginPagerState extends State<LoginPager>
    with SingleTickerProviderStateMixin {
  SVGAAnimationController? _bgController;

  bool _isAgreePrivacy = true;

  @override
  void initState() {
    super.initState();
    _bgController = SVGAAnimationController(vsync: this);
    _loadAnimation();
    _getAppConfiguration();
  }

  @override
  void dispose() {
    _bgController?.dispose();
    _bgController = null;
    super.dispose();
  }

  /*获取App配置信息*/
  void _getAppConfiguration() {
    SystemAPIType.configurationCenter.configurationCenter()
        .then((value) {
      debugPrint('network success');
    }).catchError((err) {
      debugPrint('network error ${err}');
    });
  }

  /*加载背景动画*/
  void _loadAnimation() async {
    final videoItem =
        await SVGAParser.shared.decodeFromAssets('assets/svga/login_bg.svga');
    setState(() {
      _bgController?.videoItem = videoItem;
      _playAnimation();
    });
  }

  /*播放背景动画*/
  void _playAnimation() {
    if (_bgController?.isCompleted == true) {
      _bgController?.reset();
    }
    _bgController?.repeat();
  }

  void _onClickGoogleButton() {
    debugPrint('click google button');
  }

  void _onClickPhoneButton() {
    debugPrint('click Phone button');
  }

  void _onClickAppleButton() {
    debugPrint('click Apple button');
  }

  void _onClickFacebookButton() {
    debugPrint('click Facebook button');
  }

  void _onClickLineButton() {
    debugPrint('click Line button');
  }

  void _onClickMailButton() {
    debugPrint('click Mail button');
  }

  void _onClickAgreePrivacyButton() {
    debugPrint('click agree privacy button');
    setState(() {
      _isAgreePrivacy = !_isAgreePrivacy;
    });
  }

  void _onTapPrivacy() {
    debugPrint('on tap privacy');
  }

  Widget _generateLoginButton(
      AssetImage image, String title, double bottom, VoidCallback onPressed) {
    return Positioned(
      right: 72,
      left: 72,
      bottom: bottom,
      child: SizedBox(
        //  google登录按钮
        height: 48,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: Image(
            image: image,
            fit: BoxFit.fill,
            width: 48,
            height: 48,
          ),
          label: Text(
            title,
            maxLines: 2,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 14),
          ),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(const Color(0xFF000000)),
            padding: MaterialStateProperty.all(const EdgeInsets.only(right: 16)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24))),
            backgroundColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
            iconSize: MaterialStateProperty.all(48),
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }

  Widget _generateCircleLoginButton(AssetImage image, VoidCallback onPressed) {
    return SizedBox(
      width: 48,
      height: 48,
      child: IconButton(
        icon: Image(
          image: image,
          fit: BoxFit.fitHeight,
        ),
        // iconSize: 48,
        enableFeedback: true,
        padding: const EdgeInsets.all(0),
        onPressed: onPressed,
      ),
    );
  }

  Widget _generateFacebookButton() {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return _generateCircleLoginButton(
        const AssetImage('assets/login/login_fb_btn.png'),
        () {
          _onClickFacebookButton();
        },
      );
    }
    return const SizedBox(width: 0, height: 48);
  }

  Widget _generateAppleButton() {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _generateCircleLoginButton(
        const AssetImage('assets/login/login_apple_btn.png'),
        () {
          _onClickAppleButton();
        },
      );
    }
    return const SizedBox(width: 0, height: 48);
  }

  Widget _generateMoreLoginButton() {
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Positioned(
      bottom: 88,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _generateFacebookButton(),
          SizedBox(width: isAndroid ? 24 : 0, height: 48),
          _generateCircleLoginButton(
            const AssetImage('assets/login/login_line_btn.png'),
            () {
              _onClickLineButton();
            },
          ),
          const SizedBox(width: 24, height: 48),
          _generateAppleButton(),
          SizedBox(width: isIOS ? 24 : 0, height: 48),
          _generateCircleLoginButton(
            const AssetImage('assets/login/login_email_btn.png'),
            () {
              _onClickMailButton();
            },
          ),
        ],
      ),
    );
  }

  Widget _generatePrivacy() {
    return Positioned(
      bottom: 24,
      right: 10,
      left: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              icon: Image.asset(
                _isAgreePrivacy
                    ? 'assets/common/common_checked_img.png'
                    : 'assets/common/common_uncheck_img.png',
                fit: BoxFit.fitWidth,
              ),
              iconSize: 24,
              padding: const EdgeInsets.all(4),
              onPressed: () {
                _onClickAgreePrivacyButton();
              },
            ),
          ),
          Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFFFFFFFF),
              ),
              children: [
                TextSpan(text: S.of(context).Sign_in_means_you_agree),
                TextSpan(
                  text: S.of(context).user_agreement_user_privacy_policy,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xFFFFFFFF),
                    decorationThickness: 2,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTapUp = (details) {
                      _onTapPrivacy();
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            top: 0,
            bottom: 0,
            child: SVGAImage(
              _bgController!,
              fit: BoxFit.fitWidth,
              clearsAfterStop: true,
              allowDrawingOverflow: true,
              filterQuality: FilterQuality.high,
              preferredSize: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
            ),
          ),
          _generateLoginButton(
              const AssetImage('assets/login/login_gg_btn.png'),
              S.of(context).sign_in_with_google,
              220, () {
            _onClickGoogleButton();
          }),
          _generateLoginButton(
              const AssetImage('assets/login/login_phone_btn.png'),
              S.of(context).sign_in_with_your_phone,
              156, () {
            _onClickPhoneButton();
          }),
          _generateMoreLoginButton(),
          _generatePrivacy()
        ],
      ),
    );
  }
}
