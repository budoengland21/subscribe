import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:subscription/DataStorage/CardDetails.dart';

///this will be an singleton instance class and will represent all the
///cards in this class
class ArrayOfCards{
  static ArrayOfCards arrayOfCards;

  List<CardDetails> _storage;

   ArrayOfCards.createInstance(){
     _storage = new List();
   }

   factory ArrayOfCards(){
     if (arrayOfCards == null){
       arrayOfCards = ArrayOfCards.createInstance();
     }
     return arrayOfCards;

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