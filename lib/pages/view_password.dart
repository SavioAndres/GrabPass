import 'package:GrabPass/model/password_model.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';

class ViewPassword extends StatefulWidget {
  final Password password;

  const ViewPassword({Key key, this.password}) : super(key: key);

  @override
  _ViewPasswordState createState() => _ViewPasswordState(password);
}

class _ViewPasswordState extends State<ViewPassword> {
  final Password password;
  _ViewPasswordState(this.password);

  TextEditingController masterPassController = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Icon> icons = [
    Icon(Icons.account_circle, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.solidEnvelope, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.facebook, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.instagram, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.twitter, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.linkedinIn, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.google, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.pinterestP, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.vk, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.amazon, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.solidComment, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.addressBook, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.wifi, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.photoVideo, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.music, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.book, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.userGraduate, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.school, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.theaterMasks, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.folderOpen, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.gamepad, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.solidHeart, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.userMd, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.landmark, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.church, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.home, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.stickyNote, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.newspaper, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.hamburger, size: 64, color: Colors.white),
    Icon(FontAwesomeIcons.tshirt, size: 64, color: Colors.white),
  ];

  List<String> iconNames = [
    "Icon 1",
    "Icon 2",
    "Icon 3",
    "Icon 4",
    "Icon 5",
    "Icon 6",
    "Icon 7",
    "Icon 8",
    "Icon 9",
    "Icon 10",
    "Icon 11",
    "Icon 12",
    "Icon 13",
    "Icon 14",
    "Icon 15",
    "Icon 16",
    "Icon 17",
    "Icon 18",
    "Icon 19",
    "Icon 20",
    "Icon 21",
    "Icon 22",
    "Icon 23",
    "Icon 24",
    "Icon 25",
    "Icon 26",
    "Icon 27",
    "Icon 28",
    "Icon 29",
    "Icon 30",
  ];
  bool decrypt = false;
  String decrypted = "";
  Color color;
  int index;
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }

  bool didAuthenticate = false;

  authenticate() async {
    var localAuth = LocalAuthentication();
    didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Por favor autentique para ver a senha',
        stickyAuth: true);
  }

  Future<String> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    return masterPass;
  }

  @override
  void initState() {
    print(password.color);
    color = hexToColor(password.color);
    index = iconNames.indexOf(password.icon);
    authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              height: size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(33),
                      bottomRight: Radius.circular(33))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    icons[index],
                    SizedBox(
                      height: 14,
                    ),
                    Text(password.appName,
                        style: TextStyle(
                            fontFamily: "Title2",
                            fontSize: 32,
                            color: Colors.white)),
                  ],
                ),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 18, 12, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
                  child: Text(
                    "Nome de usuário ou e-mail",
                    style: TextStyle(fontFamily: 'Title', fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 22),
                  child: Text(
                    password.userName,
                    style: TextStyle(
                        fontFamily: 'Subtitle',
                        fontSize: 18,
                        color: Colors.black54),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "Senha",
                              style:
                                  TextStyle(fontFamily: 'Title', fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                            child: Text(
                              decrypt
                                  ? decrypted
                                  : "**********", //password.password
                              style: TextStyle(
                                  fontFamily: 'Subtitle',
                                  fontSize: 18,
                                  color: Colors.black54),
                            ),
                          ),
                        ]),
                    IconButton(
                      onPressed: () async {
                        if (!decrypt && !didAuthenticate) {
                          buildShowDialogBox(context);
                        } else if (!decrypt && didAuthenticate) {
                          String masterPass = await getMasterPass();
                          decryptPass(password.password, masterPass);
                        } else if (decrypt) {
                          setState(() {
                            decrypt = !decrypt;
                          });
                        }
                      },
                      icon: decrypt ? Icon(Icons.lock_open) : Icon(Icons.lock),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: FlatButton(
                        //color: color,
                        //textColor: Colors.white,
                        onPressed: () {
                          if (decrypt) {
                            Clipboard.setData(new ClipboardData(text: decrypted));
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content:
                                    Text("Copiado para a área de transferência"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Text(decrypt ? "Copiar senha" : ""),
                    )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future buildShowDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Digite a senha mestre"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Para descriptografar a senha, digite sua senha mestre:",
                style: TextStyle(fontFamily: 'Subtitle'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: TextField(
                  obscureText: true,
                  maxLength: 32,
                  decoration: InputDecoration(
                      hintText: "Senha mestre",
                      hintStyle: TextStyle(fontFamily: "Subtitle"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                  controller: masterPassController,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                decryptPass(
                    password.password, masterPassController.text.trim());
                masterPassController.clear();
                if (!decrypt) {
                  final snackBar = SnackBar(
                    content: Text(
                      'Senha mestre errada',
                      style: TextStyle(fontFamily: "Subtitle"),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackBar);
                }
              },
              child: Text("FEITO"),
            )
          ],
        );
      },
    );
  }

  decryptPass(String encryptedPass, String masterPass) {
    String keyString = masterPass;
    if (keyString.length < 32) {
      int count = 32 - keyString.length;
      for (var i = 0; i < count; i++) {
        keyString += ".";
      }
    }

    final iv = encrypt.IV.fromLength(16);
    final key = encrypt.Key.fromUtf8(keyString);

    try {
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final d = encrypter.decrypt64(encryptedPass, iv: iv);
      setState(() {
        decrypted = d;
        decrypt = true;
      });
    } catch (exception) {
      setState(() {
        decrypted = "Senha mestre errada";
      });
    }
  }
}
