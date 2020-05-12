import 'package:firebase_database/firebase_database.dart';

class offerProducts {
  String offerProductID;
  String offerID;
  String productID;

  offerProducts({this.offerID, this.productID});

  Map toJson() => {
    'offerProductID': offerProductID,
    'offerID': offerID,
    'productID': productID,
  };

  offerProducts.fromSnapshot(DataSnapshot snap)
      : this.offerProductID = snap.key,
        this.offerID = snap.value["offerID"],
        this.productID = snap.value["productID"];
  offerProducts.fromMap(Map<dynamic , dynamic> value , String key)
      : this.offerProductID = key,
        this.offerID = value["offerID"],
        this.productID = value["productID"];

  Map toMap() {
    return {
      "offerProductID": offerProductID,
      "offerID": offerID,
      "productID": productID,
    };
  }
}
