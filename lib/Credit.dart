import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallett/bank.dart';
import 'Transaction.dart';
import 'MainDrawer.dart';
import 'TransactionFunctions.dart';
import 'package:provider/provider.dart';

class Credit extends StatefulWidget {
  @override
  _CreditState createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  final myController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double amt;
  String description;
  Bank bank = new Bank();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFB0F6AE),
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
        backgroundColor: Color(0xFFB0F6AE),
      ),
      drawer: MainDrawer(
        color: Color(0xFFB0F6AE),
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
                      'Credit Money',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFEB127)),
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
                              color: Color(0xFFFEB127),
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
                              decoration:
                                  InputDecoration(hintText: 'Enter Amount'),
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
                        'Credit Source ',
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
                              decoration:
                                  InputDecoration(hintText: 'Eg - Gpay/Paytm'),
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
                        if (amt == null || description == null) {
                          print('empty');
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
                            isCredit: true);
                        addToBox(t);
                        bank.addMoney(amt);
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
                            'CREDIT',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF00FF22),
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
