import 'package:flutter/material.dart';
import 'package:shavishank/home/productrelated/productpage.dart';
import 'package:shavishank/services/database.dart';
import 'package:shavishank/shared/loadingscreen.dart';


class SearchMed extends StatefulWidget {
  @override
  _SearchMedState createState() => _SearchMedState();
}

class _SearchMedState extends State<SearchMed> {
  String value = "";

  void onSearch(String val){
    setState(() {
      value = val;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for medicines"),
        elevation: 0.0,
        backgroundColor:  Color.fromARGB(255, 21, 35, 55),
      ),



      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(5,5,5,5),
            width: double.infinity,
            height: MediaQuery.of(context).size.height/15,
            color: Color.fromARGB(255, 21, 35, 55),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: TextFormField(
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: 'Search',
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: FutureBuilder(
                builder: (BuildContext context, snapshot){
                  if(snapshot.data==null){
                    return SizedBox();
                  }
                  List<List<String>> result = snapshot.data;
                  return Column(
                    children: result.map((e) {
                      if(e[0]!=""){
                        return SearchResultCards(name: e[0],imageURL: e[2], id: e[1],);
                      }
                      else{
                        return SizedBox();
                      }
                    }).toList(),
                  );
                },
                future: getResults(value),
              ),
            ),
          )
        ],
      ),
    );
  }
}


Future getResults(String input) async{
  input = input.trim();

  if(input!=""){
    List<List<String>> temp = new List();
    List<List<String>> retList = new List();
    await DatabaseService().medCollection.get().then((value) => value.docs.forEach((element) {
      try{
        temp.add([element.get("name"),element.id ,element.get("imageurl")]);
      }
      catch(e){
        print("an error occurred");
      }
    }));
    int count=0;
    for(int i = 0 ; i<temp.length ; i++){
      if(count==10){
        break;
      }
      if(temp[i].toString().toLowerCase().contains(input.toLowerCase())){
        retList.add(temp[i]);
      }
    }
    return retList;
  }
  return [[""]];
}



class SearchResultCards extends StatelessWidget {
  String name;
  String imageURL;
  String id;
  SearchResultCards({this.name, this.imageURL , this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductPage(id: id,),
        ));

      },
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
            height: MediaQuery.of(context).size.height/10,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/5,
                  child: Image(image:  NetworkImage(imageURL),),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Text(name,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(height: 0, thickness: 1,)
        ],
      ),
    );
  }
}





