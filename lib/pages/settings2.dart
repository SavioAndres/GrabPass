import 'dart:io';

import 'package:GrabPass/database/database.dart';
import 'package:GrabPass/pages/import_export.dart';
import 'package:GrabPass/pages/master_password.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
                InkWell(
                  onTap: () {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Aviso"),
                            content: Text(
                                "A alteração da senha mestre é somente para as novas contas que forem registradas. Você ainda precisará utilizar a senha antiga para as contas já registradas."),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("CANCELAR"),
                              ),
                              FlatButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MasterPassword())),
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        });
                  },
                  child: ListTile(
                    leading: Icon(Icons.https_outlined),
                    title: Text('Alterar Senha Mestre'),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => ImportExport()));
                  },
                  child: ListTile(
                    leading: Icon(Icons.import_export),
                    title: Text('Importar/Exportar Senhas'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
