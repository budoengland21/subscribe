import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
  String money = 'money';
  String actualDate = 'actualDate';//store date it was made

  int diff;


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
     var myDatabase = await openDatabase(path, version: 29, onCreate: _createDatabase);
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
           '$cycleDays INTEGER,' // ADDED THE CYCLE TO DATABASE
           '$money TEXT,'
           '$actualDate TEXT)');
     }
     catch(Exception){
       print (Exception);
     }
   }

   Future<void> insertDb(CardDetails card) async{

     Database db = await getDatabase();
     Map map = _mapItems(card);
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
       '$money': card.getMoney(),
       '$actualDate': DateTime.now().toString()


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
       db.delete(tblName, where: '$cardName=?',whereArgs: [card.getNameCard()]);
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
     
     return List.generate(maps.length, (index){
       CardDetails card=new CardDetails();
       //print(maps.length);
       //return new CardDetails();
       //maps[index]['$id'],

       bool ans;
       bool renew;
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

       ///calculate the difference and check whether to repeat the cycle
       String val = getDifference(maps[index]['$actualDate'], maps[index]['$days'],renew, maps[index]['$cycleDays']);
       String d_color = findDayColor(maps[index]['$dayColor'],card.getReminderDays());
     //  print("DY COLOR $d_color");
       card.setDayColorHex(d_color);
       card.setDayCount(val);
       card.setCycleDays(maps[index]['$cycleDays']); //set the cycle can only be changed when edited out


       card.setHexColor((maps[index]['$color']));
       card.setReminder(ans);
     // card.setReminderDays((maps[index]['$reminder_days']));
       card.NamePayment(maps[index]['$paymentType']);
       card.setRenew(renew);
       card.setMoney(maps[index]['$money']);
       return card;






     });
   }

   String findDayColor(String cal, int remainder){
     //check reminder days
     //String check = days;
     print("diiff: $diff");

     if (remainder == 0){
       if (diff == 1){//meaning 1 day remaining
         return "#FF0000";//red color to mean 1 day remaining
       }else{
         return cal;//green color as default
       }
     }
     else{//then user set a reminder, so check the day they set it
        if (diff == 0 || diff < 0){
         return "#FF0000";
       }
       else{
         //int val = int.parse(days.substring(0,1));
         if (diff == remainder){
           return "#FF0000";
         }
         else{
           return cal;//green as default if reminder not reached
         }
         
       }
     }

   }
   ///gets the difference in days and update the subscription
  ///Method will also be used for the notification
   String getDifference(String dateString, String days, bool cycleStatus, int cycleCount){
     DateTime now = DateTime.now();

     int nowDay =  int.parse(days);


     DateTime saved = DateTime.parse(dateString);

      diff = now.difference(saved).inDays; //leave as original if same as day (ie it is 0)

     ///checks if one day has passed, then updates the day
     if ((diff == 0 && saved.day !=now.day)){
       diff = nowDay-1;
     }
     ///checks if diff days same as days for cycle, then it's set today
     else if (diff == nowDay){

      // return "TODAY";
       diff = 0;
     }

     ///subtracts days based on how many have passed
     else if (diff > 0){
       diff = nowDay - diff;
     }

     ///it's past due, so check if renew on, then repeat cycle else make it expired
     else if (diff < 0){
       // if cycle on, reset days
       if (cycleStatus){
         diff = cycleCount - 1;
       }else{// then it is expired
         diff = -1;
       }
    }

     /// then its the same day and no change
     else{
       diff = nowDay;
     }
    return diff.toString();




   }

}