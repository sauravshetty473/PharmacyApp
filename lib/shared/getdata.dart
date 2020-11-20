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



Future getCartData(String user) async{
  List listfinal = new List();
 final list = await DatabaseService().Userdata.doc(user).collection("Cart").get().then((value) => value.docs.forEach((element)=>listfinal.add(CartProductInfo(name: element.get("name"), subinfo: element.get("subinfo"), price: element.get("price"), myprice: element.get("myprice"), quantity: element.get("quantity"), imageurl : element.get("imageurl"),id:element.id))));
 print(listfinal);
 return listfinal;
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
/*
void setWishList(BuildContext context,Product product, int quantity) async{
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
}   */















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