import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';
import '../../../model/Order.dart';

class orderCard extends StatefulWidget {
  Order order;
  orderCard({this.order});

  @override
  _orderCardState createState() => _orderCardState();
}

class _orderCardState extends State<orderCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left:15.0),
        child: Text("${widget.order.orderName.toString()} ",style: TextStyle(
          color: Colors.black,
        ),),
      ),
      trailing:Container(
        width: 100,
        height: 25,
        decoration: BoxDecoration(
            color: Colors.yellow[100],
            borderRadius:
            new BorderRadius.all(Radius.circular(5.0))),
        //width: SizeConfig.getResponsiveWidth(90.0),
        //height: SizeConfig.getResponsiveHeight(30.0),
        child: Center(
          child: FittedBox(
            fit: BoxFit.cover,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                " Pending ",
                style: new TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
            ),
          ),
        ),
      ),

    );
  }

  String status(){

  }
}

//Widget orderStatus(){
//  if(Widg)
//}