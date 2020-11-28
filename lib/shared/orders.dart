import 'package:flutter/material.dart';
import 'package:shavishank/shared/textformfield.dart';


class OrderTable extends StatelessWidget {
  List CartItems;
  String amount;
  List alternative;

  OrderTable({this.amount,this.CartItems, this.alternative});
  @override
  Widget build(BuildContext context) {

    if(CartItems!=null){
      return Table(
        border: TableBorder.all(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 2),
        columnWidths: {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: [
          TableRow(
              children: ["product name", "quantity" ,"price"].map((input) => TextOverFlow(input)).toList()
          ),
          ...CartItems.map((e) =>TableRow(
              children: [e.name, e.quantity, e.price].map((input) => TextOverFlow(input)).toList()
          ),),
          TableRow(
              children: ["Total ", " " , amount].map((input) => TextOverFlow(input)).toList()
          ),
        ],
      );
    }


    int i =-1;
    return Table(
      border: TableBorder.all(
          color: Colors.black,
          style: BorderStyle.solid,
          width: 2),
      columnWidths: {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        TableRow(
            children: ["product name", "quantity" ,"price"].map((input) => TextOverFlow(input)).toList()
        ),
        ...alternative[0].map((element) {
          i++;
          return TableRow(
            children: [element, (alternative[1] as List)[i], (alternative[2] as List)[i]].map((input) => TextOverFlow(input)).toList()
        );
        },),
        TableRow(
            children: ["Total ", " " , alternative[3]].map((input) => TextOverFlow(input)).toList()
        ),
      ],
    );
  }
}