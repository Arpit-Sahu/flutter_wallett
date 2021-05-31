import 'Transaction.dart';
import 'package:hive/hive.dart';

Box<TransactionClass> trans = Hive.box<TransactionClass>('Transactions');

void addToBox(TransactionClass t) {
  trans.put(getUniqueKey(), t);
  print(getUniqueKey());
}

String getUniqueKey() {
  DateTime now = new DateTime.now();
  String uid = now.day.toString() +
      "-" +
      now.month.toString() +
      "-" +
      now.year.toString() +
      "-" +
      now.hour.toString() +
      "-" +
      now.minute.toString() +
      "-" +
      now.second.toString() +
      "-" +
      now.millisecond.toString();
  return uid;
}

//List<TransactionClass> getDayWiseTransaction(int day, int month, int year) {
//  DateTime now = new DateTime.now();
//  List<TransactionClass> dayList = [];
//  for (int i = 0; i < trans.length; i++) {
//    if (trans.getAt(0).getUniqueKey().substring(0, 2) == now.day.toString()) {
//      dayList.add(trans.getAt(i));
//    }
//  }
//  print(dayList.length);
//  return dayList;
//}
