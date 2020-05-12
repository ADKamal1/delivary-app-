import 'package:delivery_man/_model/cities.dart';
import 'package:delivery_man/_model/customers.dart';
import 'package:delivery_man/_model/orders.dart';
import 'package:delivery_man/_model/regions.dart';

class customerOrderDetails {
  customers customer;
  orders order;
  regions region;
  cities city;

  customerOrderDetails({this.customer, this.order , this.region , this.city});

}