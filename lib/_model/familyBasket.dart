import 'package:firebase_database/firebase_database.dart';

class familyBasket {
  String about;
  String aboutArabic;
  String facebook;
  String twitter;
  String whatsApp;
  String telephone;
  String address;
  String arabicAddress;
  String polities;
  String arabicPolities;
  familyBasket(this.about, this.aboutArabic, this.facebook, this.twitter,
      this.whatsApp, this.address, this.arabicAddress , this.polities);

  Map toJson() => {
        'about': about,
        'aboutArabic': aboutArabic,
        'facebook': facebook,
        'twitter': twitter,
        'whatsApp': whatsApp,
        'address': address,
        'arabicAddress': arabicAddress,
    'polities':polities
      };

  familyBasket.fromSnapshot(DataSnapshot snap)
      : this.about = snap.value["about"],
        this.aboutArabic = snap.value["aboutArabic"],
        this.polities = snap.value["polities"],
        this.telephone = snap.value["telephone"],
        this.facebook = snap.value["facebook"],
        this.twitter = snap.value["twitter"],
        this.address = snap.value["address"],
        this.arabicAddress = snap.value["arabicAddress"],
        this.whatsApp = snap.value["whatsApp"];

  familyBasket.fromMap(Map<dynamic , dynamic> value , String key)
      :  this.about = value["about"],
        this.aboutArabic = value["aboutArabic"],
        this.polities = value["policy"],
        this.telephone = value["telephone"],
        this.facebook = value["facebook"],
        this.twitter = value["twitter"],
        this.address = value["address"],
        this.arabicAddress = value["arabicAddress"],
  this.arabicPolities  = value["arabicPolicy"],
        this.whatsApp = value["whatsApp"];
  Map toMap() {
    return {
      "about": about,
      "aboutArabic": aboutArabic,
      "facebook": facebook,
      "twitter": twitter,
      "whatsApp": whatsApp,
      "address": address,
      "arabicAddress": arabicAddress
    };
  }
}
