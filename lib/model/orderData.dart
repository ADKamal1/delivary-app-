import 'package:flutter/material.dart';
import 'Order.dart';

abstract class OrderData{
  List<Order> getOrders(){return new List<Order>();}

}


////- that class not important Should deleted , we use " ord.dart "  to get data from firebase







//get dummy data
class getStoreDummyData extends OrderData{
  List<Order> getOrders(){
      List<Order> allOrder = new List<Order>();
      allOrder.add(new Order("Tomatoes", true,"Egypt-cairo-ramsis",240,"assets/images/profile1.jpg"));
      allOrder.add(new Order("Tomatoes", true,"Egypt-Aswan",350,"assets/images/profile3.jpg"));
      allOrder.add(new Order("Tomatoes", true,"Egypt-Fayoum-atsa",222,"assets/images/profile2.jpg"));
      allOrder.add(new Order("Tomatoes", true,"Egypt-cairo-munib",420,"assets/images/profile2.jpg"));

      allOrder.add(new Order("Tomatoes", false,"Egypt-cairo-ramsis",240,"assets/images/profile1.jpg"));

      return allOrder;
  }


}


