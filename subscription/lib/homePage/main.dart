import 'package:flutter/material.dart';
import 'package:subscription/AddCardScreen/AddCard.dart';

    void main() => runApp(
      MaterialApp(
        theme: ThemeData(
         primaryColor: Colors.black
      ),
        home: FrontPage(),
      )
    );
class FrontPage extends StatelessWidget {
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

      body: Stack(
        children: <Widget>[
          Positioned(
            top:10,
            left:0,
            right: 0,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 10,
              color:Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40))
              ),

              child: Container(
                width: double.infinity,
                height: 200,

                child: Padding(
                  padding: EdgeInsets.only(top:10 ),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: Text("YOUTUBE 1234567", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 38),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:5,left: 3),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 60,
                              //color: Colors.red,
                              width: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/voucher.png"),
                                  fit: BoxFit.contain
                                )
                              ),


                            ),
                            Container(
                              height: 40,
                              width: 90,
                              child: Center(
                                child: Text(
                                  "29.99", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23,),
                                ),
                              ),
                            ),

                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right:4.0),
                              child: Container(
                                //color: Colors.pinkAccent,
                                height: 60,
                                width: 140,

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(40),),color: Colors.red,
                                  //boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 1,blurRadius: 2)]
                                ),
                                child: Center(child: Text("3 DAYS",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)),
                              ),
                            )
                          ],
                        ),
                      )
                    ],

                  ),
                ),
              ),

            ),
          ),
          Positioned(
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
          ),
        ],
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
