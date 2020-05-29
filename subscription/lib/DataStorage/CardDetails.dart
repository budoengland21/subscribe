
import 'package:flutter/material.dart';


class CardDetails{
// _ (private fields for attributes)
  String _nameCard;
  String _dayCount;
  String _color;
  bool _reminder;
  int _reminderDays;
  String _namePayment;
  bool _renew;
  String _money;
  Color _temp;
  Color _dayColor;

  String dayTemp;

  bool _track; // check if all fields are filled

  CardDetails(){
    _reminder=false;
   _renew=false;
  }

  String getMoney() => _money;
   void setMoney(String value) {
    _money = value;
  }

  bool getRenew() => _renew;
  void setRenew(bool value) {
    _renew = value;
  }

  String getNamePayment() => _namePayment;
  void NamePayment(String value) {
    _namePayment = value;
  }

  int getReminderDays() {
    if (_reminder){
      return _reminderDays;
    }
    else{
      return 0;
    }

  }
  void setReminderDays(int value) {
    _reminderDays = value;
  }

  bool getReminder() => _reminder;
  void setReminder(bool value) {
    _reminder = value;
  }


  void  setColor(Color c) {//change color to string value
    _color = '#${c.value.toRadixString(16).substring(2)}'; //change eg color(blue) to hex #f00000
  }
  Color getColor(){ // to retrieve string hex color and turn to color
  //  _temp = (Color(int.parse(_color.substring(1, 7), radix: 16) + 0xFF000000)); // changes String in hex format #f000000 to Color(0xf00000)
    if (_temp == null){
      setHexColor(_color);
    }
    return _temp;
  }

  //store color in db
  String getHexColor(){
    return _color;
  }


  void setHexColor(String c){
    if (c!=null){
      _temp = (Color(int.parse(c.substring(1, 7), radix: 16) + 0xFF000000)); // changes String in hex format #f000000 to Color(0xf00000)
    }
    }




  String getDayCount() => _dayCount;
 void setDayCount(String value) {

    _dayCount = value;
  }

  String getNameCard() {
    return _nameCard;
  }
   void setNameCard(String value) {
    _nameCard = value;
  }
  ///sets the day color----------------------------------------------
  void setDayColor(Color c){
    // _dayColor = c;
     dayTemp = '#${c.value.toRadixString(16).substring(2)}'; //change eg color(blue) to hex #f00000
  }
  Color getDayColor(){
   if (_dayColor == null){
     setDayColorHex(dayTemp);
   }

   return _dayColor;
  }
  void setDayColorHex(String c){
   print (c);
   if (c != null){
     _dayColor = (Color(int.parse(c.substring(1, 7), radix: 16) + 0xFF000000)); // changes String in hex format #f000000 to Color(0xf00000)
   }




    // return _dayColor.toString();
  }
  String getDayHex(){
     return dayTemp;
  }



  ///Checks if all fields were filled
  ///if not then button can't be selected
  bool checkAll(){
    if ((_nameCard!=null) && (_dayCount!=null)  &&
        (_namePayment!=null) && (_money!=null) ){
      //also insert into database
     // insertDatabase();

      return true;
    }else{
      return false;
    }
  }




}