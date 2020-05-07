
import 'package:flutter/material.dart';
import 'package:subscription/DataStorage/storedData.dart';

class CardDetails{
// _ (private fields for attributes)
  String _nameCard;
  String _dayCount;
  Color _color;
  bool _reminder;
  int _reminderDays;
  String _namePayment;
  bool _renew;
  String _money;

  bool _track; // check if all fields are filled

  CardDetails(){
    _color = Colors.white;_reminder=false;
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

  int getReminderDays() => _reminderDays;
  void setReminderDays(int value) {
    _reminderDays = value;
  }

  bool getReminder() => _reminder;
  void setReminder(bool value) {
    _reminder = value;
  }

  Color getColor() => _color;
  void  setColor(Color value) {
    _color = value;
  }

  String getDayCount() => _dayCount;
 void setDayCount(String value) {
//    var x = value.split(" ")[0];//first index ie number
//    if (int.parse(x) == 1){
//      _dayCount ="Today";
//    }
//    else{
//
//    }
    _dayCount = value;
  }

  String getNameCard() {
    return _nameCard;
  }
   void setNameCard(String value) {
    _nameCard = value;
  }

  ///Checks if all fields were filled
  ///if not then button can't be selected
  bool checkAll(){
    if ((_nameCard!=null) && (_dayCount!=null) && (_color!= Colors.white) &&
        (_namePayment!=null) && (_money!=null) ){
      //also insert into database
     // insertDatabase();

      return true;
    }else{
      return false;
    }
  }




}