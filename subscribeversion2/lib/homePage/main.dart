import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:subscribeversion2/AddCardScreen/AddCard.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';
import 'package:subscribeversion2/DataStorage/CardDetails.dart';
import 'package:subscribeversion2/DataStorage/storedData.dart';
import 'package:subscribeversion2/homePage/IncomingCards.dart';
import 'package:subscribeversion2/homePage/UpcomingCards.dart';
import 'package:subscribeversion2/homePage/pastCards.dart';
import '';




import 'cardStack.dart';

    void main() {
      runApp(
          MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.white,canvasColor: Color.fromRGBO(72, 72, 72, 1),


            ),
            home: FrontPage(false),
          )
      );
    }
///IF AN ERROR THEN IT HAS TO DO WITH THE THE NAVIGATION
///PASSING THROUGH MAIN CLASS--------------------------------------------------------
storedData storage;//stored data class
List<CardDetails> list = new List();
ArrayOfCards a = new ArrayOfCards();
BuildContext buildContext;


class FrontPage extends StatefulWidget{// with WidgetsBindingObserver {
  final bool hasPassed;
  //constructor
  FrontPage(this.hasPassed);

  @override
  _FrontPageState createState() => _FrontPageState();
}


class _FrontPageState extends State<FrontPage> with WidgetsBindingObserver{

  ///local notifications
  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidSettings;
  IOSInitializationSettings iosSettings;
  InitializationSettings initializationSettings;

  ///runs first time from the init state
  void initializePlugin() async{
    androidSettings = AndroidInitializationSettings('notify');
    iosSettings = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveIOS); ///triggers initializition for ios
    initializationSettings  = InitializationSettings(androidSettings,iosSettings); ///settings for each platform
    await plugin.initialize(initializationSettings,onSelectNotification: onSelectNotifications);///triggers notification and onSelect determines what it does when pressed
  }

  void showNotificationsAfterInterval() async{
    await notification();
  }

  Future<void> notification() async{
    var timeInt = DateTime.now().add(Duration(seconds: 10));
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'Channel ID', 'title', 'body', priority: Priority.High,importance: Importance.Max,
         ticker: 'test');
    
    ///FOR IOS notification info, if ios
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    
    ///Notification details for each platform
    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails,iosNotificationDetails);
    await plugin.schedule(2, 'hello', 'Dur 30',timeInt,notificationDetails); ///plugin for each platform shows this msg after line 63
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



  int current = 1; /// index of the tab

/// calls the singleton class

  @override
  void initState() {
    // TODO: implement initState
    initializePlugin();///initilizes notification based on what platform used
    if (!this.widget.hasPassed){
      print("DATABSE ACTIVATING----------------------");
      super.initState();
      // add the observer to register the events
      WidgetsBinding.instance.addObserver(this);

      startDatabase();
    }

  }

  @override///Listens when app changes its lifecycle
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
  //  super.didChangeAppLifecycleState(state);
    print('this is the state $state');
    if (state == AppLifecycleState.resumed){// meaning the app resumed after dormant
      startDatabase();
      print("RESUME");
    }else{
      //temporarily delete list so as not to add again
      a.removeAll();
    }
  }


/// get rid of observer that keep track if app is dormant
  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);//removes observer
    super.dispose();

  }
  ///Only runs once
  void startDatabase() async{
    storage = storedData();

    await storage.initializeDatabase();
  list  = await storage.getData();
      setState(() {
        a.addAll(list);

      //  print(a.seeCard(1).getDayCount());
      });

///make see card page and add oResume when app doing nara



  }
  




  @override
  Widget build(BuildContext context) {
    buildContext = context;

    ///list of the tabs for their bodies
    final tabs = [
      pastCards(a, buildContext),
      IncomingCards(a, buildContext),
      UpcomingCards(a, buildContext)
    ];
 //   FlutterStatusbarcolor.setStatusBarColor(Colors.green);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return Scaffold(

      backgroundColor: Colors.black12,
      appBar: 
      AppBar(
       // brightness: Brightness.light,
       elevation: 10,
       backgroundColor: Colors.black,
      /*  actions: <Widget>[

          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              iconSize: 30,
              onPressed: (){}, // generate container with options
            ),
          )
        ],*/
      ),

      body:
     tabs[current],
     bottomNavigationBar: BottomNavigationBar(
     currentIndex: current,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text('Past'),
          icon: Icon(Icons.ac_unit),

        ),
        BottomNavigationBarItem(
          title: Text('Incoming'),
          icon: Icon(Icons.access_alarm),

        ),
        BottomNavigationBarItem(
          title: Text('Upcoming'),
          icon: Icon(Icons.ac_unit),

        )

      ],
      onTap: (index){
        setState(() {
          current = index;
        });

      },),




      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add,color: Colors.white,size: 30,),
        splashColor: Colors.lime,
        onPressed: (){showNotificationsAfterInterval();
          //  Navigator.pop(context);
          /*  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCard(null,-1))).then((value){
              setState(() {});///rebuild state after
            });*/


        },
      ),


    );
  }}
