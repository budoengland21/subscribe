import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:subscribeversion2/notificationData.dart';

import 'CardDetails.dart';

class storedData{

  static storedData data;
  static Database database;

  //column names
  String tblName = 'subscribe_table';
  String id = 'id';
  String cardName = 'cardName';
  String days = 'days';
  String dayColor = 'day_color';
  String color = 'color';
  String reminder = 'reminder';
  String reminder_days = 'Reminder_days';
  String paymentType = 'Payment_type';
  String autoRenew = 'Auto_renew';
  String cycleDays = 'Cycle';
  String statusCheck = 'status'; //
  String money = 'money';
  String actualDate = 'actualDate';//store date it was made
  String dateNow = 'DateNow'; // used to calculate the database and compare days passed each time app opened
  String lastDate = 'lastDate'; //Stores the last date to the notification
  String futureDays = 'Future';

  int diff;
  int future;
  int dateCreated;

  int sortVal; ///store id in this for sorting

  factory storedData(){
    if (data == null){
      data = storedData._makeInstance();


    }
    return data;
  }

  ///same as (ths is your class so can initialize anything
  ///storedData.anyName(){
  ///......}
  storedData._makeInstance();//this is the class

///get the database
///
   Future<Database> getDatabase() async {
     if (database == null){
       database = await initializeDatabase();
  }
     return database;
}
///open the databse and it will create one if it doesn't exist
   Future<Database> initializeDatabase() async{
     Directory directory = await getApplicationDocumentsDirectory();
     String path = join(directory.path, 'subscribe.db');
     //open database
     var myDatabase = await openDatabase(path, version: 36, onCreate: _createDatabase);
     return myDatabase;


   }

   ///create the database if it doesn't exist
   void _createDatabase(Database db, int version) async{
     try{
       await db.execute('CREATE TABLE '
           '$tblName'
            '($id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , $cardName TEXT,'
           '$days TEXT,'
           '$dayColor TEXT, '
           '$color TEXT,'
           '$reminder TEXT,'
         '$reminder_days INTEGER,'
         '$paymentType TEXT,'
           '$autoRenew TEXT, '
           '$cycleDays INTEGER,'
           '$statusCheck STRING,' // ADDED THE STATUS TO DATABASE

           '$money TEXT,'
           '$actualDate TEXT,'
           ' $dateNow TEXT,'
           '$lastDate TEXT,' //STORES THE LAST DATE OF THE NOTIFICATION
           '$futureDays INTEGER)');

     }
     catch(Exception){
       print (Exception);
     }
   }

   Future<void> insertDb(CardDetails card) async{

     Database db = await getDatabase();
     Map map = _mapItems(card);
     print(map.toString());
     await db.insert(tblName, map);

   }

   Map<String, dynamic> _mapItems(CardDetails card){
     print('inserting');

     return{



       '$cardName' : card.getNameCard(),
       '$days': card.getDayCount(),
       '$dayColor': card.getDayHex(),
       '$color': card.getHexColor(),
       '$reminder': card.getReminder().toString(),
       '$reminder_days': card.getReminderDays(),
      '$paymentType': card.getNamePayment().toString(),
       '$autoRenew': card.getRenew().toString(),
       '$cycleDays': card.getCycleDays(),
       '$statusCheck': card.getStatus().toString(),
       '$money': card.getMoney(),
       '$actualDate': card.getDate().toString(),
       '$dateNow': DateTime.now().toString(),
       '$lastDate': card.getLastDate().toString(),
       '$futureDays': card.getFuture(),


     };
   }

   Future<int> getIndex(String cardName) async{
     Database db = await getDatabase();

    List<Map> map= await db.rawQuery('SELECT * from $tblName WHERE cardName = ?', [cardName]);/// this just retrieves the id of the row
     int val = map[0]['id'];

   // var x =  map[0].values.toList(); //it's dynamic so change to list then integer
   // int v = x[0];
    print(val);
   //print("index $v");
     return val;



   }


   ///get last index of card
   Future<int> lastIndex() async{
     Database db = await getDatabase();

     List<Map> map= await db.rawQuery('SELECT * from $tblName ');/// this just retrieves the id of the row
     if (map.length == 0){
       return 1;
     }else{
       int val = map[map.length-1]['id'];

       return val;
     }

   }




