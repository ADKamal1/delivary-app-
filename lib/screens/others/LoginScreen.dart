import 'package:delivery_man/Animation/FadeAnimation.dart';
import '../../translation/global_translation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainScreen.dart';
import 'widgets/LoginHeader.dart';
import '../../utils/size_config.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login>{
    final formKey = new GlobalKey<FormState>();
  String _email,_password;
  var _isLoading = false;


  // to show message in error statu
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(translations.text("loginPage.showError"),),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(translations.text("loginPage.showErrorbtnText"),),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }else
      return false;
  }

  void validateAndSubmit()async{
   // CircularProgressIndicator()
    setState(() {
      _isLoading = true;
    });


    if(validateAndSave()){
        try{
          FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _email, password: _password)).user;

          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(builder: (context)=> yourOrder())
          );


        }
         catch (error) {
           String errorMessage;
          if(error.toString().contains('EMAIL_NOT_FOUND'))
            {
              errorMessage = 'Could not find a user with that email.';
            }
              errorMessage =
              'there are mistake in email or password. Please try again later.';
          _showErrorDialog(errorMessage);
        }
      }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Stack(children: <Widget>[
              new ListView(
                children: <Widget>[
                  FadeAnimation(1.0,LoginHeader(),),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        FadeAnimation( 1.3,Card(
                          margin: EdgeInsets.all(30.0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              translations.text("loginPage.LoginPageRecivedText"),
                              style: TextStyle(
                                  fontSize: SizeConfig.getResponsiveWidth(15.0),
                                  color: Colors.grey,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),),
                        FadeAnimation(1.6,Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 25, left: 25),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Invalid email!';
                              }
                            },
                            onSaved: (value) => _email= value,
                            //controller: _textFieldController,

                            decoration: new InputDecoration(
                              labelText: translations.text("loginPage.textFieldUserName"),

                              prefixIcon: new Image.asset(
                                "assets/images/icons/username.png",
                                height: 40,
                                width: 40,
                              ),
                              //labelText: AppLocalizations.of(context).categoryNameFruite,
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),),
                      FadeAnimation(
                          1.9,Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 25, left: 25),
                          child: TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty || value.length < 5) {
                                return 'Password is too short!';
                              }
                            },
                            onSaved: (value) =>_password=value,
                            decoration: new InputDecoration(
                              prefixIcon: new Image.asset(
                                "assets/images/icons/password.png",
                                width: 30,
                                height: 30,
                              ),
                              labelText: translations.text("loginPage.textFieldPassword"),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                          ),
                        ),),
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30.0, right: 25, left: 25),
                          child:FadeAnimation(2.2, Container(
                            width: 300,
                            height: 50,
                            child: RaisedButton(
                              onPressed: validateAndSubmit,
                              color: Color(0XFF21d493),
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              child: Text(
                                  translations.text("loginPage.btn"),
                                style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        );
      });
    });
  }


}


