import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';
import 'package:shavishank/shared/getdata.dart';
import 'package:shavishank/shared/loadingscreen.dart';
import 'package:shavishank/shared/orders.dart';
import 'package:shavishank/shared/textformfield.dart';



class Payment extends StatefulWidget {
  String amount;
  String name;
  String email;

  // ignore: non_constant_identifier_names
  List CartItems;

  // ignore: non_constant_identifier_names
  Payment({this.amount ,this.name , this.email ,this.CartItems});
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool done =false;
  Razorpay razorpay;

  @override
  void initState() {
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternal);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void openCheckout(){
    var options = {
      "key" : "Your_key_goes_here",         //payment gateway key
      "amount" : int.parse(widget.amount)*100,
      "name"  : "Payment",
      "description" : "payment for the products",
      "prefill" : {
        "contact" : widget.name,
        "email"   :widget.email,
      },
      "external" : {
        "wallets" : ["paytm"],
      }
    };
    try{
      razorpay.open(options);
    }
    catch(e){
      print(e.toString());
    }
  }



  void handlerPaymentSuccess(PaymentSuccessResponse successResponse){
    setOrderData(context,widget.amount,false);
    Fluttertoast.showToast(msg: "Payment successful");
    setState(() {
      done = true;
    });
  }
  void handlerPaymentError(PaymentFailureResponse e){
    print(e);
    Fluttertoast.showToast(msg: "Payment error");
  }
  void handlerExternal(ExternalWalletResponse e){
    setOrderData(context,widget.amount,false);
    Fluttertoast.showToast(msg: "Payment successful");
    setState(() {
      done = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return !done?Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255,78,100,123),
        elevation: 0,
        title: Text("Order Summary"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: OrderTable(amount: widget.amount , CartItems: widget.CartItems,)
                ),
              ),
            ),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration : BoxDecoration(
                  color: Color.fromARGB(255, 21, 35, 55),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5)
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                margin: EdgeInsets.symmetric(vertical: 30,horizontal: 10),

                child: FlatButton(
                  onPressed: (){
                    openCheckout();
                  },
                  child: Text("Online Payment",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),),
                ),
              ),
              Container(
                decoration : BoxDecoration(
                  color: Color.fromARGB(255, 21, 35, 55),
                  borderRadius: BorderRadius.all(
                      Radius.circular(5)
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                child: FlatButton(
                  onPressed: () async{
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Loading()));
                    await setOrderData(context,widget.amount,true);


                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);

                    Fluttertoast.showToast(msg: "Order placed");
                  },
                  child: Text("Cash on Delivery",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),),
                ),
              ),
            ],
          )
        ],
      ),
    ):Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Order Created"),
      ),

      body: Center(child: FlatButton(
        color: Colors.black,
        child : Text("Back to home", style: TextStyle(color: Colors.white),),
        onPressed: (){
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),),
    );
  }
}


