



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
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.white,size: 30,),),

      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            // color: Colors.red,
            child: Center(
              child: Container(

                height: 150,
                width: (MediaQuery.of(context).size.width)-100,
                //color: Colors.white,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color: Colors.grey),
              ),
            ),
          ),
          Expanded(

            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(80), topLeft: Radius.circular(80)),color: Colors.white),


              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:20.0,right: 20, top:50),

                    child: Column(
                      children: <Widget>[
                        TextField(

                          decoration: InputDecoration(
                            labelText: "Subscription name",border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
                            prefixIcon: Icon(Icons.credit_card,color: Colors.black,),

                          ),controller: null, // Obtain text from textbox


                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 90,
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
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 45,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children:colorContainers(),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                    //Reminder_____________________________________________________
                        Row(
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
                    SizedBox(
                      height:15,
                    ),


                    //Payment type    ________________________________________

                        Row(
                       children: <Widget>[
                         Text("Payment Type", style: TextStyle(fontSize: 20),),
                       ],

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
                     SizedBox(
                      height: 15,
                     ),


                    //renew button
                        Row(
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
                    ),


                  ),

                ],
              ),
            ),
          )
        ],
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

