
import 'package:flutter/cupertino.dart';

class Order {
   String _orderName;
   bool _orderStatus;
   String _orderAdress;
   double _orderPrice;
   String _orderClintImagePath;

   Order(this._orderName, this._orderStatus,this._orderAdress,this._orderPrice,this._orderClintImagePath);

   set orderPrice(double value) {
      _orderPrice = value;
   }
   set orderClintImagePath(String value) {
      _orderClintImagePath = value;
   }
   set orderStatus(bool value) {
      _orderStatus = value;
   }
   set orderAdress(String value) {
      _orderAdress = value;
   }
   set orderName(String value) {
      _orderName = value;
   }

   String get orderName => _orderName;
   String get orderAdress => _orderAdress;
   double get orderPrice => _orderPrice;
   bool get orderStatus => _orderStatus;
   String get orderClintImagePath => _orderClintImagePath;



}
