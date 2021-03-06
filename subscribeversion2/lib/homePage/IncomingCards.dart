import 'package:flutter/cupertino.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';

import 'cardStack.dart';

CustomScrollView IncomingCards(ArrayOfCards a, BuildContext context,int filter, String current){
  return
    CustomScrollView(
      slivers: <Widget>[

        SliverFixedExtentList(
          delegate: SliverChildListDelegate(
              [
                Stack(

                  children: stackOfCards(a, context, "incoming", filter,current),
                )]
          ), itemExtent:   (a.checkSize()+1)*140.00
        )
      ],
    );
}