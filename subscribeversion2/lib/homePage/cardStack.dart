import 'package:currency_pickers/country.dart';
import 'package:currency_pickers/currency_picker_dropdown.dart';
import 'package:currency_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subscribeversion2/CardView/viewCard.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';
import 'package:subscribeversion2/homePage/main.dart';
///
/// creates a stack of cards to display on the home screen

List determineType(String c , ArrayOfCards array){


  print(c);
  if (c == "pass"){
    return array.obtainPast();
  }else if (c == "upcoming"){

    //return null;
    return array.obtainUpcoming();// add to database to inform user
  }else{

    return array.obtainIncoming();
  }
}
List<Widget> stackOfCards(ArrayOfCards cards, BuildContext context, String cardType)  {
  //ArrayOfCards cards = new ArrayOfCards();
  //cards.addCard()
  ///use if statement check if 0, then show balance
  print("passed here");
 // print((cards.checkSize()));
  Color isFuture;
  Color isFutureNumber;

  List<Widget> stacks = [];
  double ttop=140;
  double lleft= 4;
  double rright=4;


  ///NEED INDEX OF ARRAY OF CARDS AND NOT THE LIST TO UPDATE AND DELETE

  List stackType = determineType(cardType,cards);
int check = stackType.length;
  String balance = cards.getBalance(stackType);

  print('size---> $check');
  if (check == 0){
    stacks.add(
      Padding(
        padding: const EdgeInsets.only(top:100,bottom: 100),
        child: Center(
            child: Text('Add a subscription by clicking +',style: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 20),)),
      )


    );


  }
  ///add stack to show the balance
  ///

  else{
    stacks.add(

    Positioned(
        top:20,
        left:30,
        right: 30,
        child: Card(
            margin: EdgeInsets.zero,
            elevation: 10,shadowColor: Colors.green,
            color:Color.fromRGBO(255, 241, 118, 0.75),


           child: Container(

              width: double.infinity,
              // color: Colors.blue,
              height: 90,
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
                        width: 200,
                        child: Center(child: Text("$currency $balance",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 23),))
                        ),
                    Spacer(),

                            ],
        ),
        ),

        ),
        )
        );

    for (int i=0; i< check; i++){
      if (cardType == "upcoming"){
        isFuture = Colors.black;
        isFutureNumber = Colors.white;
      }else{
        isFuture = stackType[i][0].getColor();
        isFutureNumber = stackType[i][0].getColor();
      }

      stacks.add(
          Positioned(
              top: ttop,
              left: lleft,
              right: rright,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Transform(
                  transform:  Matrix4.identity()
                    ..setEntry(3,2,0.01)
                    ..rotateX(0.05),
                    alignment: FractionalOffset.center,


                  child: GestureDetector(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> viewCard(stackType[i][0],stackType[i][1])));


                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 20,
                      color: stackType[i][0].getColor(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20))
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child:  Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left:20.0),
                                      child: Text(stackType[i][0].getNameCard(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30,),),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right:10.0),
                                      child: Container(
                                        color: isFuture,
                                        width: 50,
                                        height: 25,
                                        child: Center(child: Text(stackType[i][0].getFuture().toString(), style: TextStyle(color: isFutureNumber,fontWeight: FontWeight.bold),),),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:5,left: 3),
                                  child: Row(
                                    children: <Widget>[
                                      checkPayment(i, stackType),

                                      Container(
                                        height: 40,
                                        width: 150,
                                        child: Center(
                                          child: Text(
                                            '$currency ' + stackType[i][0].getMoney(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23,),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.only(right:4.0),
                                        child: Container(
                                          //color: Colors.pinkAccent,
                                          height: 55,
                                          width: 140,

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(40),),color: stackType[i][0].getDayColor(),

                                              boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 4,blurRadius: 2)]
                                          ),

                                          child: Center(child: Text(modifyView(stackType[i][0].getDayCount()),style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),


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

String modifyView(String days){
  if (days == "-1"){
    return "EXPIRED";
  }else if (days == "0"){
    return "TODAY";
  }
  else if (days == "1"){
    return days+ " DAY";
  }
  else{
    return days+ " DAYS";
  }
}

Container checkPayment(int i, List stack){

    return (
        Container(
          height: 60,
          //color: Colors.red,
          width: 50,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(stack[i][0].getNamePayment()),
                fit: BoxFit.contain,

              )
          ),
        )
    );


}






