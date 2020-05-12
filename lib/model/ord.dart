import 'package:firebase_database/firebase_database.dart';

class Orderr {
  String key;
  String orClientName;
  String orStatus;
  String orClientAddress;
  String orClientPhoneNumber;
  int orPrice;
  double orClientLatitude;
  double orClientLongtitude;
  String orProductName;


  Orderr(this.orClientName, this.orStatus, this.orClientAddress, this.orPrice,
    this.orClientPhoneNumber,this.orClientLatitude,this.orClientLongtitude);

  Orderr.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        orClientName = snapshot.value["oClientName"],
        orStatus = snapshot.value["oStatus"],
        orClientAddress = snapshot.value["oClientAddress"],
        orPrice = snapshot.value["oPrice"],
        orClientPhoneNumber = snapshot.value["oClientPhoneNumber"],
        orClientLatitude = snapshot.value["oClientLatitude"],
        orClientLongtitude = snapshot.value["oClientLongtitude"];


  toJson() {
    return {
      "oClientName": orClientName,
      "oStatus": orStatus,
      "oClientAddress": orClientAddress,
      "oPrice": orPrice,
      "oClientPhoneNumber": orClientPhoneNumber,
      "oClientLatitude": orClientLatitude,
      "oClientLongtitude": orClientLongtitude

    };
  }
}
