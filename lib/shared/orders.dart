import 'package:flutter/material.dart';
import 'package:shavishank/shared/textformfield.dart';


class OrderTable extends StatelessWidget {
  List CartItems;
  String amount;
  List alternative;
  String date;


  // ignore: non_constant_identifier_names
  OrderTable({this.amount,this.CartItems, this.alternative, this.date});
  @override
  Widget build(BuildContext context) {

    if(CartItems!=null){
      return Table(
        border: TableBorder.all(
            color: Colors.black.withAlpha(10),
            style: BorderStyle.solid,
            width: 1),
        columnWidths: {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: [
          TableRow(
              children: ["Product name", "quantity" ,"price"].map((input) => TextOverFlow(input)).toList()
          ),
          ...CartItems.map((e) =>TableRow(
              children: [e.name, e.quantity, e.myprice].map((input) => TextOverFlow(input)).toList()
          ),),
          TableRow(
              children: ["Total ", " " , amount].map((input) => TextOverFlow(input)).toList()
          ),
        ],
      );
    }


    int i =-1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("Order ID     "),
            Text(alternative[4])
          ],
        ),
        SizedBox(height: 10,),
        Table(
          border: TableBorder.all(
              color: Colors.black.withAlpha(10),
              style: BorderStyle.solid,
              width: 1),
          columnWidths: {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
                children: ["Product name", "quantity" ,"price"].map((input) => TextOverFlow(input)).toList()
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
        ),

      ],
    );
  }
}