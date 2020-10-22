import 'package:GrabPass/pages/create.page.dart';
import 'package:GrabPass/pages/dashboard.page.dart';
import 'package:GrabPass/pages/greetings.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int launch = 0;
  bool loading = true;
  
  @override
  void initState() {
    //checkPrimaryColr();
    checkFirstSeen();
    super.initState();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    launch = prefs.getInt("launch") ?? 0;

    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    
    //if (prefs.getInt('primaryColor') == null) {
    //  await prefs.setInt('primaryColor', 0);
    //}

    if (launch == 0 && masterPass == '') {
      await prefs.setInt('launch', launch + 1);
      //await prefs.setInt('primaryColor', 0);
      
      // await prefs.setBool('enableDarkTheme', false);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrabPass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: CreatePage(),
      home: loading 
          ? Center(
            child: CircularProgressIndicator(),
          )
        : launch == 0 ? GreetingsPage() : GreetingsPage(),
    );
  }
}