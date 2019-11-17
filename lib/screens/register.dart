import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ungpop/screens/my_service.dart';
import 'package:ungpop/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  String name, email, password;
  final formKey = GlobalKey<FormState>();

  // Method
  Widget nameText() {
    Color color = Colors.green.shade800;
    return TextFormField(
      onSaved: (value) {
        name = value;
      },
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
      onSaved: (value) {
        email = value;
      },
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
    Color color = Colors.white;
    return TextFormField(
      onSaved: (value) {
        password = value;
      },
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
      onPressed: () {
        formKey.currentState.save();
        print('name = $name, email = $email, password = $password');
        registerThread();
      },
    );
  }

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((authResult) {
          print('Register Success');
          setUpDisplayName();
        }).catchError((error){
          String title = error.code;
          String message = error.message;
          print('title = $title, message = $message');
          normalDialog(context, title, message);
        });
  }

  Future<void> setUpDisplayName()async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    firebaseUser.updateProfile(userUpdateInfo);

    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context){return MyService();});
    Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route){return false;});


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
            radius: 1.4,
            center: Alignment.topCenter,
          ),
        ),
        child: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.all(30.0),
            children: <Widget>[
              nameText(),
              emailText(),
              passwordText(),
            ],
          ),
        ),
      ),
    );
  }
}
