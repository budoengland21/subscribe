import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:subscription/DataStorage/CardDetails.dart';

///this will be an singleton instance class and will represent all the
///cards in this class
class ArrayOfCards{
  static ArrayOfCards arrayOfCards;

  List<CardDetails> _storage;

  factory ArrayOfCards(){
    if (arrayOfCards == null){
      arrayOfCards = ArrayOfCards._makeInstance();
    }
    return arrayOfCards;
  }


  ArrayOfCards._makeInstance(){
    _storage = new List();
  }



  void addCard(CardDetails a){
    _storage.add(a);
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