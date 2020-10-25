import 'package:flutter/material.dart';


class SearchMed extends StatelessWidget {
  Function _goback;
  SearchMed(this._goback);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          icon: Icon(Icons.keyboard_backspace),
          onPressed: _goback,
        ),
        elevation: 0.0,
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}




class Datasearch extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}