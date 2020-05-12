import 'package:firebase_database/firebase_database.dart';

class coupons {
  String couponID;
  String cobonCode;
  double decreaseRate;
  double maxDecrease;
  String fromDate;
  String toDate;

  coupons(this.cobonCode, this.decreaseRate, this.maxDecrease, this.fromDate,
      this.toDate);

  Map toJson() => {
        'cobonCode': cobonCode,
        'decreaseRate': decreaseRate,
        'maxDecrease': maxDecrease,
        'fromDate': fromDate,
        'toDate': toDate
      };
  coupons.fromMap(Map<dynamic , dynamic> value , String key)
      :this.couponID = key,
        this.cobonCode = value["cobonCode"],
        this.decreaseRate = double.parse(value["decreaseRate"]),
        this.maxDecrease = double.parse(value["maxDecrease"]),
        this.fromDate =value["fromDate"],
        this.toDate = value["toDate"];
  coupons.fromSnapshot(DataSnapshot snap)
      : this.couponID = snap.key,
        this.cobonCode = snap.value["cobonCode"],
        this.decreaseRate = snap.value["decreaseRate"],
        this.maxDecrease = snap.value["maxDecrease"],
        this.fromDate = snap.value["fromDate"],
        this.toDate = snap.value["toDate"];

  Map toMap() {
    return {
      "cobonCode": cobonCode,
      "decreaseRate": decreaseRate,
      "maxDecrease": maxDecrease,
      "fromDate": fromDate,
      "toDate": toDate
    };
  }
}
