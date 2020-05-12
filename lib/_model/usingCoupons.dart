import 'package:firebase_database/firebase_database.dart';

class usingCoupons {
  String usingCouponId;
  String orderID;
  String couponID;
  double beforeDiscount;
  double afterDiscount;

  usingCoupons();
  Map toJson() => {
        'orderID': orderID,
        'couponID': couponID,
        'beforeDiscount': beforeDiscount,
        'afterDiscount': afterDiscount
      };

  usingCoupons.fromSnapshot(DataSnapshot snap)
      : this.usingCouponId = snap.key,
        this.orderID = snap.value["orderID"],
        this.couponID = snap.value["couponID"],
        this.beforeDiscount = snap.value["beforeDiscount"],
        this.afterDiscount = snap.value["afterDiscount"];

  Map toMap() {
    return {
      "orderID": orderID,
      "couponID": couponID,
      "beforeDiscount": beforeDiscount,
      "afterDiscount": afterDiscount
    };
  }
}
