import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

var rng = new Random();
bool isLogin = false;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool('boolValue');
    return boolValue;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: isLogin ? MyHomePage(title: "Welcomeback!") : LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  bool valuefirst = false;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('added isLogin $isLogin');
    prefs.setBool('boolValue', isLogin);
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: emailController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Email',
          prefixIcon: Icon(Icons.mail_outline)),
    );

    final passwordField = TextField(
        controller: passwordController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              color: this._obscureText ? Colors.grey : Colors.blue,
            ),
            onPressed: () {
              setState(() => this._obscureText = !this._obscureText);
            },
          ),
        ));

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          isLogin = true;

          addBoolToSF();
          Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new MyHomePage(
                      title: "Welcome 1st time",
                    )),
          );
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 20.0,
                ),
                loginButton,
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int random = 0;
  int stored = 0;
  int loaded = 0;

  void _generateRandom() {
    setState(() {
      random = rng.nextInt(999999);
    });
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', random);
    setState(() {
      stored = random;
    });
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('intValue');
    setState(() {
      loaded = intValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('You have generated random number:'),
          Text('$random'),
          Text('You have stored in Shared Preferences:'),
          Text('$stored'),
          Text('You have loaded from Shared Preferences:'),
          Text('$loaded'),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: getIntValuesSF,
              child: Text('LOAD'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: _generateRandom,
              child: Text('Random'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: addIntToSF,
              child: Text('Save'),
            ),
          ]),
        ],
      )),
    );
  }
}
