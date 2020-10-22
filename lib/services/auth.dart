import 'package:firebase_auth/firebase_auth.dart';
import 'package:shavishank/models/user.dart';

class AuthService{

  final FirebaseAuth _auth= FirebaseAuth.instance;             //creating an object


  CustomUser _cuserfromUser(User user)                         //create custom user object out of Firebase User
  {
    return user!=null?CustomUser(user.uid) : null;
  }

  //auth change user stream
  Stream<CustomUser> get user{                                  //<> Tell us about the type of data we receive  (getter)
    return _auth.authStateChanges()                             //returning this stream whenever there is change is authentication
    //.map((User user)=>_cuserfromUser(user));                  //returning Custom made user by mapping the input (User) whenever there is an authStateChange
    .map(_cuserfromUser);                                       //works the same as above, i guess since it is a simple function with only one input(User) and one Output(CustomUser)
  }


  Future signInAnon() async{                                         //sign in anonymous
  try{
    UserCredential result =await _auth.signInAnonymously();          //should be enabled in the firebase project    //AuthResult changed to UserCredential
    User user= result.user;                                          //FirebaseUser to User (object className changed)   //results attribute is user which is another object
    return _cuserfromUser(user);                                     //returning custom user without all the unwanted things
  }
  catch(e){
    print(e.toString());
    return null;
  }



}
//sign in with email and password
//register
//sign out





}