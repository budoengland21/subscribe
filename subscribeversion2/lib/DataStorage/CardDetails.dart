
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
  int _cycleDays;
  bool _status; ///represents if subscription has started, false if upcoming
  DateTime created; ///stores the day created, so as to view when updating page
   int futureDays;


  String dayTemp;

  bool _track; // check if all fields are filled

  CardDetails(){
    _reminder=false;
   _renew=false;
 //  _status = true; //default that it has started
  }

  ///once called, then it hasn't started
  void updateStatus(bool val){
    print("CHANGED");
    _status = val;
  }

  ///reduces the days to reach the cycle
  void setFutureDays(int i){
    futureDays = i;
  }
  int getFuture(){
    return futureDays;
  }

  bool getStatus(){
    return _status;
  }

  void setDate(DateTime startingDate){
    created = startingDate;

  }
  DateTime getDate(){
    return created;
  }


  int getCycleDays() => _cycleDays;

  void setCycleDays(int value) {
    _cycleDays = value;
  }

  String getMoney() => _money;
   void setMoney(String value) {
    _money = value;
  }

  bool getRenew() => _renew;
  void setRenew(bool value) {
    _renew = value;
  }

  String getNamePayment() {
    if (_namePayment == "None") {
      return null;

    }else {
      return _namePayment;
    }
   // _namePayment;
  }
  void NamePayment(String value) {
    if (value == null){
      _namePayment = "None";
    }else{
    _namePayment = value;
  }}

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

      setHexColor(_color);

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
    print('dayTemp: $dayTemp');
  }
  Color getDayColor(){
   print('daycolor $_dayColor');


     setDayColorHex(dayTemp);


   print('daycolor again $_dayColor');
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

  ///checks to see if the remainder days is valid, if renew is off
  ///based on the days remaining

  ///1 = means invalid
  int checkRemDays(bool renewal, int daysNow){
    //List i = new List();
     if (!renewal){
       if (daysNow == 2 || daysNow == 1|| daysNow == 0){
         return 1; // so 3 is invalid
       }else{
         return 0; //meaning all good
       }
     }else{
       return 0;
     }

  }



  ///Checks if all fields were filled
  ///if not then button can't be selected
  ///0 - all empty
  ///1 - mane empty
  ///2 - days not set
  ///3 - amount not set
  ///4 = all set
  int checkAll(){
   if (_nameCard == null && _dayCount == null && _money == null){
     return 0;
   }
   else if (_nameCard == null){
     return 1;
   }else if (_dayCount == null){
     return 2;
   }else if (_money == null){
     return 3;
   }else{
     return 4;
   }

  }




}