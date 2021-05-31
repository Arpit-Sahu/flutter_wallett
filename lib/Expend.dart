import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallett/MainDrawer.dart';
import 'package:wallett/bank.dart';
import 'Transaction.dart';
import 'MainDrawer.dart';
import 'package:wallett/TransactionFunctions.dart';
import 'package:provider/provider.dart';

class Expend extends StatefulWidget {
  @override
  _ExpendState createState() => _ExpendState();
}

class _ExpendState extends State<Expend> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double amt;
  String description;
  Bank bank = new Bank();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFDB0A4),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF707070),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.popAndPushNamed(context, '/profile');
            },
            child: Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(top: 5, bottom: 5, right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: Provider.of<Bank>(context).getImage() == null
                      ? AssetImage('images/wallett.jpg')
                      : FileImage(Provider.of<Bank>(context).getImage()),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Color(0xFFFDB0A4),
      ),
      drawer: MainDrawer(
        color: Color(0xFFFDB0A4),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Expend Money',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFF1700)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF707070),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            '₹',
                            style: TextStyle(
                              color: Color(0xFFFF1700),
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                amt = double.parse(value);
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter Amount',
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expense made for ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF707070),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                description = value;
                              },
                              controller: myController,
                              maxLength: 16,
                              decoration: InputDecoration(
                                  hintText: 'Eg - Electric Bill'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (amt > bank.getBalance()) {
                          final snackBar = SnackBar(
                            content: Text(
                              'Not enough money in Wallet',
                              textAlign: TextAlign.center,
                            ),
                          );
                          ScaffoldMessenger.of(_scaffoldKey.currentContext)
                              .showSnackBar(snackBar);
                          return;
                        } else if (amt == null || description == null) {
                          final snackBar = SnackBar(
                            content: Text(
                              'One or more fields empty',
                              textAlign: TextAlign.center,
                            ),
                          );
                          ScaffoldMessenger.of(_scaffoldKey.currentContext)
                              .showSnackBar(snackBar);
                          return;
                        }
                        TransactionClass t = TransactionClass(
                            amount: amt,
                            description: description,
                            isCredit: false);
                        addToBox(t);
                        bank.subMoney(amt);
                        Navigator.popAndPushNamed(context, '/dashboard');
                      },
                      child: Container(
                        height: 68,
                        width: 342,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFFBF1EB),
                        ),
                        child: Center(
                          child: Text(
                            'EXPEND',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFFFF1700),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
