// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  String get logInHint {
    return Intl.message(
      'Phone number, email or username',
      name: 'logInHint',
      desc: '',
      args: [],
    );
  }

  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  String get forgotPassword {
    return Intl.message(
      'Forgot your login details?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  String get forgotPasswordGetHelp {
    return Intl.message(
      'Get help signing in.',
      name: 'forgotPasswordGetHelp',
      desc: '',
      args: [],
    );
  }

  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  String get signUpWithEmailOrPhoneNumber {
    return Intl.message(
      'Sign up with email or phone number',
      name: 'signUpWithEmailOrPhoneNumber',
      desc: '',
      args: [],
    );
  }

  String get phoneNumber {
    return Intl.message(
      'Phone',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  String get doNotHaveAccount {
    return Intl.message(
      'Don\'t have account?',
      name: 'doNotHaveAccount',
      desc: '',
      args: [],
    );
  }

  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  String get discard {
    return Intl.message(
      'Discard',
      name: 'discard',
      desc: '',
      args: [],
    );
  }

  String get discardInfo {
    return Intl.message(
      'Discard Info?',
      name: 'discardInfo',
      desc: '',
      args: [],
    );
  }

  String get discardInfoContent {
    return Intl.message(
      'If you go back now, any information you\'ve entered so far will be discarded',
      name: 'discardInfoContent',
      desc: '',
      args: [],
    );
  }

  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  String get youMayReceiveSMSUpdatesFromInstagram {
    return Intl.message(
      'You may receive SMS updates from Instagram and can opt out at any time',
      name: 'youMayReceiveSMSUpdatesFromInstagram',
      desc: '',
      args: [],
    );
  }

  String get selectCountry {
    return Intl.message(
      'Select your country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  String get selectLanguage {
    return Intl.message(
      'Select your language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  String get logInWithFacebook {
    return Intl.message(
      'Log in with Facebook',
      name: 'logInWithFacebook',
      desc: '',
      args: [],
    );
  }

  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  String get nameAndPassword {
    return Intl.message(
      'Name and password',
      name: 'nameAndPassword',
      desc: '',
      args: [],
    );
  }

  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  String get savePassword {
    return Intl.message(
      'Save Password',
      name: 'savePassword',
      desc: '',
      args: [],
    );
  }

  String get continueWithSyncContacts {
    return Intl.message(
      'Continue with Sync Contacts',
      name: 'continueWithSyncContacts',
      desc: '',
      args: [],
    );
  }

  String get continueWithoutSyncContacts {
    return Intl.message(
      'Continue without Syncing Contacts',
      name: 'continueWithoutSyncContacts',
      desc: '',
      args: [],
    );
  }

  String get yourContactsWillBeStored {
    return Intl.message(
      'Your contacts will be periodically synced and stored on Instagram servers to help you and other find friends, and to help ud provide a better service. To remove contacts, go to Settings and disconnect.',
      name: 'yourContactsWillBeStored',
      desc: '',
      args: [],
    );
  }

  String get learnMore {
    return Intl.message(
      'Learn more',
      name: 'learnMore',
      desc: '',
      args: [],
    );
  }

  String get serviceUnavailable {
    return Intl.message(
      'Service currently unavailable. Please try again later',
      name: 'serviceUnavailable',
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
      Locale.fromSubtags(languageCode: 'pl', countryCode: 'PL'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}