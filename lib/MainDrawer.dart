import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallett/bank.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  final Color color;
  MainDrawer({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: color,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
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
                  Text(
                    Provider.of<Bank>(context).getName() == null
                        ? ''
                        : Provider.of<Bank>(context).getName(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF707070),
                    ),
                  ),
                  Text(
                      Provider.of<Bank>(context).getEmail() == null
                          ? 'Please set up profile'
                          : Provider.of<Bank>(context).getEmail(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF707070),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      Provider.of<Bank>(context).getCity() == null
                          ? ''
                          : Provider.of<Bank>(context).getCity(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xFF707070),
                      )),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              if (color == Color(0xFFFBC541)) {
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/profile');
              }
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.wallet),
            title: Text(
              'Dashboard',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              if (color == Color(0xFFFEE0C6))
                Navigator.pop(context);
              else {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/dashboard');
              }
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.handHoldingUsd),
            title: Text(
              'Credit',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              if (color == Color(0xFFB0F6AE))
                Navigator.pop(context);
              else {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/credit');
              }
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.creditCard),
            title: Text(
              'Expend',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              if (color == Color(0xFFFDB0A4))
                Navigator.pop(context);
              else {
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/expend');
              }
            },
          ),
        ],
      ),
    );
  }
}
