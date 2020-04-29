class CardDetails{
// _ (private fields for attributes)
  String _nameCard;
  String _namePayment;
  int _dayCount;
  int _money;


  CardDetails(this._nameCard,this._namePayment,this._dayCount,this._money);

  int get money => _money;
  int get dayCount => _dayCount;
  String get namePayment => _namePayment;
  String get nameCard => _nameCard;



}