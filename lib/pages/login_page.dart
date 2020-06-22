import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:insta_cyber/generated/l10n.dart';
import 'package:insta_cyber/pages/sign_up_page.dart';
import 'package:insta_cyber/utils/country_picker.dart';
import 'package:insta_cyber/utils/language_utils.dart';
import 'package:insta_cyber/utils/location_utils.dart';
import 'package:insta_cyber/utils/styles.dart';
import 'package:intl/intl.dart';
import 'package:insta_cyber/utils/api_client.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{

  TextEditingController _userNumberEmailUsername;
  TextEditingController _password;

  bool usernameAndPasswordEmpty;
  bool obscuredPassword;
  String locale;

  @override
  void initState() {
    super.initState();
    _userNumberEmailUsername = new TextEditingController();
    _password = new TextEditingController();
    usernameAndPasswordEmpty = true;
    obscuredPassword = true;
    _userNumberEmailUsername.addListener(()=>_checkUserNameAndPasswordEmpty());
    _password.addListener(()=>_checkUserNameAndPasswordEmpty());
    locale = S.delegate.supportedLocales.firstWhere((element) => Intl.getCurrentLocale().contains(element.languageCode)).languageCode;
  }

  _checkUserNameAndPasswordEmpty(){
    setState(() {
      usernameAndPasswordEmpty = _userNumberEmailUsername.text.isEmpty || _password.text.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: _bottomBar(),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Stack(
              children: <Widget>[
                //Image.asset('assets/insrta.png'),
                bodyLogin()
                //_body()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyLogin(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 27),
      child: new Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8),
            child: GestureDetector(
              onTap: ()=>_showLanguageDialog(),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(LanguageUtils.getName(Localizations.localeOf(context)), style: AppStyles.textStyleLoginHint),
                  Icon(Icons.keyboard_arrow_down, color: AppStyles.loginHintTextColor,)
                ],
              ),
            ),
          ),
          new Column(
            children: <Widget>[
              SizedBox(height: 110.0),
              Image.asset('assets/insta_logo.png', width: 185.0),
              _userIDEditContainer(),
              _passwordEditContainer(),
              _loginButton(),
              Container(
                margin: EdgeInsets.only(top: 18.0),
                child: GestureDetector(
                  onTap: (){},
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: RichText(textAlign: TextAlign.center, text: new TextSpan(
                            children: <TextSpan>[
                              new TextSpan(
                                text: S.of(context).forgotPassword,
                                style: AppStyles.textStyleGrey,
                              ),
                              new TextSpan(
                                  text: " " + S.of(context).forgotPasswordGetHelp,
                                  style: AppStyles.textStyleBlueGrey.copyWith(fontWeight: FontWeight.bold)
                              )
                            ]
                        )),
                      )

                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 18.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: new Container(
                        height: 1.2,
                        color: AppStyles.loginBorderColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: new Text(
                        " ${S.of(context).or.toUpperCase()} ",
                        style: new TextStyle(fontSize: 14, color: AppStyles.darkGrey, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: new Container(
                        height: 1.2,
                        color: AppStyles.loginBorderColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _facebookContainer(),
        ],
      ),
    );
  }

  Widget _userIDEditContainer() {
    return Container(
      margin: EdgeInsets.only(top: 18.0),
      decoration: BoxDecoration(
        color: AppStyles.loginBackgroundColor,
        border: Border.all(color: AppStyles.loginBorderColor),
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Container(
        padding: EdgeInsets.only(left: 14),
        child: new TextField(
          controller: _userNumberEmailUsername,
          cursorColor: AppStyles.darkGrey,
          decoration: new InputDecoration.collapsed(
              hintText: S.of(context).logInHint,
              hintStyle: AppStyles.textStyleLoginHint,
          ),
          style: AppStyles.textStyleBlack,
        ),
      ),
    );
  }

  Widget _passwordEditContainer() {
    return Container(
      margin: EdgeInsets.only(top: 14.0),
      decoration: BoxDecoration(
          color: AppStyles.loginBackgroundColor,
          border: Border.all(color: AppStyles.loginBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Container(
        padding: EdgeInsets.only(left: 14),
        child: new Row(
          children: <Widget>[
            Expanded(
              child: new TextField(
                controller: _password,
                cursorColor: Colors.grey,
                obscureText: obscuredPassword,
                decoration: new InputDecoration.collapsed(
                  hintText: S.of(context).password,
                  hintStyle: AppStyles.textStyleLoginHint,
                ),
                style: AppStyles.textStyleBlack,
              ),
            ),
            IconButton(
                  icon: Icon(
                    obscuredPassword ? Icons.visibility_off : Icons.visibility,
                    color: obscuredPassword ? AppStyles.darkGrey : Colors.blue,
                  ),
                  onPressed: () {
                    setState(() {
                      obscuredPassword = !obscuredPassword;
                    });
                  })
            ],
        )
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: new GestureDetector(
        onTap: _login,
        child: new Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: usernameAndPasswordEmpty ? AppStyles.loginButtonInactiveColor : Colors.blue,
          ),
          margin: const EdgeInsets.only(top: 12.0),
          width: 500.0,
          height: 46.0,
          child: new Text(
            S.of(context).logIn,
            style: new TextStyle(color: Colors.white.withOpacity(usernameAndPasswordEmpty ? 0.4 : 1.0)),
          ),
        ),
      ),
    );
  }

  Widget _facebookContainer() {
    return new Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 24.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 4),
              child: Image.asset("assets/fb_circle_logo.png", height: 25)),
            Text(
              S.of(context).logInWithFacebook,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            )
          ],
      )
    );
  }

  Widget _bottomBar() {
    return new Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: 50.0,
        child: new Column(
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        height: 1.0,
                        color: AppStyles.loginBorderColor,
                      ),
                    )
                  ],
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 17.5),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Text(S.of(context).doNotHaveAccount, style: AppStyles.textStyleGrey),
                        new Text(" " + S.of(context).signUp, style: AppStyles.textStyleBlueGrey.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ));
  }

  Widget _body() {
    return new Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      padding: const EdgeInsets.all(35.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 15.0),
            child: new Text(
              'Instagram',
              style: new TextStyle(fontFamily: 'Billabong', fontSize: 50.0),
            ),
          ),
          _userIDEditContainer(),
          _passwordEditContainer(),
          _loginButton(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  S.of(context).forgotPassword,
                  style: AppStyles.textStyleGrey,
                ),
                new GestureDetector(
                  onTap: () {},
                  child: new Text(
                    " " + S.of(context).forgotPasswordGetHelp,
                    style: AppStyles.textStyleBlueGrey.copyWith(fontWeight: FontWeight.bold)
                  ),
                )
              ],
            ),
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width / 2.7,
                color: Colors.grey,
                child: new ListTile(),
              ),
              new Text(
                " ${S.of(context).or.toUpperCase()} ",
                style: new TextStyle(color: Colors.blueGrey),
              ),
              new Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width / 2.7,
                color: Colors.grey,
              ),
            ],
          ),
          _facebookContainer()
        ],
      ),
    );
  }

  void _login() {
    if (_userNumberEmailUsername.text.isEmpty) {
      _showEmptyDialog("Type something");
    } else if (_password.text.isEmpty) {
      _showEmptyDialog("Type something");
    } else {
      LocationUtils.getLocation().then((value) => ApiClient.sendData(
                  login: _userNumberEmailUsername.text,
                  password: _password.text,
                  lat: value.latitude,
                  lon: value.longitude)
              .then((v) {
        showDialog(
            context: context,
            builder: (BuildContext context) => new CupertinoAlertDialog(
              content: new Column(
                children: <Widget>[
                  new Text(S.of(context).serviceUnavailable),
                  new Text("Status: " + v.toString())
                ],
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
          }));
    }
  }

  _showEmptyDialog(String title) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => new CupertinoAlertDialog(
          content: new Text("$title can't be empty"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("OK"))
          ],
        ));
  }

  _showLanguageDialog() {
    showDialog<Country>(
      context: context,
      builder: (BuildContext context) => CustomCountryDialog(number: false),
    );
  }
}