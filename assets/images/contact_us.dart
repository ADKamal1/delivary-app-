import 'package:delivery_man/_model/familyBasket.dart';
import 'package:delivery_man/utils/size_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class contactUs extends StatefulWidget {
  _contactUs createState() => new _contactUs();
}

class _contactUs extends State<contactUs> {

  familyBasket familyDetails;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  void getAboutCompany() async
  {
    await _database.reference()
        .child("familyBasket")
        .once()
        .then((DataSnapshot snapshot){
      familyDetails = familyBasket.fromSnapshot(snapshot);

    });
    if(mounted){
      setState(() {

      });
    }
  }
  initState(){
    getAboutCompany();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF21d493),
          leading: Container(
            margin: EdgeInsets.only(top: 10.0),
            child:InkWell(
              onTap: (){Navigator.pop(context);},
              child:Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),),
          ),
          title: Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text("Contafct us",
                  style: TextStyle(fontSize: 17.0, color: Colors.white))),
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body:(familyDetails == null)? Container(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ): ListView(
          children: <Widget>[
            Container(
                color: Color(0XFF21d493),
                height: SizeConfig.getResponsiveHeight(120),
                child: Image.asset('assets/images/contact_us.png')),
            (familyDetails.telephone == null)?Container():Center(
              child:  Container(
                margin: EdgeInsets.only(top: SizeConfig.getResponsiveHeight(60)),
                child: Text(familyDetails.telephone , style: TextStyle(fontSize: SizeConfig.getResponsiveWidth(33)),),
              ),
            ),(familyDetails.address == null)?Container():Center(
              child: Container(
                margin: EdgeInsets.only(top: SizeConfig.getResponsiveHeight(20)),
                child: Text("address : " + familyDetails.address , style: TextStyle(fontWeight:FontWeight.bold,fontSize: SizeConfig.getResponsiveWidth(15)),),
              ),
            ),Center(
              child:  Container(
                margin: EdgeInsets.only(top: SizeConfig.getResponsiveHeight(70)),
                child: Text("Also you can contact wllith us by social Media"  , style: TextStyle(fontSize: SizeConfig.getResponsiveWidth(14)),),
              ),
            ),

             Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            (familyDetails.whatsApp == null)?Container():InkWell(
              onTap: ()async{
                if (await canLaunch(familyDetails.whatsApp)) {
                  await launch(familyDetails.whatsApp);
                } else {
                  throw 'Could not launch ${familyDetails.whatsApp}';
                }
              },
              child: CircleAvatar(
                radius:40,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage("assets/images/whatsapp.png"),
              ),
            ),


            (familyDetails.facebook == null)?Container():InkWell(
              onTap: ()async{
                if (await canLaunch(familyDetails.facebook)) {
                  await launch(familyDetails.facebook);
                } else {
                  throw 'Could not launch ${familyDetails.facebook}';
                }
              },
              child:CircleAvatar(   backgroundColor: Colors.transparent,
                radius: 60,
                backgroundImage: AssetImage("assets/images/fblogo.png"),
              ),
            ),


            (familyDetails.twitter == null)?Container():InkWell(
               onTap: ()async{
                 if (await canLaunch(familyDetails.twitter)) {
                 await launch(familyDetails.twitter);
                 } else {
                 throw 'Could not launch ${familyDetails.twitter}';
                 }
               },

              child:  CircleAvatar(
                backgroundColor: Colors.transparent,
                radius:40,
                backgroundImage: AssetImage("assets/images/twitterlogo.png"),
              ),
            )

          ],
        ),
      )
          ],
        ),
      ),
    );
  }
}
