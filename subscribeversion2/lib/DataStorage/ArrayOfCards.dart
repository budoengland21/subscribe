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
///we need to obtain the index hence list in list
  ///better implementation using map
   List<List> obtainPast(){

     List<List> past = new List();
     for (int i =0; i < _storage.length; i++){
       if (int.parse(_storage[i].getDayCount()) < 0){
         List temp = new List();
         temp.add(_storage[i]);
         temp.add(i);
         past.add(temp);
        // temp.clear();
       }
     }return past;

   }
   List<List> obtainIncoming(){

     List<List> incoming = new List();
     for (int i =0; i < _storage.length; i++){
       if (int.parse(_storage[i].getDayCount()) >= 0 && _storage[i].getStatus()){
         List temp = new List();
         temp.add(_storage[i]);
         temp.add(i);
         incoming.add(temp);
        // temp.clear();
         print(incoming);

       }
     }return incoming;


   }

   List<List> obtainUpcoming(){

     List<List> upcoming = new List();
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

  double getBalance(List x){
     double val=0.00;
     for(int i=0; i< x.length;i++){
       val+= double.parse(x[i][0].getMoney());
     }
     return val;

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