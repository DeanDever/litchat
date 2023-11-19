import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:litchat/generated/l10n.dart';
import 'package:svgaplayer_flutter/parser.dart';
import 'package:svgaplayer_flutter/player.dart';

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
  }

  @override
  void dispose() {
    _bgController?.dispose();
    _bgController = null;
    super.dispose();
  }

  void _loadAnimation() async {
    final videoItem =
        await SVGAParser.shared.decodeFromAssets('asstes/svga/login_bg.svga');
    setState(() {
      _bgController?.videoItem = videoItem;
      _playAnimation();
    });
  }

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
          ),
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(const TextStyle(
                color: Color(0xFF000000),
                fontSize: 14,
              )),
              padding:
                  MaterialStateProperty.all(const EdgeInsets.only(left: 16)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24))),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFFFFFFFF)),
              iconSize: MaterialStateProperty.all(48)),
        ),
      ),
    );
  }

  Widget _generateCircleLoginButton(AssetImage image, VoidCallback onPressed) {
    return CupertinoButton(
      child: Image(
        image: image,
        fit: BoxFit.fitWidth,
      ),
      onPressed: () {
        _onClickFacebookButton();
      },
    );
  }

  Widget _generateMoreLoginButton() {
    return Positioned(
      bottom: 88,
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 2,
            child: _generateCircleLoginButton(
              const AssetImage('assets/login/login_fb_btn.png'),
              () {
                _onClickFacebookButton();
              },
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 2,
            child: _generateCircleLoginButton(
              const AssetImage('assets/login/login_line_btn.png'),
              () {
                _onClickLineButton();
              },
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 2,
            child: _generateCircleLoginButton(
              const AssetImage('assets/login/login_apple_btn.png'),
              () {
                _onClickAppleButton();
              },
            ),
          ),
          const Spacer(flex: 1),
          Expanded(
            flex: 2,
            child: _generateCircleLoginButton(
              const AssetImage('assets/login/login_mail_btn.png'),
              () {
                _onClickMailButton();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _generatePrivacy() {
    return Positioned(
      bottom: 24,
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              _onClickAgreePrivacyButton();
            },
            child: Image.asset(
              _isAgreePrivacy
                  ? 'assets/common/common_checked_img.png'
                  : 'assets/common/common_uncheck_img.png',
              fit: BoxFit.fitWidth,
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
              fit: BoxFit.fill,
              clearsAfterStop: true,
              allowDrawingOverflow: false,
              filterQuality: FilterQuality.high,
              preferredSize: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
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
