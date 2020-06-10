




import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:flutter/services.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';
import 'package:subscribeversion2/DataStorage/CardDetails.dart';
import 'package:subscribeversion2/DataStorage/storedData.dart';
import 'package:subscribeversion2/homePage/main.dart';




// ignore: must_be_immutable
class AddCard extends StatefulWidget {

   CardDetails accessCard;
   int cardIndex;//index of card

  AddCard(this.accessCard, this.cardIndex);///used to determine if being updated or not
   @override
  _AddCardState createState() => _AddCardState();


}

class _AddCardState extends State<AddCard> {
  //Controller to check if user changed a value in the text field box
  String oldName = "";
  DateTime endVal= DateTime.now();
  String customText = "Custom";
  bool customTapped = false; // check if custom button tapped
   final TextEditingController textCheck = new TextEditingController(); //track of the name of subscription
   final TextEditingController amountController = new TextEditingController();//keep track of amount
  int storeAns; //keeps track of the days if user presses renew on/off to set state;
  bool inCycle = false; //determine if it was in a cycle and re activate the days by storeAns

  int diff; //calculate the difference between days for cycle
  int customDiff; // calculate difference between custom cycle
  bool notStarted=false; // check if cycle has started
  //textCheck =
  CardDetails cardDetails = new CardDetails();
  ArrayOfCards arrayOfCards = new ArrayOfCards();
  DateTime minDate(){
    int yr = DateTime.now().year;
    int month = firstTime.month;

    int day = firstTime.day+1;
    return DateTime(yr,month,day);
  }



  bool updating = false;

  //Used to update the card real time as user types
  String tempName = '';
  String tempPay = '';
  String tempAmount = '';
  String tempDays = '';

  //color for payment containers
  Color selected= Color.fromRGBO(97, 97, 97, 1);
  Color selected1= Color.fromRGBO(97, 97, 97, 1);
  Color selected2= Color.fromRGBO(97, 97, 97, 1);
  Color selected3 = Color.fromRGBO(97, 97, 97, 1);
//color for days selector
  Color days0 = Color.fromRGBO(97, 97, 97, 1);
  Color days1 = Color.fromRGBO(97, 97, 97, 1);
  Color days2=Color.fromRGBO(97, 97, 97, 1);
  Color days3 = Color.fromRGBO(97, 97, 97, 1);
  Color days4= Color.fromRGBO(97, 97, 97, 1);


  bool checkOn = false; // for the color containers checker
  Color cardColor = Colors.grey;

  var images = ["Debit", "Credit", "Gift card", "Paypal"];
  var png = [
    "images/debit.png",
    "images/credit.png",
    "images/voucher.png",
    "images/paypal.png"
  ];

  //used to check if switch is on
  bool isOn = false;
  bool renewOn = true;
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

  void calculateD(DateTime custom){
     customDiff = custom.difference(firstTime).inDays;
    if (firstTime.day == DateTime.now().day){
      customDiff+=1;
    }
   updateDays(customDiff.toString());

  }
// calculate days for 7 days, 3 months but not for custom
  void calculateCycleDays(int val){
    diff = DateTime.now().difference(firstTime).inDays;
    int ans;
    //check if it was in a cycle and user changed renew option
    print("lokkkk $inCycle");

    if ((firstTime.day == DateTime.now().day || firstTime.isAfter(DateTime.now()))  ){// check if beginng cycle is equal or ahead
      print('yes5');
      if (firstTime.day == DateTime.now().day ){ // if equal then just make days equal
        ans = val;
        print('yes1');
      }else{
        ans=val;
        //but let user know it hasn't started
        notStarted= true;
      }


    }
    else if (diff < val && !inCycle ){
      print('p');
      ans = val - diff;

    }
    ///open if statement to check if reminder on
    if (diff > val){
      print('yes2');
      int rem = diff % val;
      if (rem == 0){//hence no remainder, then it's 2day
        ans = 0;
      }else{//find the remainder, then set the cycle days, all assuming repeat on
         if (renewOn){
           ans = val-rem;
           inCycle = true;




         }else{//user didn't set renew, so its expired
           ans = -1;


         }
      }

    }
     print(ans);
     updateDays(ans.toString());
  }

  //Reupdate card name as user types
  //takes in value of textedit controller


  void make() {
    //just using length of colorcontain just coz its same255,241,118
    selected = Color.fromRGBO(255, 241, 118, 1);
    selected1 = Color.fromRGBO(72, 72, 72, 1);
    selected2 = Color.fromRGBO(72, 72, 72, 1);
    selected3 = Color.fromRGBO(72, 72, 72, 1);
  }

