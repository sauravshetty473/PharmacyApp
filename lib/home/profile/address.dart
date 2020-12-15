import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/textformfield.dart';

typedef void StringCallback(String id);


class AddressPage extends StatefulWidget {
  NamePage addressPage;
  Function setprevious;
  AddressPage({this.addressPage,this.setprevious});

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _formkey = GlobalKey<FormState>();                // to validate

  void savedata() async{
    String NPY ="";

    final user =  Provider.of<CustomUser>(context,listen: false);
    await DatabaseService().Userdata.doc(user.uid).update({
      "Firstname" : widget.addressPage.firstname??NPY,
      "Lastname"  : widget.addressPage.lastname??NPY,
      "Phone"     :widget.addressPage.phonenumber??NPY,

      "Gender"    :NPY,
      "Housename" :widget.addressPage.housename??NPY,
      "Roadname"  :widget.addressPage.roadname??NPY,
      "City"      :widget.addressPage.city??NPY,
      "State"     :widget.addressPage.state??NPY,
      "Landmark"  :widget.addressPage.landmark??NPY,
      "AltPhone"  :widget.addressPage.alternatephonenumber??NPY,
      "Pincode"   :widget.addressPage.pincode??NPY,
    });
    if(widget.addressPage.ismale!=null){
      DatabaseService().Userdata.doc(user.uid).update({
        "Gender" : widget.addressPage.ismale?"male":"female",
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formkey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor:  Color.fromARGB(255,78,100,123),
          title: Text("Manage your Address"),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    FlipkartTextField(
                      onSonChanged: (String newId) {
                        setState(() {
                          this.widget.addressPage.pincode = newId??widget.addressPage.pincode;
                        });
                      },
                      initialvalue: widget.addressPage.pincode==""?null:widget.addressPage.pincode,
                      hintext: "Pincode *",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                      number: true,
                      validator: (String val){
                        if(val.isEmpty||val.length<6){
                          return "Enter your pincode";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    FlipkartTextField(
                      onSonChanged: (String newId) {
                        setState(() {
                          this.widget.addressPage.housename = newId??widget.addressPage.housename;
                        });
                      },
                      initialvalue: widget.addressPage.housename==""?null:widget.addressPage.housename,
                      hintext: "House No. Building name *",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                      validator: (String val){
                        if(val.isEmpty){
                          return "Enter Address line 1";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    FlipkartTextField(
                      onSonChanged: (String newId) {
                        setState(() {
                          this.widget.addressPage.roadname = newId??widget.addressPage.roadname;
                        });
                      },
                      initialvalue: widget.addressPage.roadname==""?null:widget.addressPage.roadname,
                      hintext: "Road Name, Area, Colony *",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                      validator: (String val){
                        if(val.isEmpty){
                          return "Enter Address line 2";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Flexible(

                          child: FlipkartTextField(
                            onSonChanged: (String newId) {
                              setState(() {
                                this.widget.addressPage.city = newId??widget.addressPage.city;
                              });
                            },
                            initialvalue: widget.addressPage.city==""?null:widget.addressPage.city,
                            hintext: "City *",
                            duration: 200,
                            shrinkpad: 10,
                            expandpad: 25,
                            shrinksize: 10,
                            expandsize: 15,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Flexible(
                          child: FlipkartTextField(
                            onSonChanged: (String newId) {
                              setState(() {
                                this.widget.addressPage.state = newId??widget.addressPage.state;
                              });
                            },
                            initialvalue: widget.addressPage.state==""?null:widget.addressPage.state,
                            hintext: "State *",
                            duration: 200,
                            shrinkpad: 10,
                            expandpad: 25,
                            shrinksize: 10,
                            expandsize: 15,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    FlipkartTextField(
                      onSonChanged: (String newId) {
                        setState(() {
                          this.widget.addressPage.landmark = newId??widget.addressPage.landmark;
                        });
                      },
                      initialvalue: widget.addressPage.landmark==""?null:widget.addressPage.landmark,
                      hintext: "LandMark (Optional)",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                    ),
                    SizedBox(height: 10,),


                    FlipkartTextField(
                      onSonChanged: (String newId) {
                        setState(() {
                          this.widget.addressPage.phonenumber = newId??widget.addressPage.phonenumber;
                        });
                      },
                      initialvalue: widget.addressPage.phonenumber==""?null:widget.addressPage.phonenumber,
                      hintext: "Phone number *",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                      number: true,
                      validator: (String val){
                        if(val.isEmpty){
                          return "Enter your phone number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10,),

                    FlipkartTextField(
                      onSonChanged: (String newId) {
                        setState(() {
                          this.widget.addressPage.alternatephonenumber = newId??widget.addressPage.alternatephonenumber;
                        });
                      },
                      initialvalue: widget.addressPage.alternatephonenumber==""?null:widget.addressPage.alternatephonenumber,
                      hintext: "Alternate Phone number (Optional)",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                      number: true,
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: FlatButton(
                    height: 50,
                    color: Colors.amberAccent,
                    child: Text("Save", style: TextStyle(fontSize: 20),),
                    onPressed: () async{
                       if(_formkey.currentState.validate()){
                         await savedata();
                         widget.setprevious(widget.addressPage);
                         Navigator.pop(context);
                       }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
