import 'dart:io';
import 'package:delivery_man/_model/customerOrderDetails.dart';
import 'package:delivery_man/_model/deliveryMen.dart';
import 'package:delivery_man/screens/others/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../utils/size_config.dart';
import 'others/missionsOrderScreen.dart';
import 'company/aboutCompany.dart';
import 'company/ContactUs_screen.dart';
import 'company/privacyPolicy.dart';
import 'package:flutter/material.dart';
import '../model/orderData.dart';
import '../translation/global_translation.dart';
import '../translation/settings.dart';
import 'package:firebase_database/firebase_database.dart';

class SideMenu extends StatefulWidget {
  List<customerOrderDetails> customerDetails = <customerOrderDetails>[];
  SideMenu({this.customerDetails});
  @override
  _sideMenuState createState() => _sideMenuState();
}

class _sideMenuState extends State<SideMenu> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  deliveryMen deliveryMenDetails;

  getDelivaryDetails() async {
    String delivaryId;
    await FirebaseAuth.instance.currentUser().then((user) {
      delivaryId = "22";
    });

    await _database
        .reference()
        .child("deliveryMen")
        .child(delivaryId)
        .once()
        .then((DataSnapshot snapshot) {
      deliveryMenDetails = deliveryMen.fromSnapshot(snapshot);
      if (mounted) {
        setState(() {});
      }
    });
  }

  initState() {
    getDelivaryDetails();
  }



  @override
  Widget build(BuildContext context) {
    if(deliveryMenDetails == null){
      deliveryMenDetails = new deliveryMen("name", "name", "phone", "email", "region");
    }
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: SizeConfig.getResponsiveHeight(270.0),
            width: MediaQuery.of(context).size.width,
            child: DrawerHeader(
              child: Container(
                //color: Colors.white,
                child: Column(
                  children: <Widget>[
                    //SizedBox(height: SizeConfig.getResponsiveHeight(5.0),),
                    Text(
                      translations.text("loginPage.deliveryManText"),
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.height >= 736 ? 30 : 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/profile.png',
                        width: SizeConfig.getResponsiveWidth(130.0),
                        height: SizeConfig.getResponsiveHeight(100.0),
                        fit: BoxFit.fill,
                      ),
                    ),
                    translations.text("loginPage.btn") == "Login"
                        ? Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 50.0),
                                  child: Text(
                                    deliveryMenDetails.name,
                                  ),
                                )

                                //(onPressed: (){}, icon: Icon(Icons.edit), label: Text("")),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 50.0),
                                  child: Text(deliveryMenDetails.arabicName),
                                )

                                //(onPressed: (){}, icon: Icon(Icons.edit), label: Text("")),
                              ],
                            ),
                          ),
                    translations.text("loginPage.btn") == "Login"
                        ? Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    margin:
                                        EdgeInsets.only(top: 50, right: 50.0),
                                    child: Text(

                                        deliveryMenDetails.phone)),
                              ],
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(top: 20, left: 30.0),
                                  child: Text(deliveryMenDetails.phone)),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => contactUs())),
              //onTap: () {},
              leading: Image.asset(
                'assets/images/icons/side_contact.png',
                color: Color(0XFF21d493),
                width: SizeConfig.getResponsiveWidth(35.0),
              ),
              title: Text(
                translations.text("sideMenu.sideMenuContact"),
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: MediaQuery.of(context).size.height >= 736 ? 26 : 18,
                ),
              )),
          ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => missionAllOrder(
                          customerDetails: widget.customerDetails))),
              //onTap: () {},
              leading: Image.asset(
                'assets/images/icons/side_all_order.png',
                color: Color(0XFF21d493),
                width: SizeConfig.getResponsiveWidth(35.0),
              ),
              title: Text(
                translations.text("sideMenu.sideMenuNumberOfMissions"),
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: MediaQuery.of(context).size.height >= 736 ? 26 : 18,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Divider(
              height: SizeConfig.getResponsiveHeight(10.0),
              thickness: 1.0,
            ),
          ),
          ListTile(
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => privacyPolicy())),
              //onTap: () {},
              leading: Image.asset(
                'assets/images/icons/side_privacy.png',
                color: Color(0XFF21d493),
                width: SizeConfig.getResponsiveWidth(35.0),
              ),
              title: Text(
                translations.text("sideMenu.sideMenuPrivacyPolicy"),
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: MediaQuery.of(context).size.height >= 736 ? 26 : 18,
                ),
              )),
          ListTile(
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => aboutCompany())),
              //onTap: () {},
              leading: Image.asset(
                'assets/images/icons/side_about_company.png',
                color: Color(0XFF21d493),
                width: SizeConfig.getResponsiveWidth(35.0),
              ),
              title: Text(
                translations.text("sideMenu.sideMenuAboutCompany"),
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: MediaQuery.of(context).size.height >= 736 ? 26 : 18,
                ),
              )),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
            leading: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0),
              child: Icon(
                Icons.settings,
                color: Color(0XFF21d493),
                size: 30,
              ),
            ),
            title: Text(translations.text('sideMenu.sideMenuChangeLanguage'),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height >= 736 ? 26 : 18,
                )),
          ),
          ListTile(
              //onTap: (){exit(0);},
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              leading: Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: Icon(
                  Icons.exit_to_app,
                  color: Color(0XFF21d493),
                  size: SizeConfig.getResponsiveHeight(25.0),
                ),
              ),
              title: Text(
                translations.text("sideMenu.sideMenuExit"),
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: MediaQuery.of(context).size.height >= 736 ? 26 : 18,
                ),
              )),
        ],
      ),
    );
  }
}
