import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/loadingscreen.dart';
import 'package:shavishank/shared/textformfield.dart';

typedef void StringCallback(String id);

class NamePhone extends StatefulWidget {
  NamePage newclass;
  final ValueChanged<NamePage> setprevious;                 //Very important , something new , calling function of parent from child             // callback maybe?
  NamePhone({this.newclass,this.setprevious});

  @override
  _NamePhoneState createState() => _NamePhoneState();
}

class _NamePhoneState extends State<NamePhone> {

  String NPY = "";


  bool _tap=false;
  bool _ismale;
  String firstname;
  String lastname;
  String phonenumber;
  String emailaddress;

  String getmale;
  String getfname;
  String getlname;
  String getnumber;





  Widget Gender({bool male, String imageURL}){
    return FlatButton(
      padding: EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width/10,
            backgroundColor: _ismale!=null&&_ismale==male?Colors.black.withAlpha(100):Colors.transparent,
          ),
          CircleAvatar(
            radius: MediaQuery.of(context).size.width/12,
            child: Image(
              image: AssetImage(imageURL),
            ),
          ),
        ],
      ),
      onPressed: (){
        setState(() {
          if (male) {
            _ismale = true;
            //firebase.set
          } else {
            _ismale = false;
          }
        });
      },
    );
  }

  @override
  void initState() {
    _ismale = widget.newclass.ismale;
    firstname = widget.newclass.firstname;
    lastname = widget.newclass.lastname;
    phonenumber = widget.newclass.phonenumber;

    super.initState();
  }

  void savedata() async{

    //await getdata();
    final user =  Provider.of<CustomUser>(context,listen: false);
    await DatabaseService().Userdata.doc(user.uid).update({
      "Firstname" : firstname??NPY,
      "Lastname"  : lastname??NPY,
      "Phone"     :phonenumber??NPY,
      "EmailId"   : user.emailid??NPY,
      "Gender"    :NPY,
    });
    if(_ismale!=null){
      print(_ismale);
      DatabaseService().Userdata.doc(user.uid).update({
        "Gender" : _ismale?"male":"female",
      });
    }
  }


  void getdata() async{
    final user =  Provider.of<CustomUser>(context,listen: false);
      await DatabaseService().Userdata.doc(user.uid).get().then((value){                //returns map
      try{

        firstname = firstname??value["Firstname"];
        lastname = lastname?? value["Lastname"];
        phonenumber =phonenumber?? value["Phone"];
        getmale  =getmale?? value["Gender"];
        if(!(getmale==NPY)){
          _ismale = getmale=="male"?true:false;
        }
      }
      catch(e){               //if the keys are not present the nmake my own
        print("problematic");
          DatabaseService().Userdata.doc(user.uid).update({
          "Firstname" :"",
          "Lastname"  :"",
          "Phone"     :"",
          "Gender"    :"",
        });}
      });
  }




  @override
  Widget build(BuildContext context) {









    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255,78,100,123),
        elevation: 0,
      ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(color:  Color.fromARGB(255,78,100,123),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Gender(male: true,imageURL:"assets/images/male.png"),
                          Gender(male: false,imageURL:"assets/images/female.png"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                      FlipkartTextField(
                        onSonChanged: (String newId) {
                          setState(() {
                            this.firstname = newId??this.firstname;
                            widget.newclass.firstname = this.firstname;

                          });
                         },
                      hintext: "First Name",
                        initialvalue: firstname==""?null:firstname,
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
                         this.lastname = newId??this.lastname;
                         widget.newclass.lastname = this.lastname;

                       });
                      },
                      hintext: "Last Name",
                      initialvalue: lastname==""?null:lastname,
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
                          this.phonenumber = newId??this.phonenumber;
                          widget.newclass.phonenumber = this.phonenumber;

                        });
                      },
                      initialvalue: phonenumber==""?null:phonenumber,
                      hintext: "Phone Number",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                      number: true,
                    ),
                    SizedBox(height: 20,),

                    FlatButton(
                      child: Text("SUBMIT",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue
                        ),
                      ),
                      onPressed: () async{
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Loading()));
                        await savedata();
                        widget.newclass.ismale = this._ismale;
                        Navigator.pop(context);
                        widget.setprevious(widget.newclass);
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "Profile updated successfully");
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
