import 'package:currency_pickers/country.dart';
import 'package:currency_pickers/currency_picker_dropdown.dart';
import 'package:currency_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:intl/intl.dart';
import 'package:subscribeversion2/AddCardScreen/AddCard.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';
import 'package:subscribeversion2/DataStorage/CardDetails.dart';
import 'package:subscribeversion2/DataStorage/currencyStorage.dart';
import 'package:subscribeversion2/DataStorage/storedData.dart';
import 'package:subscribeversion2/homePage/IncomingCards.dart';
import 'package:subscribeversion2/homePage/UpcomingCards.dart';
import 'package:subscribeversion2/homePage/pastCards.dart';
import '';
import 'package:currency_pickers/currency_pickers.dart';



import '../notificationData.dart';
import 'cardStack.dart';

    void main() {
      runApp(
          MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.white,canvasColor: Color.fromRGBO(72, 72, 72, 1),


            ),
            home: FrontPage(false),   debugShowCheckedModeBanner: false,
          )
      );
    }
///IF AN ERROR THEN IT HAS TO DO WITH THE THE NAVIGATION
///PASSING THROUGH MAIN CLASS--------------------------------------------------------
storedData storage;//stored data class
List<CardDetails> list = new List();
ArrayOfCards a = new ArrayOfCards();
BuildContext buildContext;
NotificationData notificationData = new NotificationData();

 String currency="";
currencyStorage currencyTrack; ///keeps the currency in the database

class FrontPage extends StatefulWidget{// with WidgetsBindingObserver {
  final bool hasPassed;
  //constructor
  FrontPage(this.hasPassed);
// notificationData = new NotificationData(); ///class for all the notification info




  @override
  _FrontPageState createState() => _FrontPageState();
}


class _FrontPageState extends State<FrontPage> with WidgetsBindingObserver{

  ///local notifications

  int current = 1; /// index of the tab

/// calls the singleton class

  @override
  void initState() {
    // TODO: implement initState
    notificationData.initializePlugin();///initilizes notification based on what platform used
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
    ///this is for the currency
    currencyTrack = currencyStorage();
    await currencyTrack.initializeDatabase();
    List  c = await (currencyTrack.getCurrency());
    if (c.length==0){
      currency = "\$";
    }else {
      print(c);
      currency = c[c.length-1];
    }
   ///this is previous card subscriptions
    storage = storedData();
    await storage.initializeDatabase();
  list  = await storage.getData();
      setState(() {
        a.addAll(list);

      //  print(a.seeCard(1).getDayCount());
      });

///make see card page and add oResume when app doing nara



  }


  void _openCupertinoCurrencyPicker() => showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CurrencyPickerCupertino(
          pickerSheetHeight: 300.0,
          onValuePicked: (Country country) =>
              setState(() {

              currency = NumberFormat.simpleCurrency(name: country.currencyCode).currencySymbol.toString();

              ///insert it into database
                currencyTrack = currencyStorage();
                print(currency);
                currencyTrack.insertCurrency(currency);
              }


        ));
      });

@override
  Widget build(BuildContext context) {

    buildContext = context;


    ///list of the tabs for their bodies
    final tabs = [
      pastCards(a, buildContext),
      IncomingCards(a, buildContext),
      UpcomingCards(a, buildContext)
    ];
    FlutterStatusbarcolor.setStatusBarColor(Colors.green);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return Scaffold(

      backgroundColor: Colors.black12,
      appBar: 
      AppBar(
       // brightness: Brightness.light,
       elevation: 10,
       backgroundColor: Colors.black,
        actions: <Widget>[

         RaisedButton(
           onPressed: (){ _openCupertinoCurrencyPicker();},
           color: Colors.black,
           child: Text('Currency: $currency', style: TextStyle(color: Color.fromRGBO(255, 241, 118, 1), fontSize: 16),),
         )
          ]),



      body:
     tabs[current],
     bottomNavigationBar: BottomNavigationBar(
       type: BottomNavigationBarType.shifting,
     showUnselectedLabels: true,

     currentIndex: current,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          backgroundColor: Colors.red,
          title: Text('Past'),
          icon: Icon(Icons.ac_unit),

        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.green,
          title: Text('Incoming'),
          icon: Icon(Icons.access_alarm),

        ),
        BottomNavigationBarItem(
          title: Text('Upcoming'),
          backgroundColor: Colors.blueGrey,
          icon: Icon(Icons.calendar_today),

        )

      ],
      onTap: (index){
        setState(() {
          current = index;
        });

      },),




      floatingActionButton: FloatingActionButton(
        elevation: 30,
        backgroundColor: Color.fromRGBO(255, 241, 118, 1),
        child: Icon(Icons.add,color: Colors.black,size: 30,),
        splashColor: Colors.lime,
        onPressed: (){//notification();
          //  Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCard(null,-1))).then((value){
              setState(() {});///rebuild state after
            });


        },
      ),


    );
  }}
