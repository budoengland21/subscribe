import 'dart:ui';

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

  Color defaultColor0 = Colors.black;
  Color defaultColor1 = Colors.black; ///default color of the dialog box
  Color defaultColor2 = Colors.black; ///default color of the dialog box
  Color defaultColor3 = Colors.black; ///default color of the dialog box
  Color defaultColor4 = Colors.black; ///default color of the dialog box

  bool isPressed = false;

  int filterOption = 0; ///change to 1 default later

/// calls the singleton class

  @override
  void initState() {
    // TODO: implement initState

    if (!this.widget.hasPassed){
      notificationData.initializePlugin();///initilizes notification based on what platform used
      print("DATABSE ACTIVATING----------------------");
      super.initState();
      // add the observer to register the events
      WidgetsBinding.instance.addObserver(this);

      startDatabase();
    }else{
      isPressed=false;
      defaultColor0=defaultColor3=defaultColor2=defaultColor1=defaultColor4=Colors.black;
    filterOption=0;
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



  Color checkPress(){
    if (isPressed){
      return Colors.white;
    }else{
      return  Colors.white.withOpacity(0.5);
    }
  }
 ///where the filter option
  Future<void> activateFilter() async {
    return await showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
            child:
                    StatefulBuilder(
                      builder: (context, setState){
                      return  AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                        backgroundColor: Colors.black,
                        elevation: 20,
                        title: Center(child: Text(
                          'Sort by', style: TextStyle(color: Colors.white),),),
                        content: SingleChildScrollView(
                          child: ListBody(
                            reverse: true,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                      setState((){
                                        isPressed = true;
                                        defaultColor0 = Color.fromRGBO(255, 241, 118, 1);
                                        defaultColor4 = Colors.black;
                                        defaultColor3 = Colors.black;
                                        defaultColor2 = Colors.black;
                                        defaultColor1 = Colors.black;
                                        filterOption = 1;
                                      });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: defaultColor0)
                                        ),
                                        child: Text('Recently added', style: TextStyle(color: Colors.white),)),
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Price', style: TextStyle(color: Colors.white),),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: defaultColor1)
                                        ),
                                        //      color: Colors.red,
                                        child: IconButton(
                                          splashColor: Colors.black,highlightColor: Colors.black,
                                          color: Colors.white,
                                          icon: Icon(Icons.keyboard_arrow_up),
                                          onPressed: () {
                                            setState((){
                                              isPressed=true;
                                              defaultColor0 = Colors.black;
                                              defaultColor4 = Colors.black;
                                              defaultColor3 = Colors.black;
                                              defaultColor2 = Colors.black;
                                              defaultColor1 = Color.fromRGBO(255, 241, 118, 1);
                                              filterOption=2;
                                              //priceUpList();

                                            });

                                          },
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: defaultColor2)
                                        ),
                                        child: IconButton(
                                          splashColor: Colors.black,highlightColor: Colors.black,
                                          color: Colors.white,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          onPressed: () {
                                            setState((){
                                              isPressed=true;
                                              defaultColor0 = Colors.black;
                                              defaultColor1 = Colors.black;
                                              defaultColor3 = Colors.black;
                                              defaultColor4 = Colors.black;
                                              defaultColor2 =
                                                  Color.fromRGBO(255, 241, 118, 1);
                                              filterOption = 3;
                                              //      priceDownList();
                                            });

                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        'Days', style: TextStyle(color: Colors.white),),
                                      Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: defaultColor3)
                                        ),
                                        child: IconButton(
                                          splashColor: Colors.black,highlightColor: Colors.black,
                                          color: Colors.white,
                                          icon: Icon(Icons.keyboard_arrow_up),
                                          onPressed: () {
                                            setState((){
                                              isPressed= true;
                                              defaultColor0 = Colors.black;
                                              defaultColor1 = Colors.black;
                                              defaultColor2 = Colors.black;
                                              defaultColor3 =
                                                  Color.fromRGBO(255, 241, 118, 1);
                                              defaultColor4 = Colors.black;
                                              filterOption = 4;
                                            });

                                          },
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: defaultColor4)
                                        ),
                                        child: IconButton(
                                          splashColor: Colors.black,highlightColor: Colors.black,
                                          color: Colors.white,
                                          icon: Icon(Icons.keyboard_arrow_down),
                                          onPressed: () {
                                            setState((){

                                              isPressed=true;
                                              defaultColor0 = Colors.black;
                                              defaultColor4 =
                                                  Color.fromRGBO(255, 241, 118, 1);
                                              defaultColor1 = Colors.black;
                                              defaultColor2 = Colors.black;
                                              defaultColor3 = Colors.black;
                                              filterOption = 5;
                                              //ZNavigator.pop(context);
                                            });

                                          },
                                        ),
                                      )
                                    ],
                                  ),

                                ],

                              )

                            ],
                          ),
                        ),
                        actions: <Widget>[
                         /* Center(
                            child: FlatButton(

                              child: Text("Cancel", style: TextStyle(
                                  color:Colors.white),),
                              onPressed: () {
                                Navigator.of(context).pop();


                              },
                            ),
                          ),
                          FlatButton(
                            child: Text('Done', style: TextStyle(
                                color: checkPress()),),
                            onPressed: () {
                              if (isPressed){
                                Navigator.of(context).pop();
                              }
                            },
                          ),*/

                        ],
                      );}
                      ),
                    );



        });


  }




@override
  Widget build(BuildContext context) {

    buildContext = context;
    print(filterOption);
    print("uppp");

    ///list of the tabs for their bodies
    final tabs = [
      pastCards(a, buildContext, filterOption),
      IncomingCards(a, buildContext,filterOption),
      UpcomingCards(a, buildContext, filterOption)
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

         Padding(
           padding: const EdgeInsets.all(10.0),
           child: RaisedButton(
             onPressed: (){ _openCupertinoCurrencyPicker();},
             color: Colors.black,
             child: Text('Currency: $currency', style: TextStyle(color: Color.fromRGBO(255, 241, 118, 1), fontSize: 17),),
           ),
         ),
          SizedBox(
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              color: Colors.black,
              icon: Icon(Icons.filter_list,color: Color.fromRGBO(255, 241, 118, 1),size: 27,),
              onPressed: () async{
                await activateFilter();
               setState(() {
                 ///allows to rebuild when done

                // activateFilter();
               });





              },

            ),
          ),

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