   ///Update card, when card clicked on
   Future<void> updateRow(CardDetails card, String oldName) async{
     Database db = await getDatabase();
     print("----------------");
    // print(card.getDayCount());
     //print(getIndex(cardIndex));
    int index = await getIndex(oldName);


 //    print(cardCol);
    // print("----------------");
     Map map = _mapItems(card);
     print(map.toString());
    int count = await db.update(tblName, map,where: '$id=?', whereArgs: [index]);

    /* int count = await db.rawUpdate('UPDATE $tblName SET '
         '$cardName=?, $days=?, $dayColor=?, $color=?,'
         '$reminder=?, $reminder_days=?, $paymentType=?,'
         '$autoRenew=?, $money=?, $actualDate=? WHERE $id=? ',
         [card.getNameCard(), card.getDayCount(), card.getDayHex(),
         card.getHexColor(), card.getReminder().toString(),
         card.getReminderDays(), card.getNamePayment().toString(),card.getRenew().toString(),
         card.getMoney(), DateTime.now().toString(), cardCol]);*/
     print("UPDATEDDD: $count");
   }

   ///delete item
   Future<void> deleteItem(CardDetails card) async{
     try{
       Database db = await getDatabase();
       int index =  (card.getSortId());
       db.delete(tblName, where: '$id=?',whereArgs: [index]);
     }catch(Exception){
       print('deleteError: '+Exception);
     }
   }
  Future<int> totalSize() async{
    Database db = await getDatabase();
    List <Map<String,dynamic>> map = await db.rawQuery('SELECT COUNT (*) from $tblName');
    int size = Sqflite.firstIntValue(map);
    return size;

  }
//returns index/id of last item
  Future<int> lastItem() async{
    Database db= await getDatabase();
    List<Map> result = await db.query(tblName);
    if (result.length == 0){
      return 0;
    }
    else{

      int Lastindex = result.length-1;



      return result[Lastindex].values.first;  // gets id of the last item.
    }
   }




    Future<List<CardDetails>> getData() async{

     Database db = await getDatabase();
     List maps = await db.query(tblName);

     return List.generate(maps.length, (index) {
       CardDetails card=new CardDetails();
       print(maps.toString());
     //  f(maps[index]['$cardName']);
      // int z = await getIndex();
       card.setSortId(maps[index]['$id']);///get the index of card in databse

       bool ans;
       bool renew;
       bool startedCheck;
        future = maps[index]['$futureDays'];
        ///code checks difference between suscription created vs now
        DateTime real = DateTime.now();
        DateTime temp = DateTime.parse(maps[index]['$actualDate']);///begin cycle
        dateCreated = DateTime(real.year, real.month,real.day).difference
          (DateTime(temp.year,temp.month,temp.day)).inDays;


       if (maps[index]['$statusCheck']== "true"){
         startedCheck = true;
       }else{
         startedCheck = false;
       }

     //  c=new Color(maps[index]['$color']).value as Color;
    //   print("LOOK DOWN REMINDER");
   //    print(maps[index]['$reminder']);
       if (maps[index]['$reminder'] == "true"){

         card.setReminderDays((maps[index]['$reminder_days']));
         ans = true;
       }else{ans=false; card.setReminderDays(0);//dummy value instead of null
       }
       if(maps[index]['$autoRenew']=="true"){
         renew=true;} else{renew=false;}
       card.setNameCard(maps[index]['$cardName']);
       print("seee"+maps[index]['$days']);

       ///update hasStarted if future == 0


       ///calculate the difference and check whether to repeat the cycle
       String val = getDifference(maps[index]['$dateNow'], maps[index]['$days'],renew, maps[index]['$cycleDays'],startedCheck);
       print('This is the new future $future');
       if (future == 0){
         card.updateStatus(true);
         startedCheck = true;
         future = 0;
       }
       String d_color = findDayColor();
       print(" COLOR $d_color");
       print('started --- $startedCheck');
       card.setDayColorHex(d_color);
       card.setDayCount(val);
       card.setCycleDays(maps[index]['$cycleDays']); //set the cycle can only be changed when edited out

       ///set the future days
       card.setFutureDays(future);



         card.updateStatus(startedCheck);


       ///obtain date created
       card.setDate(DateTime.parse(maps[index]['$actualDate']));

       card.setHexColor((maps[index]['$color']));
       card.setReminder(ans);
     // card.setReminderDays((maps[index]['$reminder_days']));
       card.NamePayment(maps[index]['$paymentType']);
       card.setRenew(renew);
       card.setMoney(maps[index]['$money']);


       DateTime d = DateTime.parse(maps[index]['$lastDate']);
       card.setLastDate(d);

       if (ans){  ///meaning reminder on
         checkNotifications(d,maps[index]['$cardName'],maps[index]['$cycleDays'],int.parse(maps[index]['$money']),renew );
         card.setLastDate(obtainUpdatedLastDate()); ///reupdates the last date
       }

     //  updateRow(card,maps[index]['$cardName'] ); ///update to add the last
       return card;






     });
   }

