import 'package:flutter/material.dart';
import 'package:subscribeversion2/AddCardScreen/AddCard.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';
import 'package:subscribeversion2/DataStorage/CardDetails.dart';
import 'package:subscribeversion2/DataStorage/storedData.dart';


import 'cardStack.dart';

    void main() {
      runApp(
          MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.white,canvasColor: Color.fromRGBO(72, 72, 72, 1)

            ),
            home: FrontPage(),
          )
      );
    }

storedData storage;//stored data class
List<CardDetails> list = new List();
ArrayOfCards a = new ArrayOfCards();
BuildContext buildContext;


class FrontPage extends StatefulWidget{// with WidgetsBindingObserver {
  @override
  _FrontPageState createState() => _FrontPageState();
}


class _FrontPageState extends State<FrontPage> with WidgetsBindingObserver{

  ///keep state track
  final myKey =   GlobalKey<FormState>();

/// calls the singleton class

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // add the observer to register the events
    WidgetsBinding.instance.addObserver(this);

    startDatabase();
  }

  @override///Listens when app changes its lifecycle
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
  //  super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed){// meaning the app resumed after dormant
      startDatabase();
    }else{
      //temporarily delete list so as not to add again
      a.removeAll();
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);//removes observer
    super.dispose();

  }
  void startDatabase() async{
    storage = storedData();
    await storage.initializeDatabase();



      list  = await storage.getData();
      setState(() {
         print("wtfff");
        a.addAll(list);

      //  print(a.seeCard(1).getDayCount());
      });

///make see card page and add oResume when app doing nara



  }



  @override
  Widget build(BuildContext context) {
    buildContext = context;

    return Scaffold(
      key: myKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.black,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right:30.0),
            child: IconButton(
              icon: Icon(Icons.filter_list),
              color: Colors.white,
              iconSize: 30,
              onPressed: (){},//go to settings page} ,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white,
              iconSize: 30,
              onPressed: (){}, // generate container with options
            ),
          )
        ],
      ),

      body:
          CustomScrollView(
            slivers: <Widget>[

             SliverFixedExtentList(
               delegate: SliverChildListDelegate(
                 [
              Stack(

              children: stackOfCards(a, context),
              )]
               ), itemExtent: 900,
             )
            ],
          ),



           
         

















      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add,color: Colors.white,size: 30,),
        splashColor: Colors.lime,
        onPressed: (){
          //  Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCard(null,-1, myKey)));


        },
      ),


    );
  }}
