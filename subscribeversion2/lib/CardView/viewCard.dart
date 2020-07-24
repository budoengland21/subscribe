
import 'package:flutter/material.dart';
import 'package:subscribeversion2/AddCardScreen/AddCard.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';
import 'package:subscribeversion2/DataStorage/CardDetails.dart';
import 'package:subscribeversion2/DataStorage/storedData.dart';
import 'package:subscribeversion2/homePage/main.dart';
import 'package:subscribeversion2/notificationData.dart';

class viewCard extends StatelessWidget {
  CardDetails card;
  int index;
  bool isOn = false; ///check if remainder is on
  CardDetails tempIndex; ///store carddetails for database to delete
  String tempName; ///store name of card to get index
  bool remOn = false; ///for notification to determine
  int channelIndex=0; ///index of card in database to delete
  ArrayOfCards a = new ArrayOfCards();
  storedData store = new storedData();
  viewCard(this.card, this.index){
    tempIndex = a.seeCard(this.index);
    isOn= this.card.getReminder();
    tempName = this.card.getNameCard();
  }

  String checkSet(){


    if (this.card.getReminderDays() == 0){
      return "Not set";

    }else if (this.card.getReminderDays() == 135){
      return "Same day";
    }
    else{
      return this.card.getReminderDays().toString() + " days";
    }}
    String checkRenew(){
      if (this.card.getRenew()){
        return "Set";
      }else{return "Not set";}
    }

    ///deletes notification if exists
    void removeNotification() {//print('this is the $tempName');

    if (isOn){///then we can delete the reminder
        //channelIndex = await store.getIndex(tempName);
        NotificationData notificationData = new NotificationData();
      //  var list = await notificationData.
      //  int val = await  store.getIndex(this.card.getNameCard());
       // notificationData.cancelNotification(channelIndex)
           notificationData.deleteAll(tempName); ///delete
      }
    }
    void delete()  {
   //   storedData store = new storedData();


       store.deleteItem(tempIndex);
       print('this is index delete:$index');


       print("size");
       print(a.checkSize());


    }

    Container checkPay(){
      if (card.getNamePayment() != null){
       return  Container(
            height: 50,width: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(this.card.getNamePayment(),
                ),fit: BoxFit.cover,
              ),));


      }  return
        Container(
            height: 50,width: 70,
           child: Center(child: Text("None",style: TextStyle(color: Colors.white,fontSize: 24),))
        );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,iconTheme: IconThemeData(color: Colors.white),
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCard(this.card,this.index) ));
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
                          Text(this.card.getDayCount()+" days", style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25))
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
                          Text("\$ "+this.card.getMoney(), style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25))

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
                          checkPay(),


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
                              ,fontSize: 25,fontWeight: FontWeight.bold))

                        ],

                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0,bottom: 30),
                        child: Container(
                          height: 0.3, color: Colors.black,),
                      ),
                      Row(
                        children: <Widget>[
                          Text("Repeat Cycle",style: TextStyle(color:Colors.white,fontSize: 30)),
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

                                 //tempIndex = a.seeCard(this.index);
                                 a.removeCard(this.index);//removes from the array
                                  Navigator.pop(context);

                                  Navigator.pop(context);//remove the  main page too
                                  //Now pop the main page, pass parameter to confirm so it doesn't go to init
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> FrontPage(true)));


                                  removeNotification();
                                 delete(); ///remove from database

                                 // delete();
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
