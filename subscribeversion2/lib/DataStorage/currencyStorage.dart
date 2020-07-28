
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class currencyStorage{
  static currencyStorage currencyData;
  static Database currencyDatabase;

  String tblName = 'currencyTable';
  String savedCurrency = 'CurrencyType';
  String id = 'id';

  factory currencyStorage(){
    if (currencyData == null){
      currencyData = currencyStorage.createInstance();
    }
    return currencyData;
  }

  ///class to create it
 currencyStorage.createInstance();

  ///get the database
  ///
  Future<Database> getDatabase() async {
    if (currencyDatabase== null){
      currencyDatabase = await initializeDatabase();
    }
    return currencyDatabase;
  }

  ///open the databse and it will create one if it doesn't exist
  Future<Database> initializeDatabase() async{    print("CREATED");
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'currency.db');
    //open database
    var myDatabase = await openDatabase(path, version: 10, onCreate: _createDatabase);
    return myDatabase;


  }

  void _createDatabase(Database db, int version) async{
    try{
      await db.execute('CREATE TABLE '
          '$tblName'
          '($id INTEGER , $savedCurrency TEXT)');
    }catch(Exception){
      print(Exception);
    }

  }

  Future<void> insertCurrency(String s) async{

    Database db = await getDatabase();
    Map map = _mapItems(s);
    print(map.toString());
    await db.insert(tblName, map);

  }

  Map<String, dynamic> _mapItems(String c) {
    print('inserting currency');

    return {
      '$id': 0,
      '$savedCurrency': c.toString()
    };
  }

  ///get the latest currency
  Future<List<String>> getCurrency() async {
    Database d = await getDatabase();
    List<Map> map= await d.query(tblName);/// this just retrieves the id of the row
    return List.generate(map.length, (index) {
      String c = map[index]['$savedCurrency'];
      return c;
    }
    );

  }





  }



