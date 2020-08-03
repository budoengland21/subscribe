import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'CardDetails.dart';


///this will be an singleton instance class and will represent all the
///cards in this class
class ArrayOfCards{
  static ArrayOfCards arrayOfCards;


  List<CardDetails> _storage;
  List<CardDetails> _storageSave; ///used to store copy
  bool updated;

   ArrayOfCards.createInstance(){
     _storage = new List();
     _storageSave = new List();
     updated = false;
   }

   factory ArrayOfCards(){
     if (arrayOfCards == null){
       arrayOfCards = ArrayOfCards.createInstance();
     }
     return arrayOfCards;

   }


   void performSort(int filterType){
     print("HERRRRRRRRRRR");
     print(filterType);
     if (filterType == 2){///for high days

       _storage.sort((y,x){///ascending
         return  double.parse(x.getMoney()).compareTo(double.parse(y.getMoney()));
       });
     }else if (filterType == 3){///for low days
       _storage.sort((x,y){///low to high
         return  double.parse(x.getMoney()).compareTo(double.parse(y.getMoney()));
       });
     }else if (filterType == 4){///for desscending days
       _storage.sort((y,x){
         return  double.parse(x.getDayCount()).compareTo(double.parse(y.getDayCount()));
       });
     }else if (filterType == 5) {
       ///descending days
       _storage.sort((x, y) {
         return double.parse(x.getDayCount()).compareTo(
             double.parse(y.getDayCount()));
       });
       //   }else if (filterType ==1){
       ///then default
       // if (_storageSave.length!=0){///incase they press as first
       //  _storage = List.of(_storageSave);
       //  }

     }else{

       _storage.sort((x, y) {
         return (x.getSortId()).compareTo(
             (y.getSortId()));
       });
     }
       ///this is the first time pressed
     //  if (_storage.length> _storageSave.length && _storageSave.length!=0){
    //     ///that means storage was updated
   //      ///add the new item of storage to storage save
    //     ///because storage has sorted items
   //      ///and storage save is default
         print("new added");
     //    _storageSave.add(_storage[_storage.length-1]);
    //     _storage = List.of(_storageSave);
   //    }else{///saves the copy first time it runs
   //      _storageSave = List.of(_storage);
     //  }


   }
///we need to obtain the index hence list in list
  ///better implementation using map
   List<List> obtainPast(int filterType){

     List<List> past = new List();
     performSort(filterType);
     for (int i =0; i < _storage.length; i++){
       if (int.parse(_storage[i].getDayCount()) < 0){
         List temp = new List();
         temp.add(_storage[i]);
         temp.add(i);
         past.add(temp);
        // temp.clear();
       }
     }

     return past;

   }
   List<List> obtainIncoming(int filterType){

     List<List> incoming = new List();
    performSort(filterType);

     for (int i =0; i < _storage.length; i++){
       if (int.parse(_storage[i].getDayCount()) >= 0 && _storage[i].getStatus()){
         List temp = new List();
         temp.add(_storage[i]);
         temp.add(i);
         incoming.add(temp);
        // temp.clear();
         print(incoming);

       }

     }
     return incoming;


   }

   List<List> obtainUpcoming(int filterType){

     List<List> upcoming = new List();
     performSort(filterType);
     for (int i=0; i< _storage.length; i++){
       print(_storage[i].getStatus());
       print("RT000001");
       if (!_storage[i].getStatus()){///if status false, then upcoming
         List temp = new List();
         temp.add(_storage[i]);
         temp.add(i);
         upcoming.add(temp);
      //   temp.clear();


        }

     }return upcoming;
   }

  String getBalance(List x){
     double val=0;
     for(int i=0; i< x.length;i++){
       val+= double.parse(x[i][0].getMoney());
     }
     return val.toStringAsFixed(2);

  }

   void updatePerformed(){
     updated = true;
   }

   void replaceCard(int i, CardDetails newVal){
     _storage[i] = newVal;

   }



   void removeAll(){
     _storage.clear();
   }


  void addCard(CardDetails a){
    _storage.add(a);
  }
  void addAll(List<CardDetails> list){
     _storage.addAll(list);

  }

  void removeCard(int index){
    _storage.removeAt(index);
  }

   int checkSize(){
    return _storage.length;
  }


  CardDetails seeCard(int i){
    return _storage[i];
  }




}