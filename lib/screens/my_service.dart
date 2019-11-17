import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ungpop/screens/home.dart';
import 'package:ungpop/widget/info.dart';
import 'package:ungpop/widget/show_product_list.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Field
  String login = '...';
  Widget currentWidget = ShowProductList();

  // Method
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Widget menuPage1() {
    return ListTile(
      leading: Icon(Icons.filter_1),
      title: Text('Show Product List'),
      subtitle: Text('Description of Page 1'),
      onTap: () {
        setState(() {
          currentWidget = ShowProductList();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuPage2() {
    return ListTile(
      leading: Icon(Icons.filter_2),
      title: Text('Page 2'),
      subtitle: Text('Description of Page 2'),
      onTap: () {
        setState(() {
          currentWidget = Info();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget menuSignOut() {
    return ListTile(
      leading: Icon(Icons.exit_to_app),
      title: Text('Sign Out'),
      subtitle: Text('Sign Out and Back Home'),
      onTap: () {
        Navigator.of(context).pop();
        processSignOut();
      },
    );
  }

  Future<void> processSignOut()async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response){
      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context){return Home();});
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route){return false;});
    });
  }

  Future<void> findDisplayName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    setState(() {
      login = firebaseUser.displayName;
    });
    print('login = $login');
  }

  Widget showLogin() {
    return Text('Login by $login');
  }

  Widget showAppName() {
    return Text(
      'Ung Pop',
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.red.shade800,
      ),
    );
  }

  Widget showLogo() {
    return Container(
      height: 80.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showHead() {
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.white, Colors.yellow.shade700],
          radius: 1.0,
        ),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          showAppName(),
          showLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHead(),
          menuPage1(),Divider(),
          menuPage2(),Divider(),
          menuSignOut(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      body: currentWidget,
      drawer: showDrawer(),
    );
  }
}
