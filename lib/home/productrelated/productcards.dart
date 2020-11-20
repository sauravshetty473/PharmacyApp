

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/home/productrelated/productpage.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';



class MainProductCard extends StatelessWidget {
  Product product;
  MainProductCard(this.product);












  @override
  Widget build(BuildContext context) {




    double height = MediaQuery.of(context).size.height/4.5;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,0,8,8),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),

          width: height*2/3,
          height: height ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Expanded(
                child: Image(
                  image: NetworkImage(product.imageUrl),
                ),
              ),

              FlatButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProductPage(product),
                  ));
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  height: height/2.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: 5,
                      ),


                      Container(

                          child :Text(
                            product.name,
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            softWrap: false,
                          )),
                      SizedBox(height: 5,),

                      Row(
                        children: [
                          Text("\u20B9"+product.myprice.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500
                            ),
                          ),

                          SizedBox(
                            width: 5,
                          ),
                          Text("\u20B9"+product.price.toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 3,),

                      Text("\u20B9"+(product.price-product.myprice).toString(),
                        style: TextStyle(
                            color: Colors.green,
                        ),
                      ),
                    ],
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



class MainProductLoading extends StatefulWidget {
  @override
  _MainProductLoadingState createState() => _MainProductLoadingState();
}

class _MainProductLoadingState extends State<MainProductLoading> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> anim1;
  Animation<Color> anim2;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this);

    anim1 = ColorTween(begin: Colors.grey , end: Colors.grey[100]).animate(_controller);
    anim2 = ColorTween(begin: Colors.grey[100] , end: Colors.grey).animate(_controller);

    _controller.forward();
    _controller.addListener(() {
      if(_controller.status ==AnimationStatus.completed ){

        _controller.reverse();

      }else if(_controller.status == AnimationStatus.dismissed){
        _controller.forward();
      }
      this.setState(() {                          //after each listening events setstate// inshort whenever controller changes value the addlistener function is executed
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height/4.5;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,0,8,8),
      child: Card(
        child: ShaderMask(
          shaderCallback: (rect){
            return LinearGradient(colors:   [anim2.value , anim1.value]).createShader(rect);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            width: height*2/3,
            height: height ,
          ),
        )));
  }
}




class ProductSearchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
