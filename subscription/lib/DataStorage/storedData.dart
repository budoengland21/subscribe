import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:subscription/DataStorage/CardDetails.dart';
class storedData{

  static storedData data;
  static Database database;

  //column names
  String tblName = 'subscribe_table';
  String id = 'id';
  String cardName = 'cardName';
  String days = 'days';
  String color = 'color';
  String reminder = 'reminder';
  String reminder_days = 'Reminder_days';
  String paymentType = 'Payment_type';
  String autoRenew = 'Auto_renew';
  String money = 'money';
  String actualDate = 'Date';//store date it was made




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
     var myDatabase = await openDatabase(path, version: 16, onCreate: _createDatabase);
     return myDatabase;


   }

   ///create the database if it doesn't exist
   void _createDatabase(Database db, int version) async{
     try{
       await db.execute('CREATE TABLE '
           '$tblName'
            '($id INTEGER PRIMARY KEY AUTOINCREMENT, $cardName TEXT,'
           '$days TEXT,'
           '$color TEXT,'
           '$reminder TEXT,'
          '$reminder_days INTEGER,'
         '$paymentType TEXT,'
           '$autoRenew TEXT, '
           '$money TEXT, $actualDate TEXT)');
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
     return{

       '$cardName' : card.getNameCard(),
       '$days': card.getDayCount(),
       '$color': card.getHexColor(),
       '$reminder': card.getReminder().toString(),
   //    '$reminder_days': card.getReminderDays(),
      '$paymentType': card.getNamePayment().toString(),
       '$autoRenew': card.getRenew().toString(),
       '$money': card.getMoney(),
       '$actualDate': DateTime.now().toString()


     };
   }

   ///Update card, when card clicked on
   Future<void> updateRow(CardDetails card, int cardID) async{
     Database db = await getDatabase();

     int count = await db.rawUpdate('UPDATE $tblName SET'
         '$cardName=?, $days=?, $color=?'
         '$reminder=?, $reminder_days=?, $paymentType=?,'
         '$autoRenew=?, $money=? WHERE $id=?',
         [card.getNameCard(), card.getDayCount(),
         card.getColor(), card.getReminder().toString(),
         card.getReminderDays(), card.getNamePayment(),card.getRenew().toString(),
         card.getMoney().toString(), cardID]);
   }

   ///delete item
   Future<void> deleteItem(int cardID) async{
     try{
       Database db = await getDatabase();
       db.delete(tblName, where: '$id=?',whereArgs: [cardID]);
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
   
   Future<List<CardDetails>> getData() async{

     Database db = await getDatabase();
     List maps = await db.query(tblName);
     
     return List.generate(maps.length, (index){
       CardDetails card=new CardDetails();
       //print(maps.length);
       //return new CardDetails();
       //maps[index]['$id'],
       Color c;
       bool ans;
       bool renew;
     //  c=new Color(maps[index]['$color']).value as Color;
       if (maps[index]['$reminder'] == "true"){
         card.setReminderDays((maps[index]['$reminder_days']));
         ans = true;
       }else{ans=false;}
       if(maps[index]['$autoRenew']=="true"){
         renew=true;} else{renew=false;}
       card.setNameCard(maps[index]['$cardName']);
       int val = getDifference(maps[index]['$actualDate']);//calculate the difference
       //card.setDayCount(maps[index]['$days']);
       card.setDayCount(val.toString());
       print(maps[index]['$days']);
       card.setHexColor((maps[index]['$color']));///temporary
       card.setReminder(ans);
     // card.setReminderDays((maps[index]['$reminder_days']));
       card.NamePayment(maps[index]['$paymentType']);
       card.setRenew(renew);
       card.setMoney(maps[index]['$money']);
       return card;






     });
   }

   int getDifference(String dateString){
     DateTime now = DateTime.now();
     DateTime saved = DateTime.parse(dateString);
     Duration diff = now.difference(saved);
     int x = diff.inDays;
     return x;



   }

}