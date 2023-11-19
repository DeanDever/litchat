// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Skip {timer}s`
  String launch_skip_btn(Object timer) {
    return Intl.message(
      'Skip ${timer}s',
      name: 'launch_skip_btn',
      desc: '',
      args: [timer],
    );
  }

  /// `Successed`
  String get successed {
    return Intl.message(
      'Successed',
      name: 'successed',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get sign_in_with_google {
    return Intl.message(
      'Sign in with Google',
      name: 'sign_in_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with your phone`
  String get sign_in_with_your_phone {
    return Intl.message(
      'Sign in with your phone',
      name: 'sign_in_with_your_phone',
      desc: '',
      args: [],
    );
  }

  /// `Set Profile`
  String get set_profile {
    return Intl.message(
      'Set Profile',
      name: 'set_profile',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Album`
  String get album {
    return Intl.message(
      'Album',
      name: 'album',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Nickname`
  String get nickname {
    return Intl.message(
      'Nickname',
      name: 'nickname',
      desc: '',
      args: [],
    );
  }

  /// `Enter Nickname`
  String get enter_nickname {
    return Intl.message(
      'Enter Nickname',
      name: 'enter_nickname',
      desc: '',
      args: [],
    );
  }

  /// `Enter invite code`
  String get enter_invite_code {
    return Intl.message(
      'Enter invite code',
      name: 'enter_invite_code',
      desc: '',
      args: [],
    );
  }

  /// `upload your avatar`
  String get upload_your_avatar {
    return Intl.message(
      'upload your avatar',
      name: 'upload_your_avatar',
      desc: '',
      args: [],
    );
  }

  /// `Sign in means you agree`
  String get Sign_in_means_you_agree {
    return Intl.message(
      'Sign in means you agree',
      name: 'Sign_in_means_you_agree',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement & User Privacy Policy`
  String get user_agreement_user_privacy_policy {
    return Intl.message(
      'User Agreement & User Privacy Policy',
      name: 'user_agreement_user_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Gender can't be modified after selected`
  String get gender_cant_be_modified_after_selected {
    return Intl.message(
      'Gender can\'t be modified after selected',
      name: 'gender_cant_be_modified_after_selected',
      desc: '',
      args: [],
    );
  }

  /// `Gender can't be modified after selected. Please confirm.`
  String get gender_cant_be_modified_after_selected_please_confirm {
    return Intl.message(
      'Gender can\'t be modified after selected. Please confirm.',
      name: 'gender_cant_be_modified_after_selected_please_confirm',
      desc: '',
      args: [],
    );
  }

  /// `We keep your personal information private and safe.`
  String get we_keep_your_personal_information_private_and_safe {
    return Intl.message(
      'We keep your personal information private and safe.',
      name: 'we_keep_your_personal_information_private_and_safe',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'cn'),
      Locale.fromSubtags(languageCode: 'my'),
      Locale.fromSubtags(languageCode: 'th'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
