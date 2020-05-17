import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:subscription/CardView/viewCard.dart';
import 'package:subscription/DataStorage/ArrayOfCards.dart';
///
/// creates a stack of cards to display on the home screen
/// 
/*
class cardStack extends StatefulWidget {
  @override

  _cardStackState createState() => _cardStackState();
}

class _cardStackState extends State<cardStack> {
  ArrayOfCards cards = new ArrayOfCards();//make array of cards


  @override
  Widget build(BuildContext context) {
    List<Widget> stacks = [];


        double ttop=10;
        double lleft= 0;
        double rright=0;
       int i =0;

        return SingleChildScrollView(
          child:
          Stack (

          children: <Widget>[
              SizedBox(
                height: 100,
              )
              ,
            Positioned(
                top: ttop,
                left: lleft,
                right: rright,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 10,
                  color: cards.seeCard(i).getColor(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                  child: GestureDetector(
                    onTap: (){
                     /// Navigator.push(context, MaterialPageRoute(builder: (context)=> viewCard(cards.seeCard(i),i)));

                    },
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child:  Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left:20.0),
                                child: Text(cards.seeCard(i).getNameCard(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5,left: 3),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      //color: Colors.red,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(cards.seeCard(i).getNamePayment()),
                                            fit: BoxFit.contain,

                                          )
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 90,
                                      child: Center(
                                        child: Text(
                                          cards.seeCard(i).getMoney(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23,),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right:4.0),
                                      child: Container(
                                        //color: Colors.pinkAccent,
                                        height: 60,
                                        width: 140,

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40),),color: Colors.red,
                                          //boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 1,blurRadius: 2)]
                                        ),
                                        child: Center(child: Text(cards.seeCard(i).getDayCount(),style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),


                                      ),
                                    )


                                  ],
                                ),

                              )
                            ]

                        ),


                      ),
                    ),
                  ),


                )
            )
          ],
        ));





    }


}
*/


List<Widget> cardStack(ArrayOfCards cards, BuildContext context)  {
 //ArrayOfCards cards = new ArrayOfCards();

  ///this checks the days and if it's zero days, string is set today
  String checkDays(int i){
    if (cards.seeCard(i).getDayCount() == "0 DAYS"){
      return "TODAY";

    }

    return cards.seeCard(i).getDayCount();
  }

  ///use if statement check if 0, then show balance

    print("passed here");
    print((cards.checkSize()));
    int check = cards.checkSize();
    List<Widget> stacks = [];
    double ttop=10;
    double lleft= 10;
    double rright=10;


    if (check == 0){
      stacks.add(
        Positioned(
                  top:ttop,
                  left:0,
                  right: 0,
                  child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 10,
                  color:Colors.blueGrey,


                      child: Container(

                         width: double.infinity,
                      // color: Colors.blue,
                          height: 80,
                          child: Row(
                          children: <Widget>[
                               Container(
                              height: 30,
                              width: 70,
                              decoration: BoxDecoration(
                              image: DecorationImage(
                              image: AssetImage("images/price.png"),fit: BoxFit.contain,
                              )


          ),
          ),
                                Container(
                                width: 120,
                                child: Center(child: Text("\$439990",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 23),))
                                )
                                ],
                                ),
                                ),

                                ),
                                ));

  }
  else{

  for (int i=0; i< cards.checkSize(); i++){


    stacks.add(

        Positioned(
            top: ttop,
            left: lleft,
            right: rright,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Transform(
                transform:  Matrix4.identity()
                ..setEntry(3,2,0.01)
               ..rotateX(0.05),
                alignment: FractionalOffset.center,

                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 8,
                  color: cards.seeCard(i).getColor(),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: GestureDetector(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> viewCard(cards.seeCard(i),i)));

                    },
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child:  Column(

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left:20.0),
                                child: Text(cards.seeCard(i).getNameCard(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:5,left: 3),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      //color: Colors.red,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(cards.seeCard(i).getNamePayment()),
                                            fit: BoxFit.contain,

                                          )
                                      ),
                                    ),
                                    Container(
                                      height: 40,
                                      width: 90,
                                      child: Center(
                                        child: Text(
                                         '\$ '+ cards.seeCard(i).getMoney(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 27,),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right:4.0),
                                      child: Container(
                                        //color: Colors.pinkAccent,
                                        height: 60,
                                        width: 140,

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40),),color: Colors.red,
                                          //boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 1,blurRadius: 2)]
                                        ),
                                        child: Center(child: Text(checkDays(i),style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),


                                      ),
                                    )


                                  ],
                                ),

                              )
                            ]

                        ),


                      ),
                    ),
                  ),


                ),
              ),
            )
        ));
    ttop+=140;

  }
  }
  return stacks;
  }





