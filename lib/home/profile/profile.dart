import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/profile/address.dart';
import 'package:shavishank/home/profile/namephone.dart';
import 'package:shavishank/models/fillingclasses.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';



class ProfilePage extends StatefulWidget {
  NamePage newpage;
  Function setpre;
  ProfilePage({this.newpage,this.setpre});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 String name;
 String phonenumber;

  void setsta(NamePage namepage){
    this.setState(() {
      widget.newpage = namepage;
      widget.setpre(namepage);
    });
  }
  bool _ismale;


 Widget rowModifier(bool ismale){
   return ismale==null?Row(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,

     children: [
       Gender(male: true,imageURL:"assets/images/male.png"),
       Container(
         child: Center(
             child: Text("or",
               style: TextStyle(color: Colors.white),

             )),
       ),
       Gender(male: false,imageURL:"assets/images/female.png"),
     ],
   ):Row(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,

     children: [
       ismale==true?Gender(male: true,imageURL:"assets/images/male.png"):Gender(male: false,imageURL:"assets/images/female.png"),
     ],
   );
 }



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

  Widget ProfileCards({String title , String subtitle ,String butName , Widget widget}){
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5,10,5,5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Divider(
              height:20,
              thickness: 1,
              color: Colors.black.withAlpha(20),
            ),
            Text(subtitle,
            style: TextStyle(
              color: Colors.black.withAlpha(100),
              fontSize: 10
            ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(butName),
                onPressed: () {
                  if(widget!=null)
                    {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => widget,
                      ));
                    }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    this.name = widget.newpage.firstname + " " +widget.newpage.lastname;
    this.phonenumber = widget.newpage.phonenumber;
    this._ismale = widget.newpage.ismale;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

   _ismale = widget.newpage.ismale;



    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(title: Text("My Account"),
        elevation: 0.0,

        actions: [

          IconButton(
            iconSize: 25,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.notifications),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => NamePhone(),
              ));
            },
          ),
          IconButton(
            iconSize: 25,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(color: Colors.blue,
              child: Column(
                children: [
                  rowModifier(_ismale),

                  FlatButton(
                    child: Text(widget.newpage.firstname==""?"Enter your Name":widget.newpage.firstname + " " + widget.newpage.lastname ,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color:Colors.white.withAlpha(100),
                        textBaseline: TextBaseline.ideographic),),

                    onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NamePhone(newclass: widget.newpage,setprevious:setsta),
                      ));
                    },
                  ),
                  Divider(
                    indent: 50,
                    endIndent: 50,
                    height:0,
                    thickness: 1,
                    color: Colors.white.withAlpha(100),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.newpage.phonenumber??"phonenumber",
                      style: TextStyle(fontSize: 10,color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileCards(title: "My Orders", butName: "VIEW ALL ORDERS" , subtitle: ""),
                 // ProfileCards(title: "My Reviews", butName: "VIEW YOUR REVIEWS", subtitle: ""),
                  ProfileCards(title: "My Addresses", butName: "VIEW MORE" , subtitle:widget.newpage.housename==""?"Add an address": widget.newpage.housename +","+widget.newpage.roadname +","+widget.newpage.city +","+widget.newpage.state +",",widget: AddressPage(addressPage: widget.newpage,setprevious: setsta,)),
                ],
              ),
            ),
            FlatButton.icon(
              color: Colors.white,
              icon: Icon(Icons.exit_to_app),
              label: Text("Logout of this app"),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            )
          ],
        ),
      )
    );
  }
}

