import 'package:flutter/cupertino.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';

import 'cardStack.dart';

CustomScrollView UpcomingCards(ArrayOfCards a, BuildContext context){
  return
    CustomScrollView(
      slivers: <Widget>[

        SliverFixedExtentList(
          delegate: SliverChildListDelegate(
              [
                Stack(
///add upcoming to database
                  children: stackOfCards(a, context, "upcoming"),
                )]
          ), itemExtent:   (a.checkSize())*140.00
        )
      ],
    );
}
