import 'package:hive/hive.dart';

part 'Transaction.g.dart';

@HiveType(typeId: 0)
class TransactionClass {
  @HiveField(0)
  double amount;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isCredit;

  TransactionClass({this.amount, this.description, this.isCredit});
}
