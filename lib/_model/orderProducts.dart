import 'package:firebase_database/firebase_database.dart';

class orderProducts {
  String orderProductID;
  String orderID;
  String productID;
  dynamic quantity;
  dynamic price;

  orderProducts(this.orderID, this.productID, this.quantity, this.price);

  Map toJson() => {
        'orderProductID': orderProductID,
        'orderID': orderID,
        'productID': productID,
        'quantity': quantity,
        'price': price
      };

  orderProducts.fromSnapshot(DataSnapshot snap)
      : this.orderProductID = snap.key,
        this.orderID = snap.value["orderID"],
        this.productID = snap.value["productID"],
        this.quantity = snap.value["quantity"],
        this.price = snap.value["price"];

  orderProducts.fromMap(Map<dynamic , dynamic> value , String key)
      : this.orderProductID = key,
        this.orderID = value["orderID"],
        this.productID = value["productID"],
        this.quantity = value["quantity"],
        this.price = value["price"];


  Map toMap() {
    return {
      "orderProductID": orderProductID,
      "orderID": orderID,
      "productID": productID,
      "quantity": quantity,
      "price": price
    };
  }
}
