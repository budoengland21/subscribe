




import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:flutter/services.dart';
import 'package:subscription/DataStorage/ArrayOfCards.dart';
import 'package:subscription/DataStorage/CardDetails.dart';


class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  //Controller to check if user changed a value in the text field box
  final TextEditingController textCheck = new TextEditingController();

  CardDetails cardDetails = new CardDetails();
  ArrayOfCards arrayOfCards = new ArrayOfCards();

  //Used to update the card real time as user types
  String tempName = '';
  String tempPay = '';
  String tempAmount = '';
  String tempDays = '';

  //color for payment containers
  Color selected = Colors.white;
  Color selected1 = Colors.white;
  Color selected2 = Colors.white;
  Color selected3 = Colors.white;

  //color for days selector
  Color days0 = Colors.white;
  Color days1 = Colors.white;
  Color days2 = Colors.white;
  Color days3 = Colors.white;
  Color days4 = Colors.white;

  bool checkOn = false; // for the color containers checker
  Color cardColor = Colors.black;

  var images = ["Debit", "Credit", "Gift card", "Paypal"];
  var png = [
    "images/debit.png",
    "images/credit.png",
    "images/voucher.png",
    "images/paypal.png"
  ];

  //used to check if switch is on
  bool isOn = false;
  bool renewOn = false;
  List<String> days = ["1 day", "3 days", "7 days"];
  String defaultDay = "3 days";

  ///storing dates, first time stores date first time entered
  String defaultDate = "Today";
  int customDate=-1 ;//store date
  DateTime customD;

  DateTime firstTime = DateTime.now();
  ///calculate what value goes to button, format date
  void formatDate(DateTime d){
    customD = d;
    if (d.month == DateTime.now().month && d.day == DateTime.now().day && d.year ==
    DateTime.now().year){
      defaultDate = "Today";
    }
    else{
      defaultDate = d.day.toString()+"-"+d.month.toString()+"-"+d.year.toString();
      firstTime = d;

    }

  }
  ///calculate date range
  void calculateDays(DateTime custom){
    int difference=0;
    int temp;
    bool first = false;
    ///if it is less and user presses begin cycle again
    if ((custom.year == firstTime.year) &&(custom.month < firstTime.month) ){

        difference=0;


    }
    else if (custom.year == firstTime.year){
      if (custom.month == firstTime.month){
        difference = custom.day - firstTime.day;
      }
      else{
      //  temp = custom.month - firstTime.month;
        difference = daysInMonths(custom.month, firstTime.month, custom.day, firstTime.day, custom.year);
        difference -=firstTime.day;


      }
    }///then the years are different
    else{
      for (int i = firstTime.year; i<=custom.year;i++){
        //check if now it is in same year

        if (custom.year == i){
          difference+=daysInMonths(custom.month, 1, custom.day, 1,i);//start from jan all the way
        }
        ///only runs once
       else if (first==false) {
          //calculate days in that year till december
          difference += daysInMonths(12, firstTime.month, 31, firstTime.day, firstTime.year);
          first=true;
        }
       ///calculate from jan to dec
       else{
         if (i%4==0){
           difference+=366;
         }else{difference+=365;}

        }

      }
      difference-=firstTime.day;
    }
    customDate = difference;
    if (difference ==0){
      tempDays = "";
      removeColor();
    }
    else {
      tempDays = difference.toString() + " DAYS";
    }
    //return difference;


  }
  //remove extra days
  int runOnce(int i, int x){
    return  (i-x);
  }
  ///calculate days in the same year
  ///try using .difference???????
  int daysInMonths(int hi, int lo, int hiDay, int loDay, int year){
    int difference=0;
    int hiMonth = hi;
    int lowMonth = lo;
    bool check = false;

    for (int i = hiMonth; i >= lowMonth; i--){

      if (i==1 || i == 3 || i == 5 || i == 7 || i==8 || i==10 || i==12){
        difference+=31;
        if (!check){
          difference -=runOnce(31, hiDay);
          check=true;
        }



        ///for february
      }else if (i == 2) {
        ///check if leap year
        if (year%4==0){
          difference+=29;
          if (!check){
            difference -=runOnce(29, hiDay);
            check=true;
          }

        }
        else{
          difference+=28;
          if (!check){
            difference -=runOnce(28, hiDay);
            check=true;
          }

        }

      }
      else{//the rest are 30 days
        difference+=30;
        if (!check){
          difference -=runOnce(30, hiDay);
          check=true;
        }

      }
    }
    print (difference);
    return difference;

  }



  //Reupdate card name as user types
  //takes in value of textedit controller


  void make() {
    //just using length of colorcontain just coz its same
    selected = Colors.greenAccent;
    selected1 = Colors.white;
    selected2 = Colors.white;
    selected3 = Colors.white;
  }

  void make1() {
    //just using length of colorcontain just coz its same
    selected1 = Colors.greenAccent;
    selected = Colors.white;
    selected2 = Colors.white;
    selected3 = Colors.white;
  }

  void make2() {
    //just using length of colorcontain just coz its same
    selected2 = Colors.greenAccent;
    selected = Colors.white;
    selected3 = Colors.white;
    selected1 = Colors.white;
  }

  void make3() {
    //just using length of colorcontain just coz its same
    selected3 = Colors.greenAccent;
    selected = Colors.white;
    selected1 = Colors.white;
    selected2 = Colors.white;
  }


  void colorDay() {
    days0 = Colors.greenAccent;
    days1 = Colors.white;
    days2 = Colors.white;
    days3 = Colors.white;
    days4 = Colors.white;
  }

  void colorDay1() {
    days0 = Colors.white;
    days1 = Colors.greenAccent;
    days2 = Colors.white;
    days3 = Colors.white;
    days4 = Colors.white;
  }

  void colorDay2() {
    days0 = Colors.white;
    days1 = Colors.white;
    days2 = Colors.greenAccent;
    days3 = Colors.white;
    days4 = Colors.white;
  }

  void colorDay3() {
    days0 = Colors.white;
    days1 = Colors.white;
    days2 = Colors.white;
    days3 = Colors.greenAccent;
    days4 = Colors.white;
  }
  void colorCustom(){
    days0 = Colors.white;
    days1 = Colors.white;
    days2 = Colors.white;
    days3 = Colors.white;
    days4 = Colors.greenAccent;

  }
  void removeColor(){
    days0 = Colors.white;
    days1 = Colors.white;
    days2 = Colors.white;
    days3 = Colors.white;
    days4 = Colors.white;
  }


  void updateColor(Color i) {
    cardDetails.setColor(i); //set the color
    cardColor = i;
  }


  void updateCardName(String val) {
    cardDetails.setNameCard(val);
    tempName = val;
  }

  //Update payment type real time
  void updatePaymentType(String val) {
    cardDetails.NamePayment(val);
    tempPay = val;
  }

  //Update money
  void updateMoney(String amount) {
    cardDetails.setMoney(amount);
    tempAmount = amount;
  }

  //update day count
  void updateDays(String val) {
    if (val == "null"){
   //   tempDays = val;
      customDate=-1;
      tempDays="";//RESET to one month
      removeColor();
    }
    else{
      tempDays=val;
    }
    cardDetails.setDayCount(val);



  }

  ///_________________________________________________________________________
  ///This will add the card to the home screen
  ///then it will add the card to an array
  void returnHome(){
    //print (arrayOfCards.seeCard(1));
    arrayOfCards.addCard(cardDetails);
    Navigator.of(context).pop();
  }
  //___________________________________________________________________________
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(


        slivers: <Widget>[


          SliverAppBar(
            backgroundColor: Colors.grey,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.done),
                color: Colors.black,
                iconSize: 30,
                onPressed: () {}, //go to settings page} ,
              ),
            ],
            //forceElevated: true,
            //floating: true,
            pinned: true,
            elevation: 10,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 30,),),
            // appBar:AppBar(leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,size: 30,),),)//leading: IconButton(icon:Icon(Icons.arrow_back,color: Colors.black,size: 30,),),

            // color that appear when scroll up
            expandedHeight: 250,
            //height of actual view

            flexibleSpace: FlexibleSpaceBar(

              background:
              Center(
                child: Card(

                  elevation: 60,
                  child: Container(
                    height: 150, width: (MediaQuery
                      .of(context)
                      .size
                      .width) - 100,
                    color: cardColor,
                    //CARD DETAILS REAL TIME UPDATE
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            //Payment image container
                            Container(

                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(tempPay),
                                    fit: BoxFit.contain
                                ),

                              ),
                              width: 60,
                              height: 60,
                            ),
                            SizedBox(
                              width: 10,
                            ),

                            // Text card container
                            Text(

                              tempName, style: TextStyle(fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 60,

                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                tempAmount, style: TextStyle(fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),

                            Text(
                              tempDays, style: TextStyle(fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),


                      ],
                    ),

                  ),
                ),
              ),
            ),
          ),


          //THIS IS WHERE WE PUT ALL THE CHILDREN_________________________________
          SliverFixedExtentList(
            itemExtent: 795, //height of each widget in the listdelegate
            //for my case since its one widget, make height reasonable size
            //divide the items
            delegate: SliverChildListDelegate(
                [
                  //Using card coz material needed for textbox
                  Card(


                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 5, right: 5),

                        child: Column(
                          children: <Widget>[
                            TextField(

                              decoration: InputDecoration(
                                labelText: "Subscription name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15)),),
                                prefixIcon: Icon(
                                  Icons.credit_card, color: Colors.black,),

                              ),
                              //Takes in a string variable
                              onChanged: (val) {
                                setState(() {
                                  updateCardName(val);
                                });
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(15),
                              ],
                              //no need for controller unless you want to use it
                              //controller: textCheck, // Obtain text from textbox


                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Row(
                                children: <Widget>[
                                  Text("Begin cycle: ",style: TextStyle(fontSize: 20),),
                                  Spacer(),
                                  RaisedButton(
                                    ///adding icon in button + name
                                    color: Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.calendar_today,color: Colors.black,),
                                        SizedBox(width: 10,),
                                        Text(defaultDate),
                                      ],
                                    ),
                                    onPressed: (){
                                      DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime.now(),
                                          maxTime: DateTime(DateTime.now().year+5),
                                       onConfirm: (val){///after done pressed
                                        print(val);
                                        setState(() {
                                          formatDate(val);///where it formats date
                                          updateDays("null");
                                          removeColor();
                                        });
                                       }, currentTime: DateTime.now(),locale: LocaleType.en


                                      );

                                    },
                                  )

                                ],
                              ),
                            ),
                            Padding(

                              padding: EdgeInsets.only(top:15),
                              child: Row(
                                children: <Widget>[
                                  Text("End Cycle",style: TextStyle(fontSize: 20),)
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                height: 90,
                                color: Colors.white,
                                width: double.infinity,

                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          updateDays("3 DAYS");
                                          colorDay();
                                        });
                                      },
                                      child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,

                                            children: <Widget>[
                                              Text("3", style: TextStyle(
                                                  fontSize: 40),),
                                              Text("DAYS", style: TextStyle(
                                                  fontSize: 20),),
                                            ],
                                          ),


                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              border: Border.all(width: 1.5),
                                              color: days0)

                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          updateDays("7 DAYS");
                                          colorDay1();
                                        });
                                      },
                                      child: Container(

                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,

                                            children: <Widget>[
                                              Text("7", style: TextStyle(
                                                  fontSize: 40),),
                                              Text("DAYS", style: TextStyle(
                                                  fontSize: 20),),
                                            ],

                                          ),


                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              border: Border.all(width: 1.5),
                                              color: days1)
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),

                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          updateDays("14 DAYS");
                                          colorDay2();
                                        });
                                      },
                                      child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,

                                            children: <Widget>[
                                              Text("14", style: TextStyle(
                                                  fontSize: 40),),
                                              Text("DAYS", style: TextStyle(
                                                  fontSize: 20),),
                                            ],
                                          ),


                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              border: Border.all(width: 1.5),
                                              color: days2)

                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          updateDays("1 MONTH");
                                          colorDay3();
                                        });
                                      },
                                      child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,

                                            children: <Widget>[
                                              Text("1", style: TextStyle(
                                                  fontSize: 40),),
                                              Text("MONTH", style: TextStyle(
                                                  fontSize: 20),),
                                            ],
                                          ),


                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius
                                                  .circular(30),
                                              border: Border.all(width: 1.5),
                                              color: days3)

                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),

                                    ///where the range of dates is made,bug user can select previous
                                    ///dates which shouldn't be allowed

                                    GestureDetector(
                                      onTap: () {

                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime.now(),
                                              maxTime: DateTime(DateTime.now().year+5),
                                              onConfirm: (val){///after done pressed
                                                print(val);
                                                setState(() { colorCustom();
                                                  calculateDays(val);

                                                 // formatDate(val);///where it formats date

                                                });
                                              }, currentTime: DateTime.now(),locale: LocaleType.en


                                          );


                                       /* final List<DateTime> picked = await DateRagePicker.showDatePicker(
                                            context: context,
                                            selectableDayPredicate: _func(2020, 1, 10),//DateTime(DateTime.now().year).difference(DateTime(DateTime.now().year)).inDays,

                                        initialFirstDate: new DateTime.now(),
                                            initialLastDate: (new DateTime.now()),
                                            //selectableDayPredicate: new DateTime.now(),
                                            firstDate: new DateTime (DateTime.now().year),//beginning year
                                            lastDate: new DateTime(DateTime.now().year + 5));
                                        if (picked != null && picked.length == 2) {
                                       //   print(picked[0].);
                                          print(picked);
                                        }*/
                                      },
                                    //getTime();},
                                      child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: <Widget>[

                                              Text("Custom", style: TextStyle(
                                                  fontSize: 20),),
                                            ],
                                          ),


                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                30),
                                            border: Border.all(width: 1.5),color: days4)

                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: colorContainers(),
                                ),
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Set Reminder",
                                    style: TextStyle(fontSize: 20),),
                                  Spacer(),
                                  Switch(
                                      value: isOn,
                                      onChanged: (
                                          checker) { // onchanged takes parameter of whats changed
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
                                    value: defaultDay,
                                    // default is 3 days
                                    onChanged: (newvalue) {
                                      setState(() {
                                        FocusScope.of(context).requestFocus(
                                            new FocusNode());

                                        ///it will clear all focus of the textfield

                                        defaultDay = newvalue;
                                      });
                                    },
                                    //items takes in values(days) and puts them in list for dropdown
                                    items: days.map<DropdownMenuItem<String>>((
                                        String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }


                                    ).toList(),

                                  )
                                ],
                              ),
                            ),
                            //HORIZONTAL RULER
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Container(
                                height: 0.3, color: Colors.black,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Payment Type",
                                    style: TextStyle(fontSize: 20),),
                                ],

                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 70,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          make();
                                          updatePaymentType(png[0]);
                                        });
                                      },
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                30),
                                            border: Border.all(width: 1.5),
                                            color: selected)
                                        ,
                                        child: Center(child: Text(images[0],
                                          style: TextStyle(fontSize: 20),)),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          make1();
                                          updatePaymentType(png[1]);
                                        });
                                      },
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                30),
                                            border: Border.all(width: 1.5),
                                            color: selected1)
                                        ,
                                        child: Center(child: Text(images[1],
                                          style: TextStyle(fontSize: 20),)),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          make2();
                                          updatePaymentType(png[2]);
                                        });
                                      },
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                30),
                                            border: Border.all(width: 1.5),
                                            color: selected2)
                                        ,
                                        child: Center(child: Text(images[2],
                                          style: TextStyle(fontSize: 20),)),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          make3();
                                          updatePaymentType(png[3]);
                                        });
                                      },
                                      child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                30),
                                            border: Border.all(width: 1.5),
                                            color: selected3)
                                        ,
                                        child: Center(child: Text(images[3],
                                          style: TextStyle(fontSize: 20),)),
                                      ),
                                    ),

                                    SizedBox(
                                      width: 15,
                                    )


                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                height: 0.3, color: Colors.black,),
                            ),


                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Row(
                                children: <Widget>[
                                  Text("AutoRenew",
                                    style: TextStyle(fontSize: 20),),
                                  Spacer(),
                                  Switch(
                                      value: renewOn,
                                      onChanged: (
                                          val) { // onchanged takes parameter of whats changed
                                        setState(() {
                                          renewOn = val;
                                          // openDrawer(isOn);
                                        });
                                      }
                                  ),

                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Container(
                                height: 0.3, color: Colors.black,),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: <Widget>[
                                //Text("Amount", style: TextStyle(fontSize: 20),),
                                // Spacer(),
                                Text("Amount", style: TextStyle(fontSize: 20),),
                                Spacer(),
                                Container(


                                  // color: Colors.black,
                                  width: 120,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.attach_money,
                                        color: Colors.green,),
                                      //border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),),
                                      //block digits with comma, hyphen etc.
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      BlacklistingTextInputFormatter(
                                          RegExp('[,|-]|[(.)?]|[ ]')),
                                      //WhitelistingTextInputFormatter.digitsOnly],

                                    ],
                                    onChanged: (val) { //takes parameter
                                      setState(() {
                                        updateMoney(val);
                                      });
                                    },),
                                )


                              ],
                            ),


                            //Button to add the card

                            Spacer(),

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: RaisedButton(
                                  disabledColor: Colors.black12,
                                  color: Colors.black,
                                  onPressed: (){
                                    //if true, then all fields were filled
                                    if (cardDetails.checkAll()){
                                      ///go to home screen add card
                                      returnHome();


                                    }
                                  },
                                  child:Center(child: Text("Add Card",
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.white))) ,
                                ),
                              ),
                            )
                          ],

                        )


                    ),),


                ]
            ),

          ),


        ],


      ),


    );
  }


  List<Widget> colorContainers() {
    var colorLst = [
      Colors.purple,
      Colors.pink,
      Colors.brown,
      Colors.lightGreen,
      Colors.teal,
      Colors.blue,
      Colors.yellowAccent,
      Colors.orange,
      Colors.cyanAccent
    ];
    List<Widget> containers = [];
    for (int i = 0; i < colorLst.length; i++) {
      containers.add(
          GestureDetector(
            onTap: () {
              setState(() {
                updateColor(colorLst[i]);
              });
            },
            child: Container(
              width: 45,
//                            //color: Colors.teal,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: colorLst[i]),
            ),
          )
      );
      containers.add(SizedBox(width: 10,));
    }
    return containers;
  }


  bool _func(DateTime day) {
    if ((day.isAfter(DateTime(2020, 1, 5)) &&
        day.isBefore(DateTime(2020, 1, 9)))) {
      return true;
    }

    if ((day.isAfter(DateTime(2020, 1, 10)) &&
        day.isBefore(DateTime(2020, 1, 15)))) {
      return true;
    }
    if ((day.isAfter(DateTime(2020, 2, 5)) &&
        day.isBefore(DateTime(2020, 2, 17)))) {
      return true;
    }

    return false;
  }
}