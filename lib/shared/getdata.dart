import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';



Future getdata(BuildContext context) async{
  String NPY = "";
  String firstname="";
  String lastname="";
  String phonenumber="";
  String getmale="";
  bool ismale;


  String pincode="";
  String housename="";
  String roadname="";
  String city="";
  String state="";
  String landmark="";
  String alternatephonenumber="";



  final user =  Provider.of<CustomUser>(context,listen: false);
  await DatabaseService().Userdata.doc(user.uid).get().then((value){                //returns map
    try{
      housename = value["Housename"];
      roadname = value["Roadname"];
      city = value["City"];
      state = value["State"];
      landmark = value["Landmark"];
      alternatephonenumber = value["AltPhone"];
      pincode = value["Pincode"];





      firstname = value["Firstname"];
      lastname =  value["Lastname"];
      phonenumber = value["Phone"];
      getmale = value["Gender"];
      if(!(getmale==NPY)){
        ismale = getmale=="male"?true:false;
      }
    }
    catch(e){               //if the keys are not present the nmake my own
      print("problematic");
      DatabaseService().Userdata.doc(user.uid).update({
        "Firstname" :"",
        "Lastname"  :"",
        "Phone"     :"",
        "Gender"    :"",

        "Housename" :"",
        "Roadname"  :"",
        "City"      :"",
        "State"     :"",
        "Landmark"  :"",
        "AltPhone"  :"",
        "Pincode"   :"",
      });
    }
  });

  return NamePage(firstname: firstname , lastname: lastname , ismale: ismale , phonenumber: phonenumber,housename: housename,roadname: roadname,city: city,state: state,landmark: landmark,alternatephonenumber: alternatephonenumber,pincode: pincode,emailid: user.emailid,id: user.uid);
}



Future getCartData(String uid,{bool id}) async{
  List listfinal = new List();
  List listid = new List();
  List listquantities = new List();
  List listmyprices = new List();
  List listname = new List();
  await DatabaseService().Userdata.doc(uid).collection("Cart").get().then((value) => value.docs.forEach((element)=>listfinal.add(CartProductInfo(name: element.get("name"), subinfo: element.get("subinfo"), price: element.get("price"), myprice: element.get("myprice"), quantity: element.get("quantity"), imageurl : element.get("imageurl"),id:element.id))));
  await DatabaseService().Userdata.doc(uid).collection("Cart").get().then((value) => value.docs.forEach((element){
    listid.add(element.id);
    listquantities.add(element.get("quantity"));
    listmyprices.add(element.get("myprice"));
    listname.add(element.get("name"));
  }));
  return id==null?listfinal: [listid,listquantities,listmyprices,listname];
}


void setCartData(BuildContext context,Product product, int quantity) async{
  final user = Provider.of<CustomUser>(context , listen:  false);
  try{
    await DatabaseService().Userdata.doc(user.uid).collection("Cart").doc(product.id).update(
        {
          "name" : product.name ,
          "subinfo" : product.subinfo,
          "price"  : product.price.toString(),
          "myprice" :product.myprice.toString(),
          "imageurl" : product.imageUrl,
          "quantity" :quantity.toString(),
        }
    );
  }
  catch(e){
    await DatabaseService().Userdata.doc(user.uid).collection("Cart").doc(product.id).set(
        {
          "name" : product.name ,
          "subinfo" : product.subinfo,
          "price"  :product.price.toString(),
          "myprice" :product.myprice.toString(),
          "imageurl" : product.imageUrl,
          "quantity" : quantity.toString(),
        }
    );
  }
}

void setOrderData(BuildContext context , String price) async{
  final user = Provider.of<CustomUser>(context , listen:  false);
  List temp = await getCartData(user.uid,id: true);
  String orderID = generateRandomString(25);

  try{
    await DatabaseService().Userdata.doc(user.uid).collection("Order").doc(orderID).set(
        {
          "itemsname" : FieldValue.arrayUnion(temp[3]),
          "itemsid": FieldValue.arrayUnion(temp[0]),
          "itemsquantity": FieldValue.arrayUnion(temp[1]),
          "itemsprice": FieldValue.arrayUnion(temp[2]),
          "totalprice" : price,
          "orderID"  : orderID,
          "completed" : "false",
        }
    );

    await DatabaseService().Orderdata.doc(orderID).set(
        {
          "itemsname" : FieldValue.arrayUnion(temp[3]),
          "itemsid": FieldValue.arrayUnion(temp[0]),
          "itemsquantity": FieldValue.arrayUnion(temp[1]),
          "itemsprice": FieldValue.arrayUnion(temp[2]),
          "totalprice" : price,
          "orderID"  : orderID,
          "completed" : "false",
        }
    );
  }catch(e){
    print(e.toString());
  }
}


Future getOrderData(BuildContext context) async{
  final user = Provider.of<CustomUser>(context , listen:  false);
  List active = new List();
  List passive = new List();
  await DatabaseService().Userdata.doc(user.uid).collection("Order").get().then((value) => value.docs.forEach((element) {
    try{
      if(element.get("completed")=="false"){
        active.add([List.from(element.get("itemsname")) , List.from( element.get("itemsquantity")) , List.from(element.get("itemsprice")) ,  element.get("totalprice") , element.get("orderID")]);
      }
      else{
        passive.add([List.from(element.get("itemsname")) , List.from( element.get("itemsquantity")) , List.from(element.get("itemsprice")) ,  element.get("totalprice") , element.get("orderID")]);
      }
    }
    catch(e)
    {
      print(e.toString());
    }

  }));

  return [active , passive];

}






class CartProductInfo{
  String id;
  String name;
  String subinfo;
  String price;
  String myprice;
  String quantity;
  String imageurl;
  CartProductInfo({this.name,this.subinfo,this.price,this.myprice, this.quantity,this.imageurl,this.id});
}







String generateRandomString(int len) {
  var r = Random();
  return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
}