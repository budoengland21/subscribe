
import 'package:flutter/material.dart';
import 'package:subscribeversion2/AddCardScreen/AddCard.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';
import 'package:subscribeversion2/DataStorage/CardDetails.dart';
import 'package:subscribeversion2/DataStorage/storedData.dart';

class viewCard extends StatelessWidget {
  CardDetails card;
  int index;

  viewCard(this.card, this.index);

  String checkSet(){
    if (this.card.getReminderDays() == 0){
      return "Not set";
    }else{
      return this.card.getReminderDays().toString();
    }}
    String checkRenew(){
      if (this.card.getRenew()){
        return "Set";
      }else{return "Not set";}
    }

    void delete() async{
    ArrayOfCards a = new ArrayOfCards();
       storedData store = new storedData();
       a.removeCard(this.index);//removes from the array

      // int val = await store.getID(this.index);
       store.deleteItem(a.seeCard(this.index));

       print("size");
       print(a.checkSize());


    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,),
      body:
        Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
               // height: MediaQuery.of(context).size.height,

                decoration: BoxDecoration(color: this.card.getColor(),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))),
               //add all data to extract and put

                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      /// the title
                      Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Row(
                          children: <Widget>[
                            Text(this.card.getNameCard()
                              ,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 40),),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right:3.0),
                              child: RaisedButton(
                                child: Text("EDIT", style: TextStyle(color: Colors.white),),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCard(this.card,this.index,null) ));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                                ),

                              ),
                            )


                          ],

                        ),
                      ),
                   ///space
                        Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 25),

                      ),
                      ///the number of days
                      Row(
                        children: <Widget>[
                          Text("Days remaining",style: TextStyle(color:Colors.white,fontSize: 30)),
                          Spacer(),
                          Text(this.card.getDayCount(), style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25))
                        ],

                      ),
                      ///horizontal ruler
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 25),
                        child: Container(
                          height: 0.3, color: Colors.black,),
                      ),

                      Row(
                        children: <Widget>[
                          Text("Amount",style: TextStyle(color:Colors.white,fontSize: 30)),
                          Spacer(),
                          Text(this.card.getMoney(), style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25))

                        ],

                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 25),
                        child: Container(
                          height: 0.3, color: Colors.black,),
                      ),
                      Row(
                        children: <Widget>[
                          Text("Payment type",style: TextStyle(color:Colors.white,fontSize: 30)),
                          Spacer(),
                          Container(
                            height: 50,width: 70,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(this.card.getNamePayment(),
                               ),fit: BoxFit.cover,
                          ),))

                        ],

                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 25),
                        child: Container(
                          height: 0.3, color: Colors.black,),
                      ),
                      Row(
                        children: <Widget>[
                          Text("Reminder",style: TextStyle(color:Colors.white,fontSize: 30)),
                          Spacer(),
                          Text(checkSet(), style: TextStyle(color:Colors.white
                              ,fontSize: 25))

                        ],

                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 30),
                        child: Container(
                          height: 0.3, color: Colors.black,),
                      ),
                      Row(
                        children: <Widget>[
                          Text("Autorenew",style: TextStyle(color:Colors.white,fontSize: 30)),
                          Spacer(),
                          Text(checkRenew(), style: TextStyle(color:Colors.white
                              ,fontSize: 25))

                        ],

                      ),
                      Spacer(),

                      ///the buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[


                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width/2,

                              child:  RaisedButton(
                                child:  Text("Delete", style: TextStyle(color: Colors.white,fontSize: 30),),
                                color: Colors.black,
                                ///delete from database
                                onPressed: () {
                             //    a.removeCard(this.index);
                                  delete();
                                  Navigator.pop(context);
                                },
                                elevation: 15,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)
                                ),

                              ),
                            ),
                          )

                        ],
                      )



                    ],
                  ),
                ),

              ),
            ),
          ],
        )
    );

  }
}
