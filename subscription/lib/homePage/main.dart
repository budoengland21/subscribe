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

class FrontPage extends StatelessWidget {
  ArrayOfCards a = new ArrayOfCards();/// calls the singleton class
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

         /** Positioned(
            top:150,
            left:0,
            right: 0,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 10,
              color:Colors.blueGrey,


              child: Container(

                width: double.infinity,
                // color: Colors.blue,
                height: 80,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/price.png"),fit: BoxFit.contain,
                        )


                      ),
                    ),
                    Container(
                      width: 120,
                      child: Center(child: Text("\$439990",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 23),))
                    )
                  ],
                ),
              ),

            ),
          ),**/

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
  }
}
