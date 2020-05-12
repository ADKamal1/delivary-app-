import 'package:firebase_database/firebase_database.dart';

class deliveryMen {
  String name;
  String arabicName;
  String phone;
  String email;
  String regionID;
  String deliveryMenID;

  deliveryMen(
      this.name, this.arabicName, this.phone, this.email, this.regionID);

  Map toJson() => {
        "name": name,
        "arabicName": arabicName,
        "phone": phone,
        "email": email,
        "regionID": regionID
      };

  deliveryMen.fromSnapshot(DataSnapshot snap)
      : this.deliveryMenID = snap.key,
        this.name = snap.value["name"],
        this.arabicName = snap.value["arabicName"],
        this.phone = snap.value["phone"],
        this.email = snap.value["email"],
        this.regionID = snap.value["regionID"];

  deliveryMen.fromMap(Map<dynamic, dynamic> value, String key)
      : this.deliveryMenID = key,
        this.name = value["name"],
        this.arabicName = value["arabicName"],
        this.phone = value["phone"],
        this.email = value["email"],
        this.regionID = value["regionID"];

  Map toMap() {
    return {
      "name": name,
      "arabicName": arabicName,
      "phone": phone,
      "email": email,
      "regionID": regionID
    };
  }
}
