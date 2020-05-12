import '../../model/Order.dart';
import 'Done.dart';
import '../../utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';

class qrCodeScan extends StatefulWidget {
  //Order order;
  //qrCodeScan({this.order});

  @override
  _scanPageState createState() => _scanPageState();
}

class _scanPageState extends State<qrCodeScan> {
  ///text to print Qr code
  String barcode = "";
  //String qrcodeForClient = this.widget.order.order_qrCode;

  // method Qr code scan
  Future scanCode({String orderQrCode}) async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() =>
      this.barcode = barcode,);
      /// !  that make codition donot true
      if(barcode==orderQrCode){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Done()));
      }
    } catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF21d493),
        title: Text('Scan Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: Text(
                  'Scan QR code From Coustomer',
                  style: TextStyle(
                      color: Color(0XFF21d493),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            /*
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                "assets/images/qrimage.png",
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
            */
            Padding(

              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: Text(
                '$barcode',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: SizeConfig.getResponsiveWidth(30.0),
            ),
            GestureDetector(
              onTap: (){
                scanCode;
              },
              child: ClipOval(
                child: Container(
                  color: Color(0XFF21d493),
                  height: SizeConfig.getResponsiveWidth(90.0),
                  // height of the button
                  width: SizeConfig.getResponsiveWidth(90.0),
                  // width o the button
                  child: Center(
                    child: Icon(
                      Icons.scanner,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
