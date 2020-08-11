import 'package:flutter/cupertino.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';

import 'cardStack.dart';

CustomScrollView pastCards(ArrayOfCards a, BuildContext context,int filter, String current){
  return
    CustomScrollView(
      slivers: <Widget>[

        SliverFixedExtentList(
          delegate: SliverChildListDelegate(
              [
                Stack(

                  children: stackOfCards(a, context, "pass",filter,current),
                )]
                  //if size not empty, increase to add extra space for balance
          ), itemExtent:  (a.checkSize()+1)*140.00
   //     a.checkSize()*150.0,
        )
      ],
    );
}
