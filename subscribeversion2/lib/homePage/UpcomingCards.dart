import 'package:flutter/cupertino.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';

import 'cardStack.dart';

CustomScrollView UpcomingCards(ArrayOfCards a, BuildContext context,int filter, String current){
  return
    CustomScrollView(
      slivers: <Widget>[

        SliverFixedExtentList(
          delegate: SliverChildListDelegate(
              [
                Stack(
///add upcoming to database
                  children: stackOfCards(a, context, "upcoming",filter,current),
                )]
          ), itemExtent:   (a.checkSize()+1)*140.00
        )
      ],
    );
}
