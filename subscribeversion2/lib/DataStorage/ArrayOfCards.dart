import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'CardDetails.dart';


///this will be an singleton instance class and will represent all the
///cards in this class
class ArrayOfCards{
  static ArrayOfCards arrayOfCards;


  List<CardDetails> _storage;
  bool updated;

   ArrayOfCards.createInstance(){
     _storage = new List();
     updated = false;
   }

   factory ArrayOfCards(){
     if (arrayOfCards == null){
       arrayOfCards = ArrayOfCards.createInstance();
     }
     return arrayOfCards;

   }

   List<CardDetails> obtainPast(){
     List<CardDetails> past = new List();
     for (int i =0; i < _storage.length; i++){
       if (int.parse(_storage[i].getDayCount()) < 0){
         past.add(_storage[i]);
       }
     }return past;

   }
   List<CardDetails> obtainIncoming(){
     List<CardDetails> incoming = new List();
     for (int i =0; i < _storage.length; i++){
       if (int.parse(_storage[i].getDayCount()) >= 0){
         incoming.add(_storage[i]);
       }
     }return incoming;


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