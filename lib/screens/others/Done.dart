import 'dart:io';

import 'widgets/LoginHeader.dart';
import '../../utils/size_config.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    home: Done(),
  ));
}

class Done extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        return Container(
          child: Column(
            children: <Widget>[
              Card(
                  color: Color(0XFF21d493),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: SizeConfig.getResponsiveWidth(30.0),
                        height: SizeConfig.getResponsiveHeight(60.0),
                        //margin: EdgeInsets.only(bottom: SizeConfig.getResponsiveHeight(5.0),top:SizeConfig.getResponsiveHeight(10.0)),
                        child: Image.asset(
                          "assets/images/delivery_man.png",
                          //color: Colors.white,
                        ),
                      ),
                      Text(
                        "Delivery Man",
                        style: TextStyle(
                          fontSize: SizeConfig.getResponsiveWidth(25.0),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/done_header.png",
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Done",
                style: TextStyle(
                    fontSize: SizeConfig.getResponsiveWidth(30.0),
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/images/done.png",
                width: 300.0,
                height: 250.0,
                fit: BoxFit.cover,
              ),
              new FloatingActionButton(
                onPressed: ()=> exit(0),
                tooltip: 'Close app',
                child: new Icon(Icons.close),
              ),
//              Align(
//                alignment: Alignment.bottomCenter,
//                child: Container(
//                  height: 130,
//                    decoration: new BoxDecoration(
//                        color: Colors.blue,
//                        borderRadius: new BorderRadius.only(
//                            topLeft: const Radius.circular(40.0),
//                            topRight: const Radius.circular(40.0))),
//                    child:Center(
//                      child: new Text("Hi modal ?? "),
//                    )),
//              ),
            ],
          ),
        );
      });
    });
  }
}
