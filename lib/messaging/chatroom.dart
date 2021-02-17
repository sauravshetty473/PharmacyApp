

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



import 'package:shavishank/messaging/tiles.dart';
import 'package:shavishank/models/user.dart';
import 'package:shavishank/services/database.dart';


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[700],
      child: Center(
        child: SpinKitRing(
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}



class ChatRoomCover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool admin = true;
    final user =  Provider.of<CustomUser>(context,listen: false);
    if(user.emailid == "saurav.vs@somaiya.edu"){
      admin = true;
    }

    if(!admin){
      return ChatRoom(uID: user.uid, what: admin);
    }



    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(255,78,100,123),
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(child : Text("Active Chats")),
              Tab(child : Text("Requested Chats")),
            ],
          ),
          title: Text("Resolution Center"),
        ),
        body: TabBarView(
          children: [

            StreamBuilder(
              stream: DatabaseService().Active.snapshots(),

              builder: (context, snapshot){

                if(snapshot.data==null){
                  return Loading();
                }
                QuerySnapshot snapshots = snapshot.data;

                return ListView(
                   children: [
                     ...snapshots.docs.map((e) => ListTile(
                       title: Text(e.id),
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(
                             builder: (context) => ChatRoom( what:  admin, uID: e.id,)));
                       },
                     ),)
                   ],
                );
              },
            ),



            StreamBuilder(
              stream: DatabaseService().Requested.snapshots(),

              builder: (context, snapshot){

                if(snapshot.data==null){
                  return Loading();
                }
                QuerySnapshot snapshots = snapshot.data;

                return ListView(
                  children: [
                    ...snapshots.docs.map((e) =>

                    FocusedMenuHolder(child:
                    ListTile(
                      title: Text(e.id),
                    ),

                        animateMenuItems: false,

                        menuItems: <FocusedMenuItem>[
                          FocusedMenuItem(title: Text("Accept request"),
                              trailingIcon: Icon(Icons.check_box , color: Colors.black,),
                              onPressed: () async{
                                await DatabaseService().Active.doc(e.id).set({
                                  "id": e.id,
                                }
                                );
                                await DatabaseService().Requested.doc(e.id).delete();
                              }),

                          FocusedMenuItem(title: Text("Deny request"),
                              trailingIcon: Icon(Icons.delete_forever_outlined , color: Colors.red,),
                              onPressed: () async{
                                await DatabaseService().Requested.doc(e.id).delete();
                              }),

                        ]
                    )
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



class ChatRoom extends StatefulWidget {
  String uID;
  bool what;
  ChatRoom({this.uID, this.what});
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    bool admin = widget.what;


    return FutureBuilder(
      future: Future.wait([doesExistInActive(widget.uID), doesExistInRequested(widget.uID)]),

      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
        if(snapshot.data== null){
          return Loading();
        }


        if(!snapshot.data[0]&&!snapshot.data[1]){
          return Scaffold(
            appBar: AppBar(title: Text("Request for resolution"),
            elevation: 0,
            ),

            body: Center(
              child: FlatButton(
                color: Colors.blue,
                child: Text("Request",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),

                ),
                onPressed: () async{
                  await DatabaseService().Requested.doc(widget.uID).set({
                    "id" : widget.uID,
                  });
                  setState(() {

                  });
                },
              ),
            ),
          );
        }

        if(snapshot.data[1]){

          return Scaffold(
            appBar: AppBar(title: Text("Your request in under review"),
            elevation: 0,
            ),

            body: Center(
              child: FlatButton(
                color: Colors.blue,
                child: Text("Withdraw Request",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
                onPressed: () async{
                  await DatabaseService().Requested.doc(widget.uID).delete();
                  setState(() {

                  });
                },
              ),
            ),

          );
        }

        return Scaffold(
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          appBar: AppBar(
            title: Text(!admin?"Customer Care": "User"),
            elevation: 0,

            actions: [
              admin?FlatButton(
                child: Text("Close Discussion",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async{
                  await DatabaseService().Active.doc(widget.uID).delete();
                  Navigator.pop(context);
                },
              ):SizedBox()
            ],
          ),

          body: Column(

            children: [
              Expanded(
                  child: StreamBuilder(

                    builder: (context,  snapshot){
                      if(snapshot.data == null){
                        return Loading();
                      }

                      QuerySnapshot snapshots = snapshot.data;


                      return ListView(
                          children: [
                            ...sortOutput(snapshots, admin),
                          ]
                      );
                    },

                    stream: DatabaseService().Chats.doc(widget.uID).collection("Messages").snapshots(),
                  )
              ),
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      child: TextFormField(
                        controller: _controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    ),
                    Expanded(child: FlatButton.icon(
                        onPressed: () async{
                          if(_controller.text!=""){
                            await sendMessage(widget.uID, admin, _controller.text);
                            _controller.text = "";
                            print("done");
                          }
                        },
                        icon: Icon(Icons.send), label: Text("")),

                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}





Future doesExistInRequested(String id) async{
  final snapShot = await DatabaseService().Requested.doc(id).get();

  if (snapShot.exists){
    return true;
  }
  else{
    return false;
  }
}

Future doesExistInActive(String id) async{
  final snapShot = await DatabaseService().Active.doc(id).get();

  if (snapShot.exists){
    return true;
  }
  else{
    return false;
  }
}




void sendMessage(String uID, bool admin, String content) async{

  final nowBig = new DateTime.now();
  String formattedDate = DateFormat('yMd').format(nowBig);               // 28/03/2020
  String formattedTime = DateFormat('Hms').format(nowBig);               // 16:05:08


  await DatabaseService().Chats.doc(uID).collection("Messages").add({
    "content" : content,
    "mine"    : admin?"false":"true",
    "date"    : formattedDate,
    "time"    : formattedTime,
    "status"  : "1",
    "actualTime" : DateTime.now().millisecondsSinceEpoch,
  });

}


List<Widget> sortOutput(QuerySnapshot e,bool admin){
  e.docs.forEach((element) {
    if(!(    (admin||element.get("mine")=="true") &&  ( !admin ||  !(element.get("mine")=="true"))           )){
      element.reference.update({
        "status" : "3"
      });
    }
  });

  List<Widget> output = new List();
  String initialDate = "00/00/0000";

  List mid = e.docs;

  for(int i = 0 ; i<mid.length; i++){           //sorting by time
    for(int j=0; j<mid.length-1; j++){
      if(mid[j].get("actualTime")>mid[j+1].get("actualTime")){
        var temp = mid[j];
        mid[j] = mid[j+1];
        mid[j+1] = temp;
      }
    }
  }

  for(int i = 0 ; i<mid.length;i++){
    if(isGreater(mid[i].get("date"), initialDate)){                             //if new message is more recent
      initialDate = mid[i].get("date");
      final nowBig = new DateTime.now();
      if(initialDate == DateFormat('yMd').format(new DateTime.now()))
        {
          output.add(DateTile(date: "Today"));
        }
      else{
        output.add(DateTile(date: initialDate));
      }

    }
    output.add(ChatTile(admin: admin, status: mid[i].get("status"), date: mid[i].get("date"), time: mid[i].get("time"), content: mid[i].get("content"), mine: admin?!(mid[i].get("mine")=="true"): (mid[i].get("mine")=="true")));
  }
  return output;
}


bool isGreater(String b, String a){              //is String b greater than String a
  int yb,ya,mb,ma,db,da;

  List midB = b.split("/");
  List midA = a.split("/");



  if(int.parse(midB[2])>int.parse(midA[2]))
    return true;


  if(int.parse(midB[2])<int.parse(midA[2]))
    return false;


  if(int.parse(midB[0])>int.parse(midA[0]))
    return true;


  if(int.parse(midB[0])<int.parse(midA[0]))
    return false;

  if(int.parse(midB[1])>int.parse(midA[1]))
    return true;


  if(int.parse(midB[1])<int.parse(midB[1]))
    return false;

  return false;
}

