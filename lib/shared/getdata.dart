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

  return NamePage(firstname: firstname , lastname: lastname , ismale: ismale , phonenumber: phonenumber,housename: housename,roadname: roadname,city: city,state: state,landmark: landmark,alternatephonenumber: alternatephonenumber,pincode: pincode);
}
