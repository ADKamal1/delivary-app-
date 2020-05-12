import 'package:delivery_man/_model/familyBasket.dart';
import 'package:delivery_man/translation/global_translation.dart';
import 'package:delivery_man/utils/size_config.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class aboutCompany extends StatefulWidget {
  _aboutCompany createState() => new _aboutCompany();
}

class _aboutCompany extends State<aboutCompany> {

  familyBasket familyDetails;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  void getAboutCompany() async
  {
    await _database.reference()
        .child("familyBasket")
        .once()
        .then((DataSnapshot snapshot){
      Map<dynamic, dynamic> familBasket = snapshot.value;
      familBasket.forEach((key, value) {
        familyDetails = familyBasket.fromMap(value, key);
      });
    });
    if(mounted){
      setState(() {

      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
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
              child: (translations.currentLanguage == 'ar')?Text("معلومات عن الشركه",
                  style: TextStyle(fontSize: 17.0, color: Colors.white)):Text("About Company",
                  style: TextStyle(fontSize: 17.0, color: Colors.white))),
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Container(
                color: Color(0XFF21d493),
                height: SizeConfig.getResponsiveHeight(120),
                child: Image.asset('assets/images/about_company.png')),
            (familyDetails == null) ?Center(child:Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )): Directionality(
              textDirection: TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 15, right: 10, bottom: 20),
                child: Text(
                  (translations.currentLanguage == 'ar')? familyDetails.aboutArabic: familyDetails.about,
                  style: TextStyle(
                      wordSpacing: 6,
                      fontSize: 20,
                      fontFamily: 'SourceSansPro',
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
