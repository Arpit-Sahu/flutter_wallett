import 'package:flutter/material.dart';
import 'package:wallett/Transaction.dart';
import 'package:wallett/bank.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'MainDrawer.dart';
import 'package:draggable_home/draggable_home.dart';

class DragableHome extends StatefulWidget {
  @override
  _DragableHomeState createState() => _DragableHomeState();
}

class _DragableHomeState extends State<DragableHome> {
  Box<TransactionClass> transactionBox =
      Hive.box<TransactionClass>("Transactions");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFFBF1EB),
//        appBar: AppBar(
//          iconTheme: IconThemeData(
//            color: Color(0xFF707070),
//          ),
//          elevation: 0,
//          title: Text(
//            'Dashboard',
//            style: TextStyle(
//              fontSize: 26,
//              fontWeight: FontWeight.w500,
//              color: Color(0xFFFEB127),
//            ),
//          ),
//          backgroundColor: Color(0xFFFEE0C6),
//        ),
//        drawer: MainDrawer(
//          color: Color(0xFFFEE0C6),
//        ),
        body: DraggableHome(
          headerExpandedHeight: .5,
          backgroundColor: Color(0xFFFEE0C6),
          title: Text('Title'),
          headerWidget: headerWidget(),
          body: [
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transactions',
                            style: TextStyle(
                              fontSize: 25,
                              color: Color(0xFFF98A93),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Container(
                              height: 2,
                              color: Color(0xFFDF7C83),
                            ),
                          )
                        ],
                      ),
                      TextButton(
                        onPressed: null,
                        child: Container(
                          height: 28,
                          width: 78,
                          child: Center(
                            child: Text(
                              'View all',
                              style: TextStyle(
                                color: Color(0xFFF98A93),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFFBF1EB),
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                transactionBox.length == 0
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 100.0, right: 40, left: 40),
                        child: Center(
                          child: Text(
                            "No Transactions till now. Try adding money in the wallet",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF707070),
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        reverse: true,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          TransactionClass t = new TransactionClass();
                          t = transactionBox.getAt(index);
                          return Transaction(
                            description: t.description,
                            amount: t.amount,
                            isCredit: t.isCredit,
                          );
                        },
                        itemCount:
                            transactionBox.length //transactionsBox.length,
                        ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class headerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.red,
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              child: Center(
                child: Text(
                  '??? ' + Provider.of<Bank>(context).getBalance().toString(),
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFEB127),
                  ),
                ),
              ),
              height: 176.0,
              width: 342.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(51.0),
                color: Color(0xFFFEE0C6),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/expend');
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                          fontSize: 35,
                          color: Color(0xFFFF1700),
                        ),
                      ),
                    ),
                    width: 78,
                    height: 41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0x4DFF1700),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/credit');
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 35,
                          color: Color(0xFFFEB127),
                        ),
                      ),
                    ),
                    width: 78,
                    height: 41,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Color(0x4D00FF22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Transaction extends StatelessWidget {
  final String description;
  final double amount;
  final bool isCredit;
  Transaction({this.description, this.amount, this.isCredit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Container(
        width: 342,
        height: 68,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFFBF1EB),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: TextStyle(
                      color: Color(0xFFFEB127),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'On ' + getDate(),
                    style: TextStyle(
                      color: Color(0xFFFEB127),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                '???' + amount.toString(),
                style: TextStyle(
                  fontSize: 30,
                  color: isCredit ? Color(0xFF00FF22) : Color(0xFFFF1700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getDate() {
    DateTime now = new DateTime.now();
    //  DateTime date = new DateTime(now.year, now.month, now.day);
    return now.day.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.year.toString().substring(2, 4);
  }
}
