import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_country_picker/country.dart';
import 'package:insta_cyber/generated/l10n.dart';
import 'package:insta_cyber/pages/login_page.dart';
import 'package:insta_cyber/pages/sign_up_name_password.dart';
import 'package:insta_cyber/utils/country_picker.dart';
import 'package:insta_cyber/utils/styles.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin{

  TextEditingController _userNumber;
  TextEditingController _userEmail;
  TabController _tabController;

  String numberCode= "US +1";
  bool emailOrNumberEmpty = true;
  bool invalidEmailOrNumber = false;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
    _tabController.addListener(() {
      _userNumber.clear();
      _userEmail.clear();
    });
    _userNumber = new TextEditingController();
    _userEmail = new TextEditingController();

    _userEmail.addListener(() {
      setState(() {
        invalidEmailOrNumber = false;
        emailOrNumberEmpty = _userEmail.text.isEmpty;
      });
    });
    _userNumber.addListener(() {
      setState(() {
        emailOrNumberEmpty = _userNumber.text.isEmpty || _userNumber.text.length <9;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      bottomSheet: _bottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            child: Stack(
              children: <Widget>[
                //6Image.asset('assets/insta_signup.png'),
                bodySignUp()
                //_body()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodySignUp(){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 27),
      child: new Column(
        children: <Widget>[
          SizedBox(height: 60.0),
          Image.asset('assets/accout_logo.png', width: 180),
          new Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 0.0),
                  height: MediaQuery.of(context).size.height*0.4,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: TabBar(
                      controller: _tabController,
                        indicatorColor: Colors.black,
                        tabs: [
                          Tab(child: Text(S.of(context).phoneNumber.toUpperCase(), style: TextStyle(color: Colors.black))),
                          Tab(child: Text(S.of(context).email.toUpperCase(), style: TextStyle(color: Colors.black))),
                        ]),
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        new Column(
                          children: <Widget>[
                            _userNumberEdit(),
                            Container(
                              margin: EdgeInsets.only(top: 14.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(S.of(context).youMayReceiveSMSUpdatesFromInstagram, style: AppStyles.textStyleGrey, textAlign: TextAlign.center,),
                                  )
                                ],
                              ),
                            ),
                            _nextButton()
                          ],
                        ),
                        new Column(
                          children: <Widget>[
                            _userEmailContainer(),
                            _nextButton()
                          ],
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _userNumberEdit() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 18.0),
      decoration: BoxDecoration(
          color: AppStyles.loginBackgroundColor,
          border: Border.all(color: AppStyles.loginBorderColor),
          borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: Container(
        padding: EdgeInsets.only(left: 14),
        child: new Row(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  _showLanguageDialog();
                },
                child: Center(
                  child: new Text(
                    numberCode, style: AppStyles.textStyleLoginHint.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: 17),
              child: Column(
                children: <Widget>[
                  new Expanded(
                    child: new Container(
                      width: 1.0,
                      color: AppStyles.loginBorderColor,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: new TextField(
                controller: _userNumber,
                cursorColor: Colors.grey,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration.collapsed(
                  hintText: S.of(context).phone,
                  hintStyle: AppStyles.textStyleLoginHint,
                ),
                style: AppStyles.textStyleBlack,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.clear,
                  color: _userNumber.text.isNotEmpty ? AppStyles.darkGrey : Colors.transparent,
                ),
                onPressed: () {
                  if (!_userNumber.text.isNotEmpty)
                    setState(() {
                      _userNumber.clear();
                    });
                })
          ],
        ),
      )
    );
  }

  Widget _userEmailContainer() {
    return new Column(
      children: <Widget>[
        Container(
          height: 50,
          margin: EdgeInsets.only(top: 18.0),
          decoration: BoxDecoration(
              color: AppStyles.loginBackgroundColor,
              border: Border.all(
                  color: invalidEmailOrNumber ? Colors.red : AppStyles.loginBorderColor),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Container(
              padding: EdgeInsets.only(left: 14),
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: new TextField(
                      controller: _userEmail,
                      cursorColor: Colors.grey,
                      decoration: new InputDecoration.collapsed(
                        hintText: S.of(context).email,
                        hintStyle: AppStyles.textStyleLoginHint,
                      ),
                      style: AppStyles.textStyleBlack,
                      onChanged: (v) {
                        setState(() {
                          invalidEmailOrNumber = false;
                          emailOrNumberEmpty = _userEmail.text.isEmpty;
                        });
                      },
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: !emailOrNumberEmpty ? AppStyles.darkGrey : Colors.transparent,
                      ),
                      onPressed: () {
                        if (!emailOrNumberEmpty)
                          setState(() {
                            _userEmail.clear();
                          });
                      })
                ],
              )),
        ),
        invalidEmailOrNumber ? Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
             Padding(
               padding: const EdgeInsets.only(top: 4.0),
               child: Text(S.of(context).invalidEmail, style: Theme.of(context).textTheme.caption.copyWith(color: Colors.red), textAlign: TextAlign.left),
             )
          ],
        ) : Container()
      ],
    );
  }

  Widget _nextButton() {
    return Container(
      margin: EdgeInsets.only(top: 4),
      child: new GestureDetector(
        onTap: !emailOrNumberEmpty ? _login : (){},
        child: new Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            color: emailOrNumberEmpty ? AppStyles.loginButtonInactiveColor : Colors.blue,
          ),
          margin: const EdgeInsets.only(top: 12.0),
          width: 500.0,
          height: 46.0,
          child: new Text(
            S.of(context).next,
            style: new TextStyle(color: Colors.white.withOpacity(emailOrNumberEmpty ? 0.4 : 1.0)),
          ),
        ),
      ),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Container(
                          height: 1.0,
                          color: AppStyles.loginBorderColor,
                        ),
                      )
                    ],
                  ),
                ),
                new Padding(
                  padding: new EdgeInsets.only(top: 17.5),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(S.of(context).alreadyHaveAccount, style: AppStyles.textStyleGrey),
                      new Text(" " + S.of(context).logIn, style: AppStyles.textStyleBlueGrey.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  void _login() {
    if (_userEmail.text.isNotEmpty && !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_userEmail.text))
      setState(() {
        invalidEmailOrNumber = true;
      });
    else  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPageNamePass(userNumber: _userNumber.text, userEmail: _userEmail.text)),
    );
  }

  _showLanguageDialog() async{
    Country c = await showDialog<Country>(
      context: context,
      builder: (BuildContext context) => CustomCountryDialog(number: true),
    );
    if(c!=null)
    setState(() {
      numberCode = c.isoCode + " +${c.dialingCode}";
    });
  }
}