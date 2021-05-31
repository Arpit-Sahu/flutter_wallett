import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallett/bank.dart';
import 'dart:io';
import 'MainDrawer.dart';
import 'package:flutter/cupertino.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String userName, userEmail, userCity;
  File _image;
  final picker = ImagePicker();
  bool isObscurePassword = true;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Bank b = Bank();
        b.setImage(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
//        appBar: AppBar(
//          title: Text('Flutter Edit Profile UI'),
//          leading: IconButton(
//            icon: Icon(
//              Icons.arrow_back,
//              color: Colors.white,
//            ),
//            onPressed: () {},
//          ),
//          actions: [
//            IconButton(
//              icon: Icon(Icons.settings),
//              color: Colors.white,
//              onPressed: getImage,
//            ),
//          ],
//        ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF707070),
        ),
        elevation: 0,
        title: Text(
          'Account',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        backgroundColor: Color(0xFFFBC541),
      ),
      drawer: MainDrawer(
        color: Color(0xFFFBC541),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _image == null
                            ? AssetImage('images/wallett.jpg')
                            : FileImage(_image),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: getImage,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          color: Color(0xFFFEE0C6),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              SizedBox(
                height: 30,
              ),
              buildTextField('Full Name', 'Ex - John Doe', false, (value) {
                userName = value;
              }),
              buildTextField('Email', 'john@gmail.com', false, (value) {
                userEmail = value;
              }),
//                  buildTextField('Password', '*******', true),
              buildTextField('Location', 'New York', false, (value) {
                userCity = value;
              }),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 15, letterSpacing: 2, color: Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (userName == null ||
                          userEmail == null ||
                          userCity == null) {
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
                      Bank b = Bank();
                      b.updateProfile(userName, userEmail, userCity);
                      Navigator.popAndPushNamed(context, '/dashboard');
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFBC541),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelTest, String placeholder,
      bool isPasswordTextField, Function onChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        onChanged: onChanged,
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  color: Colors.grey,
                  onPressed: () {
                    setState(() {
                      isObscurePassword = !isObscurePassword;
                    });
                  })
              : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelTest,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
