



import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  //used to check if switch is on
  bool isOn = false;
  bool renewOn =false;
  List<String> days= ["1 day", "3 days", "7 days", "Custom"];
  String defaultDay = "3 days";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(


         slivers: <Widget>[



         SliverAppBar(
          backgroundColor: Colors.grey,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              color: Colors.black,
              iconSize: 30,
              onPressed: (){},//go to settings page} ,
            ),
          ],
          //forceElevated: true,
          //floating: true,
          pinned: true,elevation: 10,
          leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,size: 30,),),
          // appBar:AppBar(leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,size: 30,),),)//leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,size: 30,),),

          // color that appear when scroll up
          expandedHeight: 250,//height of actual view

          flexibleSpace: FlexibleSpaceBar(

            background:
            Center(
              child: Card(

                elevation: 20,
                child: Container(
                  height: 150, width: (MediaQuery.of(context).size.width)-100,
                  color:Colors.black,
                  //CARD DETAILS REAL TIME UPDATE
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(

                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("images/credit.png"),
                                  fit: BoxFit.contain
                              ),

                            ),
                            width: 60,
                            height: 60,
                          ),
                          SizedBox(
                            width:10,
                          ),

                          Text(
                            "YouTube12345", style: TextStyle(fontSize: 25,color:Colors.white,fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60,

                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text(
                              "\$25 ",style: TextStyle(fontSize: 22,color:Colors.white,fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),

                          Text(
                            "25 DAYS",style: TextStyle(fontSize: 22,color:Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),



                    ],
                  ),
                  //decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color: Colors.white)

                ),
                // height: 150,
                //width: (MediaQuery.of(context).size.width)-100,
                //color: Colors.white,
                //,
              ),
            ),
          ),
        ),
        //THIS IS WHERE WE PUT ALL THE CHILDREN
        SliverFixedExtentList(
          itemExtent: 650,//height of each widget in the listdelegate
          //for my case since its one widget, make height reasonable size
          //divide the items
          delegate: SliverChildListDelegate(
              [
                //Using card coz material needed for textbox
                Card(


                  child:Padding(
                      padding: const EdgeInsets.only(top:18.0, left:10,right: 10),

                      child: Column(
                        children: <Widget>[
                          TextField(

                            decoration: InputDecoration(
                              labelText: "Subscription name",border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
                              prefixIcon: Icon(Icons.credit_card,color: Colors.black,),

                            ),controller: null, // Obtain text from textbox


                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:15.0),
                            child: Container(
                              height: 90,
                              color: Colors.white,
                              width: double.infinity,

                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: <Widget>[
                                            Text("1",style: TextStyle(fontSize: 40),),
                                            Text("DAY",style: TextStyle(fontSize: 20),),
                                          ],
                                        ),


                                        width: 100,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(width: 1.5),)

                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Container(

                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: <Widget>[
                                            Text("3",style: TextStyle(fontSize: 40),),
                                            Text("DAYS",style: TextStyle(fontSize: 20),),
                                          ],

                                        ),



                                        width: 100,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(width: 1.5),)
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),

                                  GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: <Widget>[
                                            Text("7",style: TextStyle(fontSize: 40),),
                                            Text("DAYS",style: TextStyle(fontSize: 20),),
                                          ],
                                        ),


                                        width: 100,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(width: 1.5),)

                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: <Widget>[
                                            Text("1",style: TextStyle(fontSize: 40),),
                                            Text("MONTH",style: TextStyle(fontSize: 20),),
                                          ],
                                        ),


                                        width: 100,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(width: 1.5),)

                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),


                                  GestureDetector(
                                    onTap: (){}, //getTime();},
                                    child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[

                                            Text("Custom",style: TextStyle(fontSize: 20),),
                                          ],
                                        ),


                                        width: 100,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(width: 1.5),)

                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:12.0),
                            child: Container(
                              width: double.infinity,
                              height: 45,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children:colorContainers(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:12.0),
                            child: Row(
                              children: <Widget>[
                                Text("Set Reminder", style: TextStyle(fontSize: 20),),
                                Spacer(),
                                Switch(
                                    value: isOn,
                                    onChanged:(checker) { // onchanged takes parameter of whats changed
                                      setState(() {
                                        isOn = checker;
                                        // openDrawer(isOn);
                                      });
                                    }
                                ),

                              ],
                            ),
                          ),
                          Visibility(
                            visible: isOn,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Remind me", style: TextStyle(fontSize: 20),
                                ),
                                Spacer(),
                                DropdownButton(
                                  value: defaultDay,// default is 3 days
                                  onChanged: (newvalue){
                                    setState(() {
                                      FocusScope.of(context).requestFocus(new FocusNode());///It will clear all focus of the textfield

                                      defaultDay = newvalue;


                                    });
                                  },
                                  //items takes in values(days) and puts them in list for dropdown
                                  items: days.map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem<String>(
                                      value:value,
                                      child:Text(value),
                                    );
                                  }


                                  ).toList(),

                                )],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:12.0),
                            child: Row(
                              children: <Widget>[
                                Text("Payment Type", style: TextStyle(fontSize: 20),),
                              ],

                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 70,
                            child: Padding(
                              padding: const EdgeInsets.only(top:14.0),
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: paymentContainers(),
                              ),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(top:12.0),
                            child: Row(
                              children: <Widget>[
                                Text("AutoRenew", style: TextStyle(fontSize: 20),),
                                Spacer(),
                                Switch(
                                    value: renewOn,
                                    onChanged:(val) { // onchanged takes parameter of whats changed
                                      setState(() {
                                        renewOn = val;
                                        // openDrawer(isOn);
                                      });
                                    }
                                ),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Text("Amount", style: TextStyle(fontSize: 20),),
                              Spacer(),



                            ],
                          ),
                        ],

                      )


                  ),),





              ]
          ) ,

        ),




      ],





    ),
      floatingActionButton: FloatingActionButton(

        elevation: 10,
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.done,color: Colors.white,size: 30,),
        splashColor: Colors.lime,
        onPressed: (){
          //Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCard()));
        },
      ),

    );

  }


  List<Widget> paymentContainers(){
    var images = ["Debit", "Credit","Gift card","Paypal"];
    List<Widget> containers = [];
    for (int i = 0; i<images.length;i++){
     // container.add(
       containers.add( Container(
         width: 120,
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(width: 1.5),)
         ,child: Center(child: Text(images[i], style: TextStyle(fontSize: 20),)),
       ));
       containers.add( SizedBox(
         width: 15,
       ));

    }
    return containers;

  }


  List<Widget> colorContainers(){

    var colorLst = [Colors.purple,Colors.pink,Colors.brown,Colors.lightGreen,Colors.teal,Colors.blue,Colors.yellowAccent, Colors.orange,Colors.cyanAccent];
    List<Widget> containers=[];
    for (int i=0; i<colorLst.length;i++){
      containers.add(
          GestureDetector(
            child: Container(
              width: 45,
//                            //color: Colors.teal,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)),color: colorLst[i]),
            ),
          )
      );
      containers.add(SizedBox(width: 10,));

    }
    return containers;
  }
/*Future getTime() async {
    final List<DateTime> picked = await
        initialFirstDate: new DateTime.now(),
        initialLastDate: (new DateTime.now()).add(new Duration(days: 7)),
        firstDate: new DateTime(2015)
        context: context,,
        lastDate: new DateTime(2020)
    );*/

}

