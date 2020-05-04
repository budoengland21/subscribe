import 'package:flutter/material.dart';
import 'package:subscription/AddCardScreen/AddCard.dart';
import 'package:subscription/DataStorage/ArrayOfCards.dart';
import 'package:subscription/homePage/cardStack.dart';

    void main() {
      runApp(
          MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.black
            ),
            home: FrontPage(),
          )
      );
    }

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  ArrayOfCards a = new ArrayOfCards();
/// calls the singleton class


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
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
      Stack(
        children: stackOfCards(a)



      ),






      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add,color: Colors.white,size: 30,),
        splashColor: Colors.lime,
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCard()));
        },
      ),


    );
  }}
