import 'package:flutter/cupertino.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';

import 'cardStack.dart';

CustomScrollView IncomingCards(ArrayOfCards a, BuildContext context){
  return
    CustomScrollView(
      slivers: <Widget>[

        SliverFixedExtentList(
          delegate: SliverChildListDelegate(
              [
                Stack(

                  children: stackOfCards(a, context, "incoming"),
                )]
          ), itemExtent:   (a.checkSize())*140.00
        )
      ],
    );
}