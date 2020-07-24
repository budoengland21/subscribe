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

  DateTime calculateDuration(int daysToAdd){
    int sec = 0;

    if (daysToAdd ==0){
      sec =3;
    }

    var timeInt = DateTime.now().add(Duration(days: daysToAdd,hours:0, minutes: 0,seconds: sec));
    // timeInt
    timeInt = timeInt.toLocal();
    timeInt = new DateTime(timeInt.year,timeInt.month,timeInt.day,0,0,sec); // set for midnight
    return timeInt;

  }


  Future<void> showNotification(int channel, String sub, int amount, int daysToAdd,bool renew, int cycle,int remainder,int daysOnCard) async{


    var timeInt = calculateDuration(daysToAdd);

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'Channel ID', 'title', 'body', priority: Priority.High,importance: Importance.Max,
        ticker: 'test');

    ///FOR IOS notification info, if ios
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    ///Notification details for each platform
    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails,iosNotificationDetails);
    ///schedule periodically to repeat, for now we will set 6 requests
    ///plugin doesn't include intervals, worst case (1 week cycle - so 6 requests) and user never opens app within 6 wks
    ///if any issues, increase the number of request to 15-20
    ///requests will be checked when user opens up

    if (renew){
      ///create the notification for the first one
      ///code below calculates for the next cycle
      ///the rest: just add the cycle days
      print('first---> $timeInt');
      await _plugin.schedule(channel, '$sub', 'Reminder to pay \$ $amount',timeInt,notificationDetails);

      int period = daysToAdd;
      ///this is for reminders where reminder has passed but we create it now and for future cycles
      if (remainder == 135 && daysToAdd==0){ ///for same day, just add the cycle

         period+=cycle;

      }else if(daysToAdd == 0) {   ///calculate the cycle for days that notification has passed
        ///set a notification for now then we calculate days to the next notification
        ///and also the days on card will be less than the remainder that was set
        period = (cycle - (remainder - daysOnCard ));
      }else{
        ///daysToAdd > 0){=> then the duration of days is already calculated, and it hasn't passed the remainder
        ///so the daysToAdd += cycle to get the next cycle period notification
        period+=cycle;

      }


      ///cycle to find the rest of the next notifications
      ///to make every channel a dummy val
      ///channel range : 10xx -- (6 times)
      channel+=1000;
      for (int i=0; i<=5; i++){
        var repeat = calculateDuration(period);
        print('REPEAT---$repeat');
        await _plugin.schedule(channel, '$sub', 'Reminder to pay \$ $amount',repeat,notificationDetails);
        ///a new channel created and time, for another schedule
        channel+=1;
        period+=cycle;



      }
    }
    else{ ///when renew off, this is one time
      await _plugin.schedule(channel, '$sub', 'Reminder to pay \$ $amount',timeInt,notificationDetails); ///plugin for each platform shows this msg after line 63
    }


    print('Set for ----> $timeInt');
    print('created for channel $channel');


 //   pending();
    var x = await _plugin.pendingNotificationRequests();
    //print(x[0].id);
    print(x.length);
  }

  ///when notification is clicked on, and you want to do sth
  Future<void> onSelectNotifications(String payload) async{
    print("notification cancellller");
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
  // _plugin.cancelAll();

//    _plugin.cancelAll();
   // _plugin.
  }

  Future<List<PendingNotificationRequest>> getPending() async{
    var lst = await _plugin.pendingNotificationRequests();
    return lst;
  }


  void deleteAll(String cardName) async{
    List<PendingNotificationRequest> pending = await getPending();
    for (int x=0; x< pending.length;x++){
       print(pending[x].id);

       if (pending[x].title == cardName){ print("iop");
        print(pending[x].id);
        cancelNotification(pending[x].id);
      }
    }
  }





}


