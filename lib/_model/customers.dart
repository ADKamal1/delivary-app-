import 'package:firebase_database/firebase_database.dart';

enum Gender { male, female }

class customers {
  String customerID;
  String name;
  String gender;
  String email = "email not provided";
  String phone = "phone not provided";
  String regionID;
  bool isBlocked;
  double latitude;
  double longitude;


  customers({this.name, this.gender, this.email, this.phone, this.regionID,
    this.isBlocked,this.latitude,this.longitude});

  Map toJson() => {
    "latitude":latitude,
    "longitude":longitude,
    "name": name,

    "gender": gender,
    "email": email,
    "phone": phone,
    "regionID": regionID,
    "isBlocked": isBlocked
  };

  customers.fromSnapshot(DataSnapshot snap)
      : this.customerID = snap.key,

  this.latitude=snap.value["latitude"],
  this.longitude=snap.value["longitude"],

        this.name = snap.value["name"],
        this.gender = snap.value["gender"],
        this.email = snap.value["email"],
        this.phone = snap.value["phone"],
        this.isBlocked = snap.value["isBlocked"],
        this.regionID = snap.value["regionID"];

  customers.fromMap(Map<dynamic, dynamic> value, String key)
      :  this.customerID = key,

        this.latitude=value["latitude"],
        this.longitude=value["longitude"],

      this.name = value["name"],
        this.gender = value["gender"],
        this.email = value["email"],
        this.phone = value["phone"],
        this.isBlocked = value["isBlocked"],
        this.regionID = value["regionID"];

  Map toMap() {
    return {
      "name": name,
      "gender": gender,
      "email": email,
      "phone": phone,
      "regionID": regionID,
      "isBlocked": isBlocked,
    "latitude":latitude,
      "longitude":longitude

    };
  }
}
