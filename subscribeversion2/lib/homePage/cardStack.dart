import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subscribeversion2/CardView/viewCard.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';
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


  List<Widget> stacks = [];
  double ttop=10;
  double lleft= 0;
  double rright=0;


  List stackType = determineType(cardType,cards);
  int check = stackType.length;

  print('size---> $check');
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


    for (int i=0; i< check; i++){

      stacks.add(
          Positioned(
              top: ttop,
              left: lleft,
              right: rright,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Transform(
                  transform:  Matrix4.identity()
                    ..setEntry(3,2,0.01)
                    ..rotateX(0.05),
                    alignment: FractionalOffset.center,


                  child: GestureDetector(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> viewCard(stackType[i],i)));


                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 10,
                      color: stackType[i].getColor(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      ),
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
                                  child: Text(stackType[i].getNameCard(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38,),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top:5,left: 3),
                                  child: Row(
                                    children: <Widget>[
                                      checkPayment(i, stackType),

                                      Container(
                                        height: 40,
                                        width: 90,
                                        child: Center(
                                          child: Text(
                                            '\$ ' + stackType[i].getMoney(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23,),
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
                                            borderRadius: BorderRadius.all(Radius.circular(40),),color: stackType[i].getDayColor()
                                            //boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 1,blurRadius: 2)]
                                          ),

                                          child: Center(child: Text(modifyView(stackType[i].getDayCount()),style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),


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
  if (stack[i].getNamePayment() != null){
    return (
        Container(
          height: 60,
          //color: Colors.red,
          width: 70,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(stack[i].getNamePayment()),
                fit: BoxFit.contain,

              )
          ),
        )
    );

  }return Container(
    height: 60,
    //color: Colors.red,
    width: 70,
  );
}






