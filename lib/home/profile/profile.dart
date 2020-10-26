import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shavishank/home/profile/address.dart';
import 'package:shavishank/home/profile/namephone.dart';



class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool _ismale;

  Widget Gender({bool male, String imageURL}){
    return FlatButton(
      padding: EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width/10,
            backgroundColor: _ismale!=null&&_ismale==male?Colors.grey[800]:Colors.transparent,
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
                onPressed: (){
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
  Widget build(BuildContext context) {

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
                  Row(
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
                  ),


                  FlatButton(
                    child: Text("Enter Full Name" ,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color:Colors.white.withAlpha(100),
                        textBaseline: TextBaseline.ideographic),),

                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NamePhone(),
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
                  Text("9004327955",
                    style: TextStyle(fontSize: 10,color: Colors.white),
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
                  ProfileCards(title: "My Reviews", butName: "VIEW YOUR REVIEWS", subtitle: ""),
                  ProfileCards(title: "My Addresses", butName: "VIEW MORE" , subtitle: "C-20, NavTrilok CHS ,Kalyan ,Maharashtra, 421201",widget: AddressPage()),
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


