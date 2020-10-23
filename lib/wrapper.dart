import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shavishank/models/user.dart';
import 'home/home.dart';
import 'login/authenticate.dart';




class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    print(user);
    return user==null?Authenticate():Home();
  }
}
