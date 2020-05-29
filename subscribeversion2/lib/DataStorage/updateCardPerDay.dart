// ignore: camel_case_types
///Singleton class that keeps track of the day
///when app first opened so as it updates the days on the
///database and to also send notifications
class dayChecker{

  static dayChecker checker;
  DateTime loggedDate;


  dayChecker.makeInstance(){
    loggedDate = DateTime.now();//stores the date when first time entered
  }

  factory dayChecker(){
    if (checker == null){
      checker = dayChecker.makeInstance();
    }return checker;
  }

}