  void make1() {
    //just using length of colorcontain just coz its same
    selected1 = Color.fromRGBO(255, 241, 118, 1);
    selected = Color.fromRGBO(72, 72, 72, 1);
    selected2 = Color.fromRGBO(72, 72, 72, 1);
    selected3 = Color.fromRGBO(72, 72, 72, 1);
  }

  void make2() {
    //just using length of colorcontain just coz its same
    selected2 =  Color.fromRGBO(255, 241, 118, 1);
    selected = Color.fromRGBO(72, 72, 72, 1);
    selected3 = Color.fromRGBO(72, 72, 72, 1);
    selected1 = Color.fromRGBO(72, 72, 72, 1);
  }

  void make3() {
    //just using length of colorcontain just coz its same
    selected3 = Color.fromRGBO(255, 241, 118, 1);
    selected = Color.fromRGBO(72, 72, 72, 1);
    selected1 = Color.fromRGBO(72, 72, 72, 1);
    selected2 = Color.fromRGBO(72, 72, 72, 1);
  }


  void colorDay() {
    days0 =  Color.fromRGBO(255, 241, 118, 1);
    days1 = Color.fromRGBO(72, 72, 72, 1);
    days2 = Color.fromRGBO(72, 72, 72, 1);
    days3 = Color.fromRGBO(72, 72, 72, 1);
    days4 = Color.fromRGBO(72, 72, 72, 1);
  }

  void colorDay1() {
    days0 = Color.fromRGBO(72, 72, 72, 1);
    days1 =  Color.fromRGBO(255, 241, 118, 1);
    days2 = Color.fromRGBO(72, 72, 72, 1);
    days3 = Color.fromRGBO(72, 72, 72, 1);;
    days4 = Color.fromRGBO(72, 72, 72, 1);
  }

  void colorDay2() {
    days0 = Color.fromRGBO(72, 72, 72, 1);
    days1 = Color.fromRGBO(72, 72, 72, 1);
    days2 =  Color.fromRGBO(255, 241, 118, 1);
    days3 = Color.fromRGBO(72, 72, 72, 1);
    days4 = Color.fromRGBO(72, 72, 72, 1);
  }

  void colorDay3() {
    days0 =Color.fromRGBO(72, 72, 72, 1);
    days1 = Color.fromRGBO(72, 72, 72, 1);
    days2 = Color.fromRGBO(72, 72, 72, 1);
    days3 =  Color.fromRGBO(255, 241, 118, 1);
    days4 = Color.fromRGBO(72, 72, 72, 1);
  }
  void colorCustom(){
    days0 =  Color.fromRGBO(72, 72, 72, 1);
    days1 =  Color.fromRGBO(72, 72, 72, 1);
    days2 =  Color.fromRGBO(72, 72, 72, 1);
    days3 = Color.fromRGBO(72, 72, 72, 1);
    days4 =  Color.fromRGBO(255, 241, 118, 1);

  }
  void removeColor(){
    days0 =  Color.fromRGBO(72, 72, 72, 1);
    days1 = Color.fromRGBO(72, 72, 72, 1);
    days2 =  Color.fromRGBO(72, 72, 72, 1);
    days3 =  Color.fromRGBO(72, 72, 72, 1);
    days4 =  Color.fromRGBO(72, 72, 72, 1);
  }


  void updateColor(Color i) {
    cardDetails.setColor(i); //set the color
    cardColor = i;
  }


  void updateCardName(String val) {

    cardDetails.setNameCard(val); //print("changed-->>>"+cardDetails.getNameCard());
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
    tempAmount = '\$ '+amount;
  }

