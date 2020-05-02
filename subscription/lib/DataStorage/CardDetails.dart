
import 'package:flutter/material.dart';

class CardDetails{
// _ (private fields for attributes)
  String _nameCard;
  int _dayCount;
  Color _color;
  bool _reminder;
  int _reminderDays;
  String _namePayment;
  bool _renew;
  int _money;

  bool _track; // check if all fields are filled

  CardDetails(){
    _color = Colors.white;_reminder=false;_dayCount=0;
   _renew=false;_money=-1;
  }

  int get money => _money;
   void setMoney(int value) {
    _money = value;
  }

  bool get renew => _renew;
  void setRenew(bool value) {
    _renew = value;
  }

  String get namePayment => _namePayment;
  void NamePayment(String value) {
    _namePayment = value;
  }

  int get reminderDays => _reminderDays;
  void setReminderDays(int value) {
    _reminderDays = value;
  }

  bool get reminder => _reminder;
  void setReminder(bool value) {
    _reminder = value;
  }

  Color get color => _color;
  void  setColor(Color value) {
    _color = value;
  }

  int get dayCount => _dayCount;
  void setdayCount(int value) {
    _dayCount = value;
  }

  String get nameCard {
    return _nameCard;
  }
   void setNameCard(String value) {
    _nameCard = value;
  }

  ///Checks if all fields were filled
  ///if not then button can't be selected
  bool checkAll(){
    if ((_nameCard!=null) && (_dayCount!=0) && (_color!= Colors.white) &&
        (_namePayment!=null) && (_money!=-1) ){
      return true;
    }else{
      return false;
    }
  }


}