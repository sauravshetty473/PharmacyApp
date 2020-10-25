import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{


//collection reference .... firebase google collections
 final CollectionReference medCollection = Firestore.instance.collection("medicines") ;  // creates collection if there were no before // here medCollection is the reference to to collection medicines in chrome



}