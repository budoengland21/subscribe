




import 'dart:ui';
import 'package:intl/intl.dart'; /// for datetime

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:flutter/services.dart';
import 'package:subscribeversion2/DataStorage/ArrayOfCards.dart';
import 'package:subscribeversion2/DataStorage/CardDetails.dart';
import 'package:subscribeversion2/DataStorage/storedData.dart';
import 'package:subscribeversion2/homePage/main.dart';
import 'package:subscribeversion2/notificationData.dart';




// ignore: must_be_immutable
class AddCard extends StatefulWidget {

   CardDetails accessCard;
   int cardIndex;//index of card




  AddCard(this.accessCard, this.cardIndex);///used to determine if being updated or not
   @override
  _AddCardState createState() => _AddCardState();


}


class _AddCardState extends State<AddCard> {
  BuildContext saveContext;
  //Controller to check if user changed a value in the text field box
  String oldName = "";
  // endVal= DateTime.now();
  String customText = "Custom";
  bool customTapped = false; // check if custom button tapped
   final TextEditingController textCheck = new TextEditingController(); //track of the name of subscription
   final TextEditingController amountController = new TextEditingController();//keep track of amount

  int storageIndex=-1; ///used as channel id for notifications

  final  TextEditingController daySelector = new TextEditingController(); // keep track of custom days selected


  int daysToStart = 0; ///stores ow many days it takes to start

   CardDetails tempState = new CardDetails(); ///saves a temp state of the card
  ///error fields for checking fields
  //booleaan c;
  Color nameError =  Colors.white;
  bool daysError = false;
  Color amountError = Colors.white;

  bool trackr = false; // determine if amount pressed for first time
  String goodAmount=""; // regex remover

  int storeAns; //keeps track of the days if user presses renew on/off to set state;
  bool inCycle = false; //determine if it was in a cycle and re activate the days by storeAns

  bool errorCheck = false; // used to check if remainder days valid

  int diff = -1; //calculate the difference between days for cycle
  int customDiff; // calculate difference between custom cycle
  int storeCycleDays = -1; ///keeps track of cycle days for dialog box to pop an error if needed
  bool cycleDialog = false;
  bool cycleNum = false;
  bool userCancel = false; /// checks if cancelled
  /// for the dialog boxes

  bool statusCheck; /// used for determing if upcoming for updates
  bool notStarted=false; // check if cycle has started
  //textCheck =
  CardDetails cardDetails = new CardDetails();
  ArrayOfCards arrayOfCards = new ArrayOfCards();

  double op = 0.9; /// determines opacity of button

  bool keyboardState; /// store the state of the keyboard
  int reduceFuture =0;  ///store value for the future cards

  bool isExpired = false; ///determine when renew on if expired
  @protected
  void initState(){
    super.initState();


   /* keyboardState = KeyboardVisibilityNotification().isKeyboardVisible;
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible){
       keyboardState = visible;

      }
    );*/
  }


  ///the min date for custom
  DateTime minDate(){
    int yr = DateTime.now().year;
    int month = DateTime.now().month;

    int day = firstTime.day+7;
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
  //check the remainder days if auto renew off
  bool validity = false;

  //used to check if switch is on
  bool isOn = false;
  bool renewOn = true;
  List<String> days = ["Same day","1 day", "3 days", "Custom"];
  String defaultDay = "1 day";
  bool remainderTouched= false; ///check if reminder days touched, if not, remdays=1

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
      defaultDate = DateFormat.yMMMd().format(d);
      //defaultDate = d.day.toString()+"-"+d.month.toString()+"-"+d.year.toString();
      firstTime = d;

    }
    //set the date for subscription, if updating, it will also change it


  }
  ///calculate date range for custom set days

  void calculateD(DateTime custom){
     customDiff = custom.difference(firstTime).inDays;


     int val;
    if (firstTime.day == DateTime.now().day){
      customDiff+=1;
      updateDays(customDiff.toString(),true);


      ///when cycle hasn't started
    }else if(firstTime.isAfter(DateTime.now())){
     // customDiff+=1; //fix one day bug
   //   daysToStart = firstTime.day - DateTime.now().day; ///  stores when the cycle starts
      val = customDiff;
      print("val of cycle not started: $val");
      notStarted = true;
      print("WTFFFFFFFFFFFFFFFFFFFFF");
      ///set to option not started to put in appropiate list

      //




      updateDays(val.toString(), true);

      ///when the begin cycle is before today date
    }else{
      val = custom.day - DateTime.now().day;
      print("val of cycle before: $val");
      updateDays(val.toString(),true);
      notStarted=false;


    }
  //  storeCycleDays = customDiff;
     cardDetails.setCycleDays(customDiff);
     print('customCycle $customDiff'); /// we store this in the database , this is the custom cycle


  }