  //update day count
  void updateDays(String val) {

    if (val == "null"){
   //   tempDays = val;
      print("HOWWWWWWW");
      customDate=-1;
      tempDays="";
      removeColor();
    }
    else{
      print("came thru---------");
      //set the card to display the days
      if (int.parse(val) == 1){
        tempDays="IN "+ val + " DAY";
        cardDetails.setDayColor(Color.fromRGBO(255, 0, 0, 1)); //set to red

        print("updating.....");

      }else if (int.parse(val) == 0){ // WHEN USER is updating and it's 0 days
        tempDays = "TODAY";
        cardDetails.setDayColor(Color.fromRGBO(255, 0, 0, 1)); //set to red
      }else if(int.parse(val) == -1){
        tempDays = "EXPIRED";
        cardDetails.setDayColor(Color.fromRGBO(255, 0, 0, 1)); //set to red
      }else if (notStarted){
        tempDays="STARTS IN "+val + " DAYS";
        cardDetails.setDayColor(Color.fromRGBO(26, 255, 49, 1));//else set to green
      }
      else{
        tempDays="IN "+val + " DAYS";
        cardDetails.setDayColor(Color.fromRGBO(26, 255, 49, 1));//else set to green
      }
      print("check----------------------------");
      print(cardDetails.getDayColor());
     cardDetails.setDayCount(val);
      

     // tempDays=val;
    }




  }

