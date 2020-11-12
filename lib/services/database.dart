import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{


//collection reference .... firebase google collections
 final CollectionReference medCollection = FirebaseFirestore.instance.collection("medicines") ;  // creates collection if there were no before // here medCollection is the reference to to collection medicines in chrome
 final CollectionReference topSelling = FirebaseFirestore.instance.collection("topSelling") ;
 final CollectionReference seasonal = FirebaseFirestore.instance.collection("seasonal") ;
 final CollectionReference todaysHot = FirebaseFirestore.instance.collection("todaysHot") ;

 Stream<QuerySnapshot> get nothing{
  return medCollection.snapshots();
 }

}




class Product{                       //this is my own class // i will store the document id too in it too open the product detail page
 String name;
 String description;
 String imageUrl;
 String subinfo;
 int price;
 int myprice;
 int quantity;
 String id;
 QueryDocumentSnapshot e;

 Product(this.e){
  name = e.get("name");
  description = e.get("description");
  imageUrl = e.get("imageurl");
  subinfo = e.get("subinfo");
  price =int.parse(e.get("price"));
  myprice =int.parse(e.get("myprice"));
  quantity =int.parse(e.get("quantity"));
  id = e.id;
 }
}
