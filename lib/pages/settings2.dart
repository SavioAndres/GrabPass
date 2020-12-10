import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              margin: EdgeInsets.only(top: size.height * 0.05),
              child: Text("Configurações",
                  style: TextStyle(
                      fontFamily: "Title", fontSize: 30, color: primaryColor)),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.https_outlined),
                  title: Text('Alterar Senha Mestre'),
                ),
                ListTile(
                  leading: Icon(Icons.import_export),
                  title: Text('Exportar Senhas'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