  ///_________________________________________________________________________
  ///This will add the card to the home screen
  ///then it will add the card to an array
  void returnHome() {
    // print (cardDetails.getNamePayment());

  ///Updates the current card
    if (updating) {
      cardDetails.setColor(cardColor);



      cardDetails.setRenew(renewOn);
     // arrayOfCards.updatePerformed();


      //Navigator.pop(context);
      //day color left at default


      updateDatabase(oldName);
      arrayOfCards.replaceCard(this.widget.cardIndex, cardDetails);//update the view
      Navigator.pop(context);//removes the add card
      Navigator.pop(context);//removes view card
      Navigator.pop(context); // REMOVE THE HOME ROUTE AND PUSH
     // this.widget.key.;
      //Pushes the home route
     Navigator.push(context, MaterialPageRoute(builder: (context)=> FrontPage(true)));

      updating=false;
      oldName = "";


    }
    ///Adds a new card
    // set the autorenew and remainder
    else {
      if (cardColor == Colors.grey) {
        cardDetails.setColor(cardColor);
      }
     // cardDetails.setCardId(cardIdValue+1);
      cardDetails.setRenew(renewOn);
      cardDetails.setReminder(isOn);

       print(cardDetails.getDayCount());
     arrayOfCards.addCard(cardDetails); //print('cardID: $cardIdValue');
     //  this.widget.key.currentState.build(context);

     //Navigator.push(context, MaterialPageRoute(builder: (context)=> FrontPage()));//
      insertDatabase();
      Navigator.pop(context);
    }


  }
  ///set the remainder
  void checkReminderDays(String remDays){
    if (renewOn){
      int i= calculateRem(remDays);
      cardDetails.setReminderDays(i);
    }
    else{
      cardDetails.setReminderDays(0);///dummy value
    }
  }
  int calculateRem(String x){
    if (x== days[0]){
      return 1;
    }else if (x==days[1]){
      return 3;
    }else{
      return 7;
    }
  }


///insert into database
  void insertDatabase(){
    storedData storage = storedData();
    storage.insertDb(cardDetails);
  }
  void updateDatabase(String val){
    storedData storage = storedData();
  //  cardDetails.setNameCard("kkk");
    storage.updateRow(cardDetails, val);
  }
  ///___________________________________________________________________________
  @override
  Widget build(BuildContext context) {
    //Since default color is black
   // cardDetails.setColor(Colors.black); //set the color

      if (this.widget.accessCard != null){
        setState(() {
          updating = true;
          CardDetails temp = this.widget.accessCard;
          oldName = temp.getNameCard(); //used for updating

          //set the text in controller
          textCheck.text = oldName;
          amountController.text = temp.getMoney();
          updateCardName(temp.getNameCard());
        //  textCheck = temp.getNameCard();
          updateDays(temp.getDayCount());
          updateColor(temp.getColor());
          updatePaymentType(temp.getNamePayment());
          if (temp.getNamePayment() == "Debit"){
            make();}else if (temp.getNamePayment()== "Credit"){make1();}else if (temp.getNamePayment() == "Gift card"){make3();}else{make2();}
          isOn = temp.getReminder();
          if (isOn){
            cardDetails.setReminder(isOn);
            if (temp.getReminderDays() == 1){
              defaultDay = temp.getReminderDays().toString()+" day";
            }else{
              defaultDay = temp.getReminderDays().toString()+" days";
          }
          }
          checkReminderDays(temp.getReminderDays().toString());
          renewOn = temp.getRenew();
          updateMoney(temp.getMoney());



          //clear it
           cardDetails = temp;// gives access to colors and anything it has
          print('data------');
          print(cardDetails.getNameCard());
//          print(cardDetails.getCardId());
          print(cardDetails.getDayColor());
          print('data-------');

          this.widget.accessCard = null;
          //arrayOfCards.removeCard(this.widget.cardIndex);
        });
      }



    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(


        slivers: <Widget>[


          SliverAppBar(
            backgroundColor: Color.fromRGBO(97, 97, 97, 1),

            //forceElevated: true,
            //floating: true,
            pinned: true,
            elevation: 10,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.greenAccent, size: 35,),
              onPressed: () {Navigator.pop(context);},),
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
            itemExtent: 860, //height of each widget in the listdelegate
            //for my case since its one widget, make height reasonable size
            //divide the items

            delegate: SliverChildListDelegate(
                [
                  //Using c
                  // ard coz material needed for textbox
                  Card(
                    color: Colors.black,//ytttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt


                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 5, right: 5),

                        child: Column(
                          children: <Widget>[
                            Theme(
                              data: Theme.of(context).copyWith(hintColor: Colors.white,primaryColor: Colors.white),

                              child: TextField(
                                style: TextStyle(color: Colors.white),


                                decoration: InputDecoration(
                                  labelText: "Subscription name",
                                  focusColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15)),borderSide: BorderSide(color: Colors.white),),
                                  prefixIcon: Icon(
                                    Icons.credit_card, color: Colors.white,),

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
                                controller: textCheck, // Obtain text from textbox


                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Row(
                                children: <Widget>[
                                  Text("Begin cycle: ",style: TextStyle(fontSize: 20,color: Colors.white),),
                                  Spacer(),
                                  RaisedButton(
                                    ///adding icon in button + name
                                    color: Color.fromRGBO(72, 72, 72, 1),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.calendar_today,color: Colors.white,),
                                        SizedBox(width: 10,),
                                        Text(defaultDate,style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                    onPressed: (){
                                      DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(DateTime.now().year - 1),
                                          maxTime: DateTime(DateTime.now().year+5),
                                       onConfirm: (val){///after done pressed
                                        print(val);
                                        setState(() {
                                          FocusScope.of(context).requestFocus( ///it will clear all focus of the textfield
                                              new FocusNode());
                                          formatDate(val);///where it formats date
                                          firstTime = val; ///update the date selected
                                          updateDays("null");
                                          notStarted = false; //reset again
                                          removeColor();
                                          inCycle = false; ///reset this so the cycle can be activated
                                        });
                                       }, currentTime: DateTime.now(),locale: LocaleType.en


                                      );

                                    },
                                  )

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),

                            ),

                            Padding(

                              padding: EdgeInsets.only(top:15),
                              child: Row(
                                children: <Widget>[
                                  Text("End Cycle After:",style: TextStyle(fontSize: 20,color: Colors.white),)
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                height: 90,
                                color: Colors.black,
                                width: double.infinity,

                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        customTapped = false;
                                        setState(() {

                                          colorDay();
                                          storeAns=7;
                                          calculateCycleDays(7);



                                        });
                                      },
                                      child: Container(

                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,


                                            children: <Widget>[
                                              Text("1", style: TextStyle(
                                                  fontSize: 40),),
                                              Text("WEEK", style: TextStyle(
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
                                        customTapped = false;
                                        setState(() {

                                          colorDay1();
                                          storeAns=14;
                                          calculateCycleDays(14);
                                        });
                                      },
                                      child: Container(

                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,

                                            children: <Widget>[
                                              Text("2", style: TextStyle(
                                                  fontSize: 40),),
                                              Text("WEEKS", style: TextStyle(
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
                                        customTapped = false;
                                        setState(() {
                                          calculateCycleDays(30);
                                          colorDay2();
                                          storeAns=30;

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
                                              color: days2)

                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        customTapped = false;
                                        setState(() {
                                          calculateCycleDays(90);
                                          colorDay3();
                                          storeAns=90;

                                        });
                                      },
                                      child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,

                                            children: <Widget>[
                                              Text("3", style: TextStyle(
                                                  fontSize: 40),),
                                              Text("MONTHS", style: TextStyle(
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
                                          customTapped = true;
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: minDate(),
                                              maxTime: DateTime(DateTime.now().year+5),
                                              onConfirm: (val){///after done pressed
                                                print(val);
                                                setState(() {
                                                  endVal = val; // changes value of custom text
                                                  colorCustom();
                                                  //calculateDays(val);
                                                  calculateD(val);
                                                  //updateDays(val)

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
                                          child: customContainer(),


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
                            ///Added the repeat cycle  option
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Repeat Cycle",
                                    style: TextStyle(fontSize: 20,color: Colors.white),),
                                  Spacer(),
                                  Switch(inactiveTrackColor:Color.fromRGBO(72, 72, 72, 1),activeColor:Color.fromRGBO(255, 241, 118, 1),
                                      value: renewOn,
                                      onChanged: (
                                          val) { // onchanged takes parameter of whats changed
                                        setState(() {
                                          renewOn = val;
                                        //  inCycle = true;

                                            calculateCycleDays(storeAns);


                                          // openDrawer(isOn);
                                        });
                                      }
                                  ),

                                ],
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                height: 3, color: Color.fromRGBO(72, 72, 72, 1),
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
                                    style: TextStyle(fontSize: 20,color: Colors.white),),
                                  Spacer(),
                                  Switch(inactiveTrackColor:Color.fromRGBO(72, 72, 72, 1),activeColor:Color.fromRGBO(255, 241, 118, 1),
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
                                    "Remind me", style: TextStyle(fontSize: 20,color: Colors.white),
                                  ),
                                  Spacer(),
                                  DropdownButton(iconEnabledColor: Color.fromRGBO(255, 241, 118, 1),
                                    value: defaultDay,style: TextStyle(color: Colors.white),
                                    // default is 3 days
                                    onChanged: (newvalue) {
                                      setState(() {
                                        FocusScope.of(context).requestFocus( ///it will clear all focus of the textfield
                                            new FocusNode());
                                        checkReminderDays(newvalue);




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
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                height: 3, color: Color.fromRGBO(72, 72, 72, 1),
                              ),
                            ),

                            ///HORIZONTAL RULER

                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Payment Type",
                                    style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],

                              ),
                            ),
                            Container(
                              color: Colors.black,
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
                                          style: TextStyle(fontSize: 20,color: Colors.white),)),
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
                                          style: TextStyle(fontSize: 20,color: Colors.white),)),
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
                                          style: TextStyle(fontSize: 20,color: Colors.white),)),
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
                                          style: TextStyle(fontSize: 20,color: Colors.white),)),
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
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Container(
                                height: 3, color: Color.fromRGBO(72, 72, 72, 1),
                              ),
                            ),





                           SizedBox(
                             height: 15,
                           ),
                            Row(
                              children: <Widget>[
                                //Text("Amount", style: TextStyle(fontSize: 20),),
                                // Spacer(),
                                Text("Amount", style: TextStyle(fontSize: 20,color: Colors.white),),
                                Spacer(),
                                Container(


                              //    CHANGE BORDER STYLE
                                //  CHANGE WHITE TO BLACK WHEN PRESSED


                                  // color: Colors.black,
                                  width: 120,
                                  child: TextField(

                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.attach_money,
                                        color: Colors.green,),
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),),
                                     // focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))



                                      //block digits with comma, hyphen etc.
                                    ),style: TextStyle(color: Colors.white),
                                    controller: amountController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      BlacklistingTextInputFormatter(
                                          RegExp('[,|-]|[ ]')),
                                      //WhitelistingTextInputFormatter.digitsOnly],

                                    ],
                                    onChanged: (val) { //takes parameter
                                      setState(() {
                                        updateMoney(val);
                                      });
                                    },),//decoration: BoxDecoration(border: Border(left:BorderSide.none,right:BorderSide.none,top:BorderSide.none,),borderRadius: BorderRadius.all(Radius.circular(9)),),
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
                                  elevation: 10,

                                  color: Color.fromRGBO(255, 241, 118, 1),
                                  onPressed: (){
                                    //if true, then all fields were filled
                                    if (cardDetails.checkAll()){
                                      ///go to home screen add card
                                      returnHome();


                                    }
                                  },
                                  child:Center(child: Text("Save Card",
                                      style: TextStyle(
                                          fontSize: 23, color: Colors.black))) ,
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

  Column customContainer(){
    if (updating || customTapped){
      return
        Column(
          mainAxisAlignment: MainAxisAlignment
              .center,

          children: <Widget>[

            Text(endVal.day.toString(), style: TextStyle(
                fontSize: 40),),
             Text(endVal.month.toString() + "/" + endVal.year.toString(), style: TextStyle(
            fontSize: 20),),



          ],
        );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment
          .center,
      children: <Widget>[

        Text(customText, style: TextStyle(
            fontSize: 20),),
      ],
    );
  }








}