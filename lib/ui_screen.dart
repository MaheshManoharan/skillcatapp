import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:user_firestore/constants.dart';

class UIScreen extends StatefulWidget {
  const UIScreen({Key key}) : super(key: key);

  @override
  _UIScreenState createState() => _UIScreenState();
}

class _UIScreenState extends State<UIScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController polynomialController = TextEditingController();

  String username, password, polynomial;

  Widget _buildPolynomialTF() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextFormField(
        onSaved: (newValue) {
          print('polynomial: $newValue');
          polynomial = newValue;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter your polynomial';
          }
          //if polynomial is valid
          return null;
        },
        controller: polynomialController,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: 14.0,
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          hintText: 'Enter your Polynomial',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buildPasswordTF() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextFormField(
        onSaved: (newValue) {
          print('password: $newValue');
          password = newValue;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Enter your password';
          }
          if (value.length < 4) {
            return 'password must be at least 4 characters';
          }
          return null;
        },
        controller: passwordController,
        obscureText: true,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: 14.0,
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          hintText: 'Enter your Password',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  Widget _buidUsernameTF() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: kBoxDecorationStyle,
      height: 60.0,
      child: TextFormField(
        onSaved: (newValue) {
          username = newValue;
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Please type a valid username';
          }
          return null;
        },
        controller: usernameController,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(
            top: 14.0,
          ),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          hintText: 'Enter your Username',
          hintStyle: kHintTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61a4f1),
                      Color(0xff478de0),
                      Color(0xff398ae5),
                    ],
                    stops: [
                      0.1,
                      0.4,
                      0.7,
                      0.9,
                    ]),
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: kLabelStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buidUsernameTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPasswordTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildPolynomialTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 25.0,
                          ),
                          width: double.infinity,
                          child: RaisedButton(
                              elevation: 5.0,
                              padding: EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              color: Colors.white,
                              child: Text('Submit'),
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                final FormState form = _formKey.currentState;
                                if (form.validate()) {
                                  _formKey.currentState.save();

                                  final CollectionReference userCollection =
                                      Firestore.instance.collection('users');

                                  await userCollection.document().setData({
                                    'username': username,
                                    'password': password,
                                    'polynomial': polynomial,
                                    'derivative': '5'
                                  }).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Data Created'),
                                      ),
                                    );
                                  });
                                }
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    usernameController.dispose();
    passwordController.dispose();
    polynomialController.dispose();
    super.dispose();
  }
}
