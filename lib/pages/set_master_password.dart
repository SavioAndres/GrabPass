import 'package:GrabPass/pages/password_homepage.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SetMasterPassword extends StatefulWidget {
  @override
  _SetMasterPasswordState createState() => _SetMasterPasswordState();
}

class _SetMasterPasswordState extends State<SetMasterPassword> {
  TextEditingController masterPassController = TextEditingController();

  Future<Null> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    masterPassController.text = masterPass;
  }

  saveMasterPass(String masterPass) async {
    final storage = new FlutterSecureStorage();

    await storage.write(key: 'master', value: masterPass);
  }

  authenticate() async {
    var localAuth = LocalAuthentication();
    bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Autentique-se para alterar a senha mestre',
        stickyAuth: true);

    if (!didAuthenticate) {
      Navigator.pop(context);
    }

    print(didAuthenticate);
  }

  @override
  void initState() {
    super.initState();
    authenticate();
    getMasterPass();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Text("Senha mestre",
                    style: TextStyle(
                        fontFamily: "Title",
                        fontSize: 32,
                        color: primaryColor))),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                  "Defina senha mestre para todas as suas senhas. Mantenha sua senha mestre segura com você. Esta senha será usada para desbloquear as outras senhas.",
                  style: TextStyle(
                      fontSize: 16,
                      // color: Colors.black54,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Subtitle"))),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                obscureText: true,
                maxLength: 32,
                decoration: InputDecoration(
                    labelText: "Senha mestre",
                    labelStyle: TextStyle(fontFamily: "Subtitle"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6))),
                controller: masterPassController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: size.width * 0.7,
                height: 60,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  color: primaryColor,
                  child: Text(
                    "CONFIRMAR",
                    style: TextStyle(color: Colors.white, fontFamily: "Title"),
                  ),
                  onPressed: () async {
                    if (masterPassController.text.isNotEmpty) {
                      saveMasterPass(masterPassController.text.trim());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PasswordHomepage()));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Erro!",
                                style: TextStyle(fontFamily: "Title"),
                              ),
                              content: Text(
                                "Por favor, insira uma senha mestre válida.",
                                style: TextStyle(fontFamily: "Subtitle"),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("FECHAR"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