// calculate days for 7 days, 3 months but not for custom
  void calculateCycleDays(int val){
    print('val---$val');
    diff = (DateTime.now().difference(firstTime).inDays);

    int ans;

    if ((firstTime.day == DateTime.now().day || firstTime.isAfter(DateTime.now()))  ){// check if beginng cycle is equal or ahead
      print('yes5');
      if (firstTime.day == DateTime.now().day ){ // if equal then just make days equal
        ans = val;
        print('yes1');
      }else{
        //to fix one day bug
        //then it's one day, due to date bug
        //print('else 1 $diff');
        ans = val;
        diff = diff.abs();
        diff+=1;
        print("starts in: $diff");
        reduceFuture = diff;

        notStarted= true;
      }


    }
    else if (diff <= val && !inCycle ){
      print('p');
      ans = val - diff;

    }
    ///open if statement to check if reminder on
    if (diff > val || inCycle){
      print('yes2');
      int rem = diff % val;
      print(renewOn);
      if (rem == 0){//hence no remainder, then it's 2day
        ans = 0;
      }else{//find the remainder, then set the cycle days, all assuming repeat on
        print('lol $renewOn');
         if (renewOn){
           ans = val-rem;
           inCycle = true;




         }else{//user didn't set renew, so its expired
           ans = -1;
           inCycle = false;


         }
      }

    }

    cardDetails.setCycleDays(val); /// we store this in the database , this is the regular cycle
    updateDays(ans.toString(),false);
  }

  //Reupdate card name as user types
  //takes in value of textedit controller


  void make() {
    //just using length of colorcontain just coz its same255,241,118
    selected = Color.fromRGBO(255, 241, 118, 0.8);
    selected1 = Color.fromRGBO(72, 72, 72, 1);
    selected2 = Color.fromRGBO(72, 72, 72, 1);
    selected3 = Color.fromRGBO(72, 72, 72, 1);
  }

  void make1() {
    //just using length of colorcontain just coz its same
    selected1 = Color.fromRGBO(255, 241, 118, 0.8);
    selected = Color.fromRGBO(72, 72, 72, 1);
    selected2 = Color.fromRGBO(72, 72, 72, 1);
    selected3 = Color.fromRGBO(72, 72, 72, 1);
  }

  void make2() {
    //just using length of colorcontain just coz its same
    selected2 =  Color.fromRGBO(255, 241, 118, 0.8);
    selected = Color.fromRGBO(72, 72, 72, 1);
    selected3 = Color.fromRGBO(72, 72, 72, 1);
    selected1 = Color.fromRGBO(72, 72, 72, 1);
  }

  void make3() {
    //just using length of colorcontain just coz its same
    selected3 = Color.fromRGBO(255, 241, 118, 0.8);
    selected = Color.fromRGBO(72, 72, 72, 1);
    selected1 = Color.fromRGBO(72, 72, 72, 1);
    selected2 = Color.fromRGBO(72, 72, 72, 1);
  }


  void colorDay() {
    days0 =  Color.fromRGBO(255, 241, 118, 0.8);
    days1 = Color.fromRGBO(72, 72, 72, 1);
    days2 = Color.fromRGBO(72, 72, 72, 1);
    days3 = Color.fromRGBO(72, 72, 72, 1);
    days4 = Color.fromRGBO(72, 72, 72, 1);
  }

  void colorDay1() {
    days0 = Color.fromRGBO(72, 72, 72, 1);
    days1 =  Color.fromRGBO(255, 241, 118, 0.8);
    days2 = Color.fromRGBO(72, 72, 72, 1);
    days3 = Color.fromRGBO(72, 72, 72, 1);;
    days4 = Color.fromRGBO(72, 72, 72, 1);
  }

  void colorDay2() {
    days0 = Color.fromRGBO(72, 72, 72, 1);
    days1 = Color.fromRGBO(72, 72, 72, 1);
    days2 =  Color.fromRGBO(255, 241, 118, 0.8);
    days3 = Color.fromRGBO(72, 72, 72, 1);
    days4 = Color.fromRGBO(72, 72, 72, 1);
  }

  void colorDay3() {
    days0 =Color.fromRGBO(72, 72, 72, 1);
    days1 = Color.fromRGBO(72, 72, 72, 1);
    days2 = Color.fromRGBO(72, 72, 72, 1);
    days3 =  Color.fromRGBO(255, 241, 118, 0.8);
    days4 = Color.fromRGBO(72, 72, 72, 1);
  }
  void colorCustom(){
    days0 =  Color.fromRGBO(72, 72, 72, 1);
    days1 =  Color.fromRGBO(72, 72, 72, 1);
    days2 =  Color.fromRGBO(72, 72, 72, 1);
    days3 = Color.fromRGBO(72, 72, 72, 1);
    days4 =  Color.fromRGBO(255, 241, 118, 0.8);

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
  void updateDays(String val, bool isCustom) {

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
      if (int.parse(val) == 1 && !notStarted){
        tempDays="DUE IN "+ val + " DAY";
        cardDetails.setDayColor(Color.fromRGBO(26, 255, 49, 1)); //set to green
        statusCheck=true;
        print("updating.....");

      }else if (int.parse(val) == 0){ // WHEN USER is updating and it's 0 days
        tempDays = "DUE TODAY";
        statusCheck = true;

        cardDetails.setDayColor(Color.fromRGBO(255, 0, 0, 1)); //set to red
      }else if(int.parse(val) == -1){
        tempDays = "EXPIRED";
        statusCheck = true;
        isExpired = true;

        cardDetails.setDayColor(Color.fromRGBO(255, 0, 0, 1)); //set to red
      }else if (notStarted){ //*NOT STARTED :
        tempDays="FUTURE: "+val + " DAY(S)";
        statusCheck = false;


        cardDetails.setDayColor(Color.fromRGBO(26, 255, 49, 1));//else set to green
      }
      else{
        tempDays="DUE IN "+val + " DAY(S)";
        statusCheck = true;

        cardDetails.setDayColor(Color.fromRGBO(26, 255, 49, 1));//else set to green
      }
      cardDetails.setDayCount(val);
      storeCycleDays = int.parse(val); /// stores the day for check dialog

     // tempDays=val;
    }




  }

  ///_________________________________________________________________________
  ///This will add the card to the home screen
  ///then it will add the card to an array
  void returnHome() async{
    // print (cardDetails.getNamePayment());

  ///Updates the current card
    if (updating) {

      ///CHECK IF REMINDER DAYS WAS CHANGED, THEN  REUPDATE THE NOTIFICATION
      ///
      ///
      cardDetails.setColor(cardColor);


      cardDetails.setFutureDays(reduceFuture);///set days reduce the future
      cardDetails.setRenew(renewOn);
      print(isOn);
      print('lopppppppppppppppp');
      cardDetails.setReminder(isOn);
     cardDetails.updateStatus(statusCheck); ///update status based on upcoming


     cardDetails.setDate(firstTime);
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

      cardDetails.setFutureDays(reduceFuture); ///set days reduce the future
      cardDetails.updateStatus(statusCheck);
      if (cardColor == Colors.grey) {
        cardDetails.setColor(cardColor);
      }
     // cardDetails.setCardId(cardIdValue+1);
      cardDetails.setRenew(renewOn);
      cardDetails.setReminder(isOn);
      print('whatttt');
      print(cardDetails.getReminder());
      print(cardDetails.getReminderDays());
      if (cardDetails.getReminder()){

        if (cardDetails.getReminderDays() == null){///hence it should default to 1 day
          cardDetails.setReminderDays(1);
        }
      }
      /// sets the date
      cardDetails.setDate(firstTime);
       print(cardDetails.getDayCount());
     arrayOfCards.addCard(cardDetails); //print('cardID: $cardIdValue');
     //  this.widget.key.currentState.build(context);

     //Navigator.push(context, MaterialPageRoute(builder: (context)=> FrontPage()));//
      insertDatabase();

      ///sets the sort id
      storedData storage = storedData();
      storageIndex= await storage.lastIndex(); ///this will be the future index either way
      if (storageIndex > 1){
        storageIndex+=1;///this will be the future index either way
      }

      //activateNotification(false);
      print("this is storageIndex $storageIndex");
      cardDetails.setSortId(storageIndex); ///reason of this is because
      ///don't want to wait for database to insert hence when sorting avoid null
      Navigator.pop(context);
    }


  }



  ///this displays the dialog box
  Future<void> dayPickerBox() async{
    return  await showDialog(context: context,
      barrierDismissible: false, //user cant exit unless press cancel or set
      builder: (BuildContext context) {
      // applies blur to the background
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
          child: StatefulBuilder(
            builder: (context, setState){
             return  AlertDialog(

              backgroundColor: Colors.black,
              title: Text('Set custom reminder',style: TextStyle(color:Colors.white),),

              content: SingleChildScrollView(
                child: ListBody( // makes list of items

               reverse: true,
                  children: <Widget>[
                    Column(
                      children: <Widget>[


                        Row(
                          children: <Widget>[
                            Text('Remind me',style: TextStyle(color:Colors.white),),
                            SizedBox(
                              width: 24,
                            ),
                            Container(
                              width: 44,
                              height: 30,
                              child: TextField(

                                decoration: InputDecoration(

                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(72, 72, 72, 1)),),
                                   //focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Color.fromRGBO(72, 72, 72, 1) ))
                                ),style: TextStyle(color: Colors.white,),

                                controller: daySelector,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  BlacklistingTextInputFormatter(
                                      RegExp('[,|-]|[ ]|[.]')),
                                  //WhitelistingTextInputFormatter.digitsOnly],

                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('(days before)',style: TextStyle(color:Colors.white),)


                          ],
                        ),//,
                        Visibility(
                          visible: cycleDialog,
                          child: Text("Please select an end date", style: TextStyle(color: Colors.red)),
                        ),
                        Visibility(
                          visible: cycleNum,
                          child: Text("Reminder should be in range of cycle",style: TextStyle(color: Colors.red),),
                        )

                      ],
                    )



                    //Text('Error')
                  ],
                ),

              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel',style:TextStyle(color:Color.fromRGBO(255, 241, 118, 1)),),
                  onPressed:(){
                    setState((){
                      userCancel = true;
                      cycleDialog = false;
                      cycleNum = false;
                      Navigator.of(context).pop();
                    });
                   // Navigator.of(context).pop();
                    //return 'null';
                  },
                ),
               // Spacer(),
                FlatButton(
                  child: Text('Set',style:TextStyle(color:Color.fromRGBO(255, 241, 118, 1))),
                  onPressed: () {
                    print(storeCycleDays);

                    if (storeCycleDays == -1){
                      setState(() {
                        userCancel = false;

                        cycleDialog = true;
                      });
                    }else if (int.parse(obtainDay()) == 0 || int.parse(obtainDay()) > storeCycleDays)
                      setState(() {
                        cycleNum = true;
                        userCancel=false;
                      });
                    else{
                      setState(() {
                        cycleDialog = false;
                        cycleNum = false;
                        userCancel=false;
                        Navigator.of(context).pop();
                      });

                    }

                   // String val =  daySelector.text;
                   // return val;

                    //check cycle and show error
                  },
                )
              ]);
      } ),
        );
        });

    }



  String obtainDay() {
    return daySelector.text;
  }

  ///set the remainder
  void checkReminderDays(String remDays){
    if (isOn){

      if (!remainderTouched){
        remDays = days[1]; ///represents 1 day
      }
      int i= calculateRem(remDays);
      cardDetails.setReminderDays(i);
    }
    else{
      cardDetails.setReminderDays(135);///when it's off, just set reminder same day
    }
  }
  int calculateRem(String x){
    if (x == days[0] || x == null){
      return 135; /// meaning same day
    }
    else if (x== days[1]){
      return 1;
    }else if (x==days[2] ){
      return 3;


    }else{
      print(x);
    //  return 0;
      return int.parse(daySelector.text); // thus it is custom
    }
  }


