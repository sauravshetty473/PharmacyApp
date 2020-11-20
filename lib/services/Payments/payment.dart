import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';



class Payment extends StatefulWidget {
  String amount;
  String name;
  String email;

  Payment({this.amount ,this.name , this.email});
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
      "key" : "rzp_test_kca3MIeJuxK23C",
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



  void handlerPaymentSuccess(String e){
    Fluttertoast.showToast(msg: "Payment successful");
    print("sdfasdfsadfsadf");
  }
  void handlerPaymentError(String e){
    Fluttertoast.showToast(msg: "Payment error");
  }
  void handlerExternal(String e){
   print("External");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Order Summary"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(),
            ),
            Container(
              decoration : BoxDecoration(
                color: Color.fromARGB(255, 21, 35, 55),
                borderRadius: BorderRadius.all(
                    Radius.circular(5)
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              margin: EdgeInsets.symmetric(vertical: 10),

              child: FlatButton(
                onPressed: (){
                  openCheckout();
                },
                child: Text("Proceed to Pay",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),),
              ),
            )
          ],

        ),
      ),
    );
  }
}
