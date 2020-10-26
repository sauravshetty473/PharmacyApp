import 'package:flutter/material.dart';
import 'package:shavishank/shared/textformfield.dart';



class NamePhone extends StatefulWidget {
  @override
  _NamePhoneState createState() => _NamePhoneState();
}

class _NamePhoneState extends State<NamePhone> {

  bool _tap=false;
  bool _ismale;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [

          IconButton(
            iconSize: 25,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            padding: EdgeInsets.all(0),
            icon: Icon(Icons.notifications),
            onPressed: (){

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
                      hintext: "First name",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                    ),
                    SizedBox(height: 10,),

                    FlipkartTextField(
                      hintext: "Last Name",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                    ),
                    SizedBox(height: 20,),

                    FlatButton(
                      child: Text("SUBMIT",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue
                      ),
                      ),
                      onPressed: (){


                      },
                    ),
                    SizedBox(height: 10,),

                    FlipkartTextField(
                      hintext: "Phone Number",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
                      number: true,
                    ),

                    SizedBox(height: 10,),

                    FlipkartTextField(
                      hintext: "Email id",
                      duration: 200,
                      shrinkpad: 10,
                      expandpad: 25,
                      shrinksize: 10,
                      expandsize: 15,
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
