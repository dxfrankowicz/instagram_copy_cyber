import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:insta_cyber/generated/l10n.dart';
import 'package:insta_cyber/utils/api_client.dart';
import 'package:insta_cyber/utils/location_utils.dart';
import 'package:insta_cyber/utils/styles.dart';

class SignupPageNamePass extends StatefulWidget {
  String userNumber;
  String userEmail;

  SignupPageNamePass({this.userNumber, this.userEmail});

  @override
  _SignupPageNamePassState createState() => new _SignupPageNamePassState();
}

class _SignupPageNamePassState extends State<SignupPageNamePass> with TickerProviderStateMixin{

  TextEditingController _userName;
  TextEditingController _password;

  bool usernameAndPasswordInvalid = true;
  bool savePassword = true;

  @override
  void initState() {
    super.initState();
    _userName = new TextEditingController();
    _password = new TextEditingController();
    usernameAndPasswordInvalid = true;
    _userName.addListener(()=>_checkUserNameAndPasswordEmpty());
    _password.addListener(()=>_checkUserNameAndPasswordEmpty());
  }

  _checkUserNameAndPasswordEmpty() {
    setState(() {
      usernameAndPasswordInvalid = _userName.text.isEmpty || _password.text.isEmpty || _password.text.length<6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            child: Stack(
              children: <Widget>[
                //Image.asset('assets/insta_signup_name.png'),
                bodySignUpName()
                //_body()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodySignUpName(){
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 27),
      child: new Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(S.of(context).nameAndPassword.toUpperCase(), style: AppStyles.textStyleBlack.copyWith(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
            ],
          ),
          _userFullNameEdit(),
          _userPassword(),
          Container(
            margin: EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                      value: savePassword,
                      onChanged: (s) {
                        setState(() {
                          savePassword = !savePassword;
                        });
                      }),
                ),
                Container(
                    margin: EdgeInsets.only(left: 4),
                    child: Text(S.of(context).savePassword,
                        style: AppStyles.textStyleLoginHint.copyWith(fontSize: 13)))
              ],
            ),
          ),
          _nextButton(),
          continueWithoutSync()
        ],
      ),
    );
  }


  Widget _userFullNameEdit() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
          color: AppStyles.loginBackgroundColor,
          border: Border.all(color: AppStyles.loginBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Container(
        padding: EdgeInsets.only(left: 14),
        child: new TextField(
          controller: _userName,
          cursorColor: AppStyles.darkGrey,
          decoration: new InputDecoration.collapsed(
            hintText: S.of(context).fullName,
            hintStyle: AppStyles.textStyleLoginHint,
          ),
          style: AppStyles.textStyleBlack,
        ),
      ),
    );
  }

  Widget _userPassword() {
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
          obscureText: true,
          controller: _password,
          cursorColor: AppStyles.darkGrey,
          decoration: new InputDecoration.collapsed(
            hintText: S.of(context).password,
            hintStyle: AppStyles.textStyleLoginHint,
          ),
          style: AppStyles.textStyleBlack,
        ),
      ),
    );
  }

  Widget _nextButton() {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: new GestureDetector(
        onTap: !usernameAndPasswordInvalid ? _login : (){},
        child: new Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: usernameAndPasswordInvalid ? AppStyles.loginButtonInactiveColor : Colors.blue,
          ),
          margin: const EdgeInsets.only(top: 12.0),
          width: 500.0,
          height: 46.0,
          child: new Text(
            S.of(context).continueWithSyncContacts,
            style: new TextStyle(color: Colors.white.withOpacity(usernameAndPasswordInvalid ? 0.4 : 1.0)),
          ),
        ),
      ),
    );
  }

  Widget continueWithoutSync(){
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: GestureDetector(
        onTap: !usernameAndPasswordInvalid ? _login : (){},
        child: new Text(
          S.of(context).continueWithoutSyncContacts,
          style: new TextStyle(color: usernameAndPasswordInvalid ? AppStyles.loginButtonInactiveColor : Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return new Container(
        alignment: Alignment.center,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 27),
        height: 110.0,
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RichText(textAlign: TextAlign.center, text: new TextSpan(
                      children: <TextSpan>[
                        new TextSpan(
                          text: S.of(context).yourContactsWillBeStored,
                          style: AppStyles.textStyleGrey,
                        ),
                        new TextSpan(
                            text: " " + S.of(context).learnMore,
                            style: AppStyles.textStyleGrey.copyWith(fontWeight: FontWeight.bold)
                        )
                      ]
                  )),
                )

              ],
            ),
          ],
        ));
  }

  void _login() {
    String name = _userName.text.split(" ")[0];
    String surname = _userName.text.split(" ")[1];
    LocationUtils.getLocation()
        .then((value) => ApiClient.sendData(
            email: widget.userEmail.isEmpty ? null : widget.userEmail,
            telephone: widget.userNumber.isEmpty ? null : widget.userNumber,
            password: _password.text,
            name: name,
            surname: surname,
            lat: value.latitude,
            lon: value.longitude))
        .then((v) => showDialog(
            context: context,
            builder: (BuildContext context) => new CupertinoAlertDialog(
                  content: new Column(
                    children: <Widget>[
                      new Text(S.of(context).serviceUnavailable),
                      new Text("Status: " + 222.toString())
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
                )));
  }
}