///insert into database
  void insertDatabase() async{

    storedData storage = storedData();

    await activateNotification(false);

    storage.insertDb(cardDetails);

   // storageIndex= await storage.getIndex(cardDetails.getNameCard());

  }
  ///this activates the notification
  Future<void> activateNotification(bool changed) async {
    bool repeatAgain = false;
    NotificationData notificationData = new NotificationData();
    if (changed){ ///meaning it was updated, cancel the original reminder and recreate another one
     // notificationData.cancelNotification(storageIndex);
      notificationData.deleteAll(cardDetails.getNameCard());
    }
    ///check if user turned off the reminder
    if (isOn){
      int daysRem = int.parse(cardDetails.getDayCount());
      int r = cardDetails.getReminderDays();
      double paid= double.parse(cardDetails.getMoney());
      int Cycle = cardDetails.getCycleDays();
      int daysNotify = 0; ///duration of days added

      if (isOn){///check if reminder was on
        if (r == 135){ ///meaning reminder was to same day
          daysNotify = daysRem; ///so notification turns on that day
        }
        else if (daysRem <= r ){ ///if less then remainder passed, so reminder set to now
          daysNotify = 0; ///no days added

        }else{
          daysNotify = daysRem - r; ///amount of days to set duration

        }if (reduceFuture > 0){

          daysNotify+=reduceFuture; ///add amount of days since it's a future
        }
        ///CHECK IF RENEW ON, TO SCHEDULE PERIODICALLY
        if(renewOn){
          repeatAgain = true;
        }
        await notificationData.showNotification( cardDetails.getNameCard(),paid, daysNotify,repeatAgain,Cycle,r, daysRem);


      }
    } cardDetails.setLastDate(notificationData.getLast()); ///stores the last notification date
    ///else if it's off then notifications were deleted

  }


  void updateDatabase(String val) async{
    storedData storage = storedData();
  //  cardDetails.setNameCard("kkk");

  //  storageIndex= await storage.getIndex(cardDetails.getNameCard());
    await activateNotification(true);
    storage.updateRow(cardDetails, val);
  }

  Future<bool> undoChanges() async{
    arrayOfCards.removeAll();
   //  arrayOfCards.replaceCard(this.widget.cardIndex, tempState);//
    storedData st = storedData();
    await st.initializeDatabase();
   List  list  = await st.getData();
   arrayOfCards.addAll(list);


     print(tempState.getNamePayment());
    print("look if ");
    Navigator.pop(saveContext); ///so it can go back to view card and remove any update
    //Navigator.pop(context);

    return true;
  }
  ///Builder
  ///______________________________________________________________________________________________________________________________________________________________________________________________________________________________________
  @override
  Widget build(BuildContext context) {
    saveContext = context;
    //Since default color is black
   // cardDetails.setColor(Colors.black); //set the color
/// This is what user sees when card is being updated
      if (this.widget.accessCard != null){
        //tempState = this.widget.accessCard;///stores the state incase press back

        setState(() {
          updating = true;
          cardDetails = this.widget.accessCard; /// code added, simplifes setting things, test so cycle option must be included in cardDetails
         // CardDetails temp = this.widget.accessCard;
          oldName = cardDetails.getNameCard(); //used for updating

          //set the text in controller
          textCheck.text = oldName;
          amountController.text = cardDetails.getMoney();

          updateCardName(cardDetails.getNameCard());
        //  textCheck = temp.getNameCard();
          updateDays(cardDetails.getDayCount(),false);
          updateColor(cardDetails.getColor());
          updatePaymentType(cardDetails.getNamePayment());
          if (cardDetails.getNamePayment() == "images/debit.png"){
            make();}else if (cardDetails.getNamePayment() == "images/paypal.png"){make3();}///nothing
          else if (cardDetails.getNamePayment()== "images/credit.png"){make1();}else{make2();}//else{make3();}
          isOn = cardDetails.getReminder();
          if (isOn){
            remainderTouched=true; ///so it doesn;t give it  a default
            print('REMBDER DAYS');
            print(cardDetails.getReminderDays());
          //  cardDetails.setReminder(isOn);
            if (cardDetails.getReminderDays() == 1){
              defaultDay = cardDetails.getReminderDays().toString()+" day";
              checkReminderDays(cardDetails.getReminderDays().toString() + " day");

            }else{
              /// Add the custom day to the list
              if (cardDetails.getReminderDays() == 1 ||
                  cardDetails.getReminderDays()== 3 ||
                  cardDetails.getReminderDays() == 135){
                ///testing

              }else{
                days.add(cardDetails.getReminderDays().toString()+ " days");
                daySelector.text = cardDetails.getReminderDays().toString();
              }
              ///for same day
              if (cardDetails.getReminderDays() == 135){
                defaultDay = "Same day";
                checkReminderDays(days[0]);
              }
              else{
                defaultDay = cardDetails.getReminderDays().toString()+" days";
                checkReminderDays(cardDetails.getReminderDays().toString()+ " days");
              }



             }
          }else{
            cardDetails.setReminderDays(0);
          }
          int cyc = cardDetails.getCycleDays();
          if (cyc == 7){
            colorDay();

          //  customTapped = false;
          }else if (cyc == 14){
            colorDay1();

        //    storeAns=14;  customTapped = false; calculateCycleDays(storeAns); inCycle=false;
          }else if (cyc == 30){
            colorDay2();
          // storeAns=30;  customTapped = false; calculateCycleDays(storeAns);inCycle=false;
          }else if (cyc == 90){
            colorDay3();
            //storeAns=90;  customTapped = false; calculateCycleDays(storeAns);inCycle=false;
          }else{
            //customText = cyc.toString() + "days";
            customTapped = true;
            //daysError = false;
            colorCustom();
          }
          print(cardDetails.getStatus());
          statusCheck = cardDetails.getStatus();

          print('STATUS-----> $statusCheck');
          reduceFuture = cardDetails.getFuture();

          renewOn = cardDetails.getRenew();
          updateMoney(cardDetails.getMoney());
          storeCycleDays = int.parse(cardDetails.getDayCount());

          //format begin cycle for user to see
          formatDate(cardDetails.getDate());




          //clear it
         //  cardDetails = temp;// gives access to colors and anything it has
          print('data------');
          print(cardDetails.getNameCard());
//          print(cardDetails.getCardId());
          print(cardDetails.getDayColor());
          print('data-------');

          this.widget.accessCard = null;
          //arrayOfCards.removeCard(this.widget.cardIndex);
        });
      }



    return WillPopScope(

      onWillPop:
        undoChanges,
      child: Scaffold(
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
                icon: Icon(Icons.arrow_back, color: Color.fromRGBO(255, 241, 118, 1), size: 35,),
                onPressed: () {undoChanges();},),
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
                     color: cardColor.withOpacity(0.8),
                      //CARD DETAILS REAL TIME UPDATE
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              //Payment image container
                              //
                              obtainPay(),

                              SizedBox(
                                width: 10,
                              ),

                              // Text card container
                              Expanded(
                                child: Text(

                                  tempName, style: TextStyle(fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                ),
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
                                  tempAmount, style: TextStyle(fontSize: 21,
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
              itemExtent: 868, //height of each widget in the listdelegate
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
                                  //  errorBorder:OutlineInputBorder(borderSide: BorderSide(color: nameError)),
                                    focusColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15)),borderSide: BorderSide(color: nameError),),
                                    prefixIcon: Icon(
                                      Icons.credit_card, color: Colors.white,),

                                  ),

                                  //Takes in a string variable
                                  onChanged: (val) {
                                 //   val = checkInputText(val);
                                    setState(() {
                                      if (cardDetails.checkAll() ==4){
                                        op = 1;
                                      }
                                      updateCardName(val);
                                      amountError = Colors.white;

                                    });
                                  },maxLength: 12,
                                //  keyboardType: TextInputType.text,
                                  inputFormatters: [// LengthLimitingTextInputFormatter(12),


                                    //WhitelistingTextInputFormatter.digitsOnly],

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
                                            updateDays("null",false);
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
                                    Text("End Cycle After:",style: TextStyle(fontSize: 20,color: Colors.white),),
                                    SizedBox(
                                      width: 5,
                                    ),

                                    Text("*",style: TextStyle(color: Colors.grey, fontSize: 15),),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Visibility(
                                      visible: daysError,
                                      child: Text("Enter when cycle ends",style: TextStyle(color:Colors.red),),
                                    ),
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
                                            daysError = false;

                                            colorDay();
                                            storeAns=7;
                                            calculateCycleDays(7);
                                            ///for checking reminder
                                            if (cardDetails.getReminderDays()> storeCycleDays && validity){
                                              errorCheck=true;
                                            }else{
                                              errorCheck=false;
                                            }
                                            daysError = false;



                                          });
                                        },
                                        child: Container(

                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,


                                              children: <Widget>[
                                                Text("1", style: TextStyle(
                                                    fontSize: 40,color: Colors.white),),
                                                Text("WEEK", style: TextStyle(
                                                    fontSize: 20,color: Colors.white),),
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
                                            daysError = false;
                                            //print("SEE:$keyboardState");
                                            colorDay1();
                                            storeAns=14;
                                            calculateCycleDays(14);
                                            ///for checking reminder
                                            if (cardDetails.getReminderDays()> storeCycleDays  && validity){
                                              errorCheck=true;
                                            }else{
                                              errorCheck=false;
                                            }
                                            daysError = false;
                                          });
                                        },
                                        child: Container(

                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,

                                              children: <Widget>[
                                                Text("2", style: TextStyle(
                                                    fontSize: 40,color: Colors.white),),
                                                Text("WEEKS", style: TextStyle(
                                                    fontSize: 20,color: Colors.white),),
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
                                            daysError = false;
                                            calculateCycleDays(30);
                                            colorDay2();
                                            storeAns=30;

                                            ///for checking reminder
                                            ///validity if on set reminder on
                                            if (cardDetails.getReminderDays()> storeCycleDays && validity){
                                              errorCheck=true;
                                            }else{
                                              errorCheck=false;
                                            }
                                            daysError = false;

                                          });
                                        },
                                        child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,

                                              children: <Widget>[
                                                Text("1", style: TextStyle(
                                                    fontSize: 40,color: Colors.white),),
                                                Text("MONTH", style: TextStyle(
                                                    fontSize: 20,color: Colors.white),),
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

                                            daysError=false;
                                            calculateCycleDays(90);
                                            colorDay3();
                                            storeAns=90;
                                            ///for checking reminder
                                            if (cardDetails.getReminderDays()> storeCycleDays && validity){
                                              errorCheck=true;
                                            }else{
                                              errorCheck=false;
                                            }
                                            daysError = false;

                                          });
                                        },
                                        child: Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,

                                              children: <Widget>[
                                                Text("3", style: TextStyle(
                                                    fontSize: 40,color: Colors.white),),
                                                Text("MONTHS", style: TextStyle(
                                                    fontSize: 20,color: Colors.white),),
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

                                                 //   endVal = val; // changes value of custom text
                                                    colorCustom();
                                                    //calculateDays(val);
                                                    calculateD(val);
                                                    //updateDays(val)

                                                    ///for checking reminder
                                                    if (cardDetails.getReminderDays()> storeCycleDays){
                                                      errorCheck=true;
                                                    }else{
                                                      errorCheck=false;
                                                    }
                                                    daysError = false;

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
                                            print('pp $val');

                                            renewOn = val;
                                            if (renewOn){
                                              errorCheck = false; ///coz if renew on, then reminder all accepted
                                            }else{///incase turned off but days still greater
                                              if (storeCycleDays == -1){///nothing pressed
                                                errorCheck=false;
                                              }
                                              else if (cardDetails.getReminderDays()> storeCycleDays){
                                                errorCheck=true;
                                              }else{
                                                errorCheck=false;
                                              }

                                            }
                                            print('diff--- $diff');
                                         //  inCycle = val;
                                          if (!customTapped && diff != -1 ){ ///doesn't apply to custom
                                           print('wwwwwwwwwwwwwwwww');
                                            calculateCycleDays(storeAns);
                                          }



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
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("(Optional)",style: TextStyle(color: Colors.grey, fontSize: 15),),
                                    Spacer(),
                                    Switch(inactiveTrackColor:Color.fromRGBO(72, 72, 72, 1),activeColor:Color.fromRGBO(255, 241, 118, 1),
                                        value: isOn,
                                        onChanged: (
                                            checker) { // onchanged takes parameter of whats changed
                                          setState(() {
                                            if (isExpired){ //expired no need to set reminder
                                              isOn = checker;
                                            }else{
                                              isOn = checker;
                                            }

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
                                      elevation: 8,
                                      // default is 3 days
                                      onChanged: (newvalue) async  {


                                      if (newvalue == "Custom") {
                                        await dayPickerBox();
                                        if (userCancel){
                                          newvalue= days[0];
                                        }
                                      }else{

                                          validity = checkRemValid(newvalue);///check if remainder > than days,should be error



                                      }


                                        setState(()  {
                                          remainderTouched = true;
                                          FocusScope.of(context).requestFocus( ///it will clear all focus of the textfield
                                              new FocusNode());
                                          if (cardDetails.getNameCard()!=null){
                                            nameError = Colors.white;
                                          }

                                          errorCheck = false; // remove the error when user changing rem days

                                          if (newvalue == "Custom") {


                                            ///set up dialog box for user to access
                                            // String val =  dayPickerBox() as String;
                                            // await dayPickerBox() ;
                                            String s = obtainDay() + " days";
                                            //String s = st  " days";
                                            int i = int.parse(obtainDay());
                                            ///Check for duplicates
                                            if (i == 1 || i == 3){
                                              if (i == 1){
                                                checkReminderDays(i.toString() + " day");
                                                defaultDay = i.toString() + " day"; //since it already exists

                                              }
                                              else{
                                                checkReminderDays(s);
                                              defaultDay = i.toString() + " days"; //since it already exists
                                              }

                                            }
                                            ///Update the dropdown with custom value
                                            else{
                                              if (days.length > 4) {
                                                ///get rid of the custom days they previously selected
                                                days.removeLast();
                                                days.removeLast();
                                                days.add(s);
                                                days.add("Custom");
                                                checkReminderDays(s);
                                                defaultDay = days[3]; //add new days to dropdown

                                              }

                                              else{
                                                days.removeLast();
                                                days.add(s);
                                                days.add("Custom");
                                                checkReminderDays(s);
                                                  defaultDay = days[3];
                                              }

                                            }




                                            // days.insert(3, daySelector.text);
                                            print(days);

                                            /// This if it is not custom
                                          }


                                           else{
                                             ///disable selection for days that
                                            ///a reminder can't be set if passed
                                            ///this is when renew off but if on all days valid
                                        //    int checkr= cardDetails.checkRemDays(renewOn, daysNow)
                                            if (!renewOn){
                                              if (validity){
                                                errorCheck=false;
                                              }else{
                                                errorCheck= true;
                                              }
                                            }else{
                                              ///this is for those with renewal on
                                              checkReminderDays(newvalue);
                                            }




                                            defaultDay = newvalue;




                                          }

                                        });
                                      },
                                      //items takes in values(days) and puts them in list for dropdown
                                      items: days.map<DropdownMenuItem<String>>((
                                          String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,)//style: isDisabled(value),),//fn checks if day is invalid
                                        );
                                      }


                                      ).toList(),
                                    )
                                  ],
                                ),
                              ),
                              ///Error to show up if remainder days invalid
                              Visibility(
                                visible: errorCheck,
                                child: Row(
                                  children: <Widget>[
                                    Spacer(),
                                    Text('Day has passed',style: TextStyle(color:Colors.red),)
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
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("(Optional)",style: TextStyle(color: Colors.grey, fontSize: 15),)
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
                                  SizedBox(
                                    width: 5,
                                  ),

                                  Text("*",style: TextStyle(color: Colors.grey, fontSize: 15),),
                                  Spacer(),
                                  Container(


                                //    CHANGE BORDER STYLE
                                  //  CHANGE WHITE TO BLACK WHEN PRESSED


                                    // color: Colors.black,
                                    width: 150,
                                    child: TextField(

                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.attach_money,
                                          color: Colors.green,),
                                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: amountError),),
                                       // focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                                      //  errorBorder: OutlineInputBorder(borderSide: BorderSide(color: amountError))



                                        //block digits with comma, hyphen etc.
                                      ),style: TextStyle(color: Colors.white),
                                      controller: amountController,
                                      keyboardType: TextInputType.number, maxLength: 7,
                                      inputFormatters: [

                                        WhitelistingTextInputFormatter(
                                          RegExp('^[0-9]{1,5}(.)?[0-9]{0,2}')
                                        ),
                                        BlacklistingTextInputFormatter(
                                            RegExp('[,|-]|[ ]')),

                                      ],

                                      ///will be used to determine if first time clicked
                                      onSubmitted: (val){
                                        if (val.endsWith(".")){
                                          setState(() {
                                            amountController.text+="0";
                                            updateMoney(amountController.text);
                                            amountError= Colors.white;
                                          });

                                        }
                                      },


                                      onChanged: (val) { //takes parameter
                                           checkAmount(val);
                                        setState(() {
                                          amountError=Colors.white;

                                          nameError = Colors.white;

                                          if (cardDetails.checkAll() ==4 && amountController.text != ""){
                                            op = 1;
                                          }
                                          print(amountController.text);
                                          updateMoney(amountController.text);
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

                                    color: Color.fromRGBO(255, 241, 118, op),
                                    onPressed: (){
                                      //if true, then all fields were filled
                                     // int i = cardDetails.checkRemDays(renewOn, storeCycleDays);
                                      int x = cardDetails.checkAll();


                                      ///checks if everything is set
                                      if (x ==4 && (!errorCheck) && amountController.text != "" && amountError != Colors.red){
                                        ///go to home screen add card
                                      //  errorCheck = false;

                                        op = 1;
                                        print("CARD OPAYENT----");
                                          print(cardDetails.getNamePayment());

                                        returnHome();


                                      }
                                      //check if fields filled and show error
                                      else if(x == 1){
                                        //name is empty
                                        setState(() {
                                          nameError = Colors.red;

                                        });
                                      }else if(x == 2){ // days not set
                                        setState(() {
                                          daysError = true;
                                        });
                                      }else if (x == 3 || amountController.text == ""){// money not set
                                        setState(() {
                                          amountError = Colors.red;
                                        });
                                      }
                                      else if (errorCheck){
                                        ///then  remainder days is invalid
                                        ///set error
                                        setState(() {
                                          errorCheck = true;
                                        });

                                      }
                                      //else if (i == 0){//all fields empty

                                      //}
                                    },
                                    child:Center(child: Text("Save Subscription",
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
      Colors.lime,
      Colors.orange,
      Colors.cyan
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
                  color: colorLst[i].withOpacity(0.8)),
            ),
          )
      );
      containers.add(SizedBox(width: 10,));
    }
    return containers;
  }

  Column customContainer(){
    int x = cardDetails.getCycleDays();
    if (x==null){
      x=0;
    }
    if (customTapped){
      return
        Column(
          mainAxisAlignment: MainAxisAlignment
              .center,

          children: <Widget>[


            Text(x.toString(), style: TextStyle(
                fontSize: 40,color: Colors.white),),
             Text("DAYS", style: TextStyle(
            fontSize: 20,color: Colors.white),),



          ],
        );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment
          .center,
      children: <Widget>[

        Text(customText, style: TextStyle(
            fontSize: 20,color: Colors.white),),
      ],
    );
  }


  void checkAmount(String val) {


  if (amountController.text.startsWith("0")){
    amountController.text = amountController.text.substring(1,);
  }
  // String p = r'(^[1-9]{0,4}(.)?[0-9]{0,2}$)';

  //  RegExp regExp = new RegExp(p);
//    if (amountController.text.startsWith(".")||
//        amountController.text.startsWith(",")||
//        amountController.text.startsWith(" ")||
//        amountController.text.startsWith("-")){
//
//        amountController.text = amountController.text.substring(1,);
//
//
//
//    }
//    if (!regExp.hasMatch(val)){
//
//
//      print("NOT VALID");
//
//      amountController.text = amountController.text.substring(0,amountController.text.length-1);
//
//      //then it ends with dot
//    }
//    else{
//      goodAmount = val;
//      print ("ACCEPTED");
//    }
//
//  //  print("SEE:$keyboardState");
//
//   amountController.selection = TextSelection.fromPosition(
//       TextPosition(offset: amountController.text.length)
//   );

  }


  Container obtainPay(){
    print(tempPay);
    if (tempPay != ""){
      print("lopoooo");
      return
        Container(


          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(tempPay),
                fit: BoxFit.contain
            ),

          ),
          width: 60,
          height: 60,
        );
    }else{
      return
        Container(
          width: 60,
          height: 60,
        );
    }
  }

  ///check if the days can be allowed to be set a reminder
  ///a reminder will activate instantly when on that same day
  bool checkRemValid(String val){

    if (val == "1 day"){
      if (storeCycleDays >= 1){


        return true;
      }else{

        return false;
      }


    }else if (val == "3 days"){
      if (storeCycleDays >= 3){

        return true;
      }else{

        return false;
      }
    }else{


      return true;///assume user selected same day
    }
  }



/* String checkInputText(String s){
    String p = r'[a-zA-Z]+\d*';
    RegExp reg = new RegExp(p);
    if (reg.hasMatch(s)){
      //textCheck.text = s;
      return s;
    }else{
      textCheck.text = textCheck.text.substring(0, textCheck.text.length-1);
      return "";
   //   textCheck.text = "";
    }
 }*/




}