import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
///local notifications
///singleton class
class NotificationData{
  static NotificationData notificationData;///static so it creates once and determine if null when checked
  FlutterLocalNotificationsPlugin _plugin;
  AndroidInitializationSettings androidSettings;
  IOSInitializationSettings iosSettings;
  InitializationSettings initializationSettings;

  factory NotificationData(){
    if (notificationData == null){
      notificationData = NotificationData.createInstance(); ///if null,then it's first time, so create an object
    }
    return notificationData;
    //return plugin;
  }

  ///creates the plugin once unless app restarted
  NotificationData.createInstance(){
    _plugin = FlutterLocalNotificationsPlugin();
  }

  ///runs first time from the init state
  void initializePlugin() async{
    androidSettings = AndroidInitializationSettings('notify');
    iosSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveIOS); ///triggers initializition for ios
    initializationSettings  = InitializationSettings(androidSettings,iosSettings); ///settings for each platform
    await _plugin.initialize(initializationSettings,onSelectNotification: onSelectNotifications);///triggers notification and onSelect determines what it does when pressed
  }

/* void showNotificationsAfterInterval() async{
    await notification();
  }*/
  Future<void> showNotification(int channel, String sub, int amount, int daysToAdd) async{
    int sec = 0;

    if (daysToAdd ==0){
      sec =3;
    }

    var timeInt = DateTime.now().add(Duration(days: daysToAdd,hours:0, minutes: 0,seconds: sec));
   // timeInt
    timeInt = timeInt.toLocal();
    timeInt = new DateTime(timeInt.year,timeInt.month,timeInt.day,0,0,sec); // set for midnight

    print('Set for ----> $timeInt');
    print('created for channel $channel');
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'Channel ID', 'title', 'body', priority: Priority.High,importance: Importance.Max,
        ticker: 'test');

    ///FOR IOS notification info, if ios
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    ///Notification details for each platform
    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails,iosNotificationDetails);
    await _plugin.schedule(channel, '$sub', 'Reminder to pay \$ $amount',timeInt,notificationDetails); ///plugin for each platform shows this msg after line 63

  }

  ///when notification is clicked on, and you want to do sth
  Future<void> onSelectNotifications(String payload) async{
    if (payload != null){
      print(payload);
    }
    //  print(payload);

  }

  ///notification details for ios, for now not tested
  Future<void> onDidReceiveIOS(int id, String title,String body,String payload) async{
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: (){
            print("");
          },
          child: Text("Okay"),
        )
      ],
    );
  }

  void cancelNotification(int channel){
    print('deleted for channel $channel');
    _plugin.cancel(channel);
  }






}


