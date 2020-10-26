import 'package:flutter/material.dart';
import 'package:shavishank/shared/textformfield.dart';



class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    hintext: "Pincode *",
                    duration: 200,
                    shrinkpad: 10,
                    expandpad: 25,
                    shrinksize: 10,
                    expandsize: 15,
                    number: true,
                  ),
                  SizedBox(height: 10,),
                  FlipkartTextField(
                    hintext: "House No. Building name *",
                    duration: 200,
                    shrinkpad: 10,
                    expandpad: 25,
                    shrinksize: 10,
                    expandsize: 15,
                  ),
                  SizedBox(height: 10,),
                  FlipkartTextField(
                    hintext: "Road Name, Area, Colony *",
                    duration: 200,
                    shrinkpad: 10,
                    expandpad: 25,
                    shrinksize: 10,
                    expandsize: 15,
                  ),
                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Flexible(

                        child: FlipkartTextField(
                          hintext: "City",
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
                          hintext: "State",
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
                    hintext: "LandMark (Optional)",
                    duration: 200,
                    shrinkpad: 10,
                    expandpad: 25,
                    shrinksize: 10,
                    expandsize: 15,
                  ),
                  SizedBox(height: 10,),

                  FlipkartTextField(
                    hintext: "LandMark (Optional)",
                    duration: 200,
                    shrinkpad: 10,
                    expandpad: 25,
                    shrinksize: 10,
                    expandsize: 15,
                  ),
                  SizedBox(height: 10,),

                  FlipkartTextField(
                    hintext: "Name *",
                    duration: 200,
                    shrinkpad: 10,
                    expandpad: 25,
                    shrinksize: 10,
                    expandsize: 15,
                  ),
                  SizedBox(height: 10,),

                  FlipkartTextField(
                    hintext: "Phone number *",
                    duration: 200,
                    shrinkpad: 10,
                    expandpad: 25,
                    shrinksize: 10,
                    expandsize: 15,
                    number: true,
                  ),
                  SizedBox(height: 10,),

                  FlipkartTextField(
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FlatButton(
                  color: Colors.orange,
                  child: Text("Save"),
                  onPressed: (){


                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
