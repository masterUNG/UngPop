import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field

  // Method
  Widget nameText() {
    Color color = Colors.green.shade800;
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          color: color,
          size: 48.0,
        ),
        labelText: 'Display Name :',
        labelStyle: TextStyle(color: color),
        helperText: 'Type Your Name',
        helperStyle: TextStyle(color: color),
        hintText: 'English Only',
      ),
    );
  }

  Widget emailText() {
    Color color = Colors.purple.shade700;
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: color,
          size: 48.0,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: color),
        helperText: 'Type Your Email',
        helperStyle: TextStyle(color: color),
        hintText: 'you@email.com',
      ),
    );
  }

  Widget passwordText() {
    Color color = Colors.yellow.shade900;
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          color: color,
          size: 48.0,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: color),
        helperText: 'Type Your Password',
        helperStyle: TextStyle(color: color),
        hintText: 'More 6 Charactor',
      ),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text('Register'),
        actions: <Widget>[registerButton()],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.blue.shade800],
            radius: 1.4,center: Alignment.topCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            nameText(),
            emailText(),
            passwordText(),
          ],
        ),
      ),
    );
  }
}
