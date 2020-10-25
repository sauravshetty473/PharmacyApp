import 'package:flutter/material.dart';

class LoginSlides{
  String imageURL;
  String title;
  String description;
  LoginSlides(this.imageURL , this.title , this.description);
}


final LoginSlidesList=[
  LoginSlides(
    "assets/images/medicinefinal.png",
    "OTC & Wellness Product",
    "Find our most Popular, Seasonal and Top Selling medical products."
  ),
  LoginSlides(
      "assets/images/prescriptionfinal.png",
      "Upload Prescription",
      "Have a problem with searching medicines?\nProvide your medicine prescription and relax\nWe will get you medical products at home"
  ),
  LoginSlides(
      "assets/images/chatsimple.png",
      "Chat with Us",
      "Feel free to chat with us if you are unsure about any medicine."
  ),
  LoginSlides(
      "assets/images/discountfinal.png",
      "Offers",
      "Get discount offers on medical products."
  ),
  LoginSlides(
      "assets/images/homedeliveryfinal.png",
      "Home delivery",
      "Just order your medicines and we will take care of the delivery."
  ),
];


class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height/5,
              width: MediaQuery.of(context).size.height/5,
              child: Image(
                image: AssetImage(LoginSlidesList[index].imageURL),
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height/4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LoginSlidesList[index].title , style: TextStyle(fontSize: 20),),
                SizedBox(height: 10,),
                Text(LoginSlidesList[index].description),
              ],
            ),
          ),
        )
      ],
    );
  }
}

    
    