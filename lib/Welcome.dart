import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Wallett',
                style: TextStyle(
                  color: Color(0xFFFEB127),
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: 445,
              width: 445,
              child: Image(
                image: AssetImage('images/wallett.jpg'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    SystemNavigator.pop();
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color(0xFFC0621C),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(120),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 55,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Exit',
                              style: TextStyle(
                                color: Color(0xFFF98A93),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Color(0xFFF98A93),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(120),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 55,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Go',
                              style: TextStyle(
                                color: Color(0xFFC0621C),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