   String findDayColor(){
     //check reminder days
     //String check = days;
     print("Days remaining updated-->: $diff");

     ///code simplified so just check the days
     ///if it is 1 day/today then ---> RED
     ///ELSE --> GREEN

     ///now we'll use diff to keep track of the days
     ///and hence if its 1 day or today then it's red
     if (diff <= 1 ){
       return "#FF0000";//red color
     }else{

       return '#1aff31';
     }



   }
   ///gets the difference in days and update the subscription
  ///Method will also be used for the notification
   String getDifference(String dateString, String days, bool cycleStatus, int cycleCount, bool hasStarted){
     DateTime now = DateTime.now();

     int nowDay =  int.parse(days);


     DateTime saved = DateTime.parse(dateString);///technically the date it was created too




     ///difference between date made and now
      diff = DateTime(now.year, now.month,now.day).difference
        (DateTime(saved.year,saved.month,saved.day)).inDays; //leave as original if same as day (ie it is 0)

     print('diff in days $diff');


     //first check if upcoming

     print('diff in days btwn begin cycle: $dateCreated');
     print("has it started: $hasStarted");

     ///update the future so we can reduce it day by day
     if (!hasStarted && diff >0){
       ///future value being decreased
       future-=1;
     }

     ///reupdates the upcoming all the time to avoid it going back since its original value in database
     if (dateCreated >= 0){
       future=0;
     }
     ///check if in upcoming and its starts todY
     ///so the difference between today date and date it was made==0, then it has reached that day
     if(!hasStarted && dateCreated==0){//then the cycle has started so put in incoming
       print("No longer a future");
      // future=0;
       diff = nowDay;
     }

      ///check after  it is today
     ///so dateCreated will be greater than cycle and it is either expired
     ///or ready for renewal,
     ///eg, if cycle is 7 days and date created =7,(so due today)
     ///when database checked again date created=8, then check if above cycle(
     ///by adding +1) , see if renewal is set to update it or expire it

     else if (dateCreated == cycleCount+1){
       if (cycleStatus){
         print("Cycle started again");
         diff = cycleCount - 1;
       }else{// then it is expired
         print("I AM EXPIRED");
         diff = -1;
       }
     }



     ///checks if one day has passed, then updates the day
   // else if ((diff == 0)){// && saved.day !=now.day)){


     //    diff = nowDay-1;//Nowday is the days remaining


    // }
     ///checks if diff days same as days for cycle, then it's set today
     else if (diff == nowDay){
       print("ITS TODAY");

        // return "TODAY";
        diff = 0;



     }

     ///subtracts days based on how many have passed
     ///set the diff to be the days remaining to show on the display
     ///dateCreated>0, means the begin cycle is 1 day more than now, hence not future
     else if (diff >= 0 && (dateCreated > 0)){
        diff = nowDay - diff;
       // diff = diff.abs(); ///so as expired stays not negative
        future=0;


     }
     ///if its expired,leave as is
     else if (diff < 0){
       //diff= diff.abs(); ///just to show how many days expired by
       print("STILL EXPIRED");
       diff = -1;
     }

     ////it's past due, so check if renew on, then repeat cycle else make it expired
   /*  else if (diff < 0 || diff==-1){
       // if cycle on, reset days

       if (cycleStatus){
         diff = cycleCount - 1;
       }else{// then it is expired
         diff = -1;
       }
    }*/

     /// then its the same day and no change
     else{//assume it comes here only if diff< then it's a future
       print("it's defo a future that's still not yet");
       diff = nowDay;
     }
    return diff.toString();




   }
 ///adds datetimes to schedule if app hasn't been opened
  ///for a while and then reupdates the last date
    void checkNotifications(DateTime d, String name, int cycle, int amount,bool Isrenew)async{
     NotificationData notificationData = NotificationData();
      await notificationData.reupdatePendingNotifications(d, name, cycle, amount,Isrenew);

   }


   DateTime obtainUpdatedLastDate(){
     NotificationData notificationData = NotificationData();
     return notificationData.getLast();
   }

}