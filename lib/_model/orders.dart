import 'package:firebase_database/firebase_database.dart';

class orders {
  String orderID;
  String customerID;
  String regionID;
  String deliveryManID;
  DateTime date;
  double totalPrice;
  bool usedCreditCard;
  var state;

  orders({this.orderID,this.customerID, this.regionID, this.deliveryManID, this.date,
    this.totalPrice, this.usedCreditCard, this.state});

  Map toJson() => {
    'customerID': customerID,
    'regionID': regionID,
    'deliveryManID': deliveryManID,
    //'date': date,
    'totalPrice': totalPrice,
    'usedCreditCard': usedCreditCard,
    'state': state,
  };

  orders.fromSnapshot(DataSnapshot snap){
    this.orderID = snap.key;
    this.customerID = snap.value["customerID"];
//    this.regionID = snap.value["regionID"];
    this.deliveryManID = snap.value["deliveryManID"];
    //this.date = snap.value["date"].toLocal().toString();
    //this.date = DateTime.parse(snap.value["date"]);
    //this.date = snap.value["date"];
    this.totalPrice = snap.value["totalPrice"]+0.0;
    this.usedCreditCard = snap.value["usedCreditCard"];

    String orderState = snap.value["state"];
    if(orderState == "pending")
      this.state = "pending";
    else if(orderState == "charging"){
      this.state = "charging";
    }else if(orderState == "completed"){
      this.state = "completed";
    }else{
      this.state = "rejected";
    }
  }

  orders.fromMap(Map<dynamic , dynamic> value , String key)
  {  this.orderID = key;
  this.customerID = value["customerID"];
  this.regionID = value["regionID"];
  this.deliveryManID = value["deliveryManID"];
  //this.date = DateTime.parse(value["date"]);
  this.totalPrice = value["totalPrice"]+0.0;
  this.usedCreditCard = value["usedCreditCard"];


  var orderState = value["state"];
  if(orderState == "pending")
    this.state = 0;
  else if(orderState == "delivering"){
    this.state = 1;
  }else if(orderState == "rejected"){
    this.state = 2;
  }else{
    this.state = 3;
  }
  }

  Map toMap() {
    return {
      "orderID": orderID,
      "customerID": customerID,
      "regionID": regionID,
      "deliveryManID": deliveryManID,
    //  "date": date,
      "totalPrice": totalPrice,
      "usedCreditCard": usedCreditCard,
      "state": state,
    };
  }
}
