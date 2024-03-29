import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/login/loginstartpage.dart';
import 'package:shavishank/messaging/chatroom.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';
import 'home/home.dart';
import 'login/authenticate.dart';




class Wrapper extends StatelessWidget  {
  @override
  Widget build(BuildContext context){

    final user = Provider.of<CustomUser>(context);                              //Provider in the child can get values from its parent


    if(user!=null&&user.isperson){
      DatabaseService().Userdata.doc(user.uid).update({
        "id": user.uid.toString(),
      });
    }

    return user==null?LoginInfoSlideView():Home();                              //at start either Exposition or the Home page //not Authenticate directly
    //return user==null?LoginInfoSlideView():ChatRoomCover();
  }
}
