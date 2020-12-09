import 'package:GrabPass/database/database.dart';
import 'package:GrabPass/model/password_model.dart';
import 'package:GrabPass/pages/homepage.dart';
import 'package:GrabPass/random_string.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:password_strength/password_strength.dart';

class AddPassword extends StatefulWidget {
  AddPassword({Key key}) : super(key: key);

  _AddPasswordState createState() => _AddPasswordState();
}

class _AddPasswordState extends State<AddPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController appNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  Color pickedColor;
  var localAuth = LocalAuthentication();

  encrypt.Encrypted encrypted;
  String keyString = "";
  String encryptedString = "";
  String decryptedString = "";
  String masterPassString = "";
  int pickedIcon;

  List<Icon> icons = [
    Icon(Icons.account_circle, size: 28, color: Colors.white),
    Icon(FontAwesomeIcons.solidEnvelope, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.facebook, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.instagram, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.twitter, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.linkedinIn, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.google, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.pinterestP, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.vk, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.amazon, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.solidComment, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.addressBook, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.wifi, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.photoVideo, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.music, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.book, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.userGraduate, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.school, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.theaterMasks, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.folderOpen, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.gamepad, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.solidHeart, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.userMd, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.landmark, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.church, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.home, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.stickyNote, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.newspaper, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.hamburger, size: 26, color: Colors.white),
    Icon(FontAwesomeIcons.tshirt, size: 26, color: Colors.white),
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

  List<Color> colors = [
    Colors.red,
    // Color(0xffd5563a),
    Color(0xffcf5a3b),
    // Color(0xffca5d3c),
    // Color(0xffc6603d),
    // Color(0xffc0643d),
    Color(0xffba673e),
    // Color(0xffb66a3f),
    // Color(0xffb36c3f),
    // Color(0xffaf6e40),
    Color(0xffa87341),
    // Color(0xffa47642),
    Color(0xffa07842),
    // Color(0xff9b7b43),
    // Color(0xff967f44),
    // Color(0xff908245),
    Color(0xff8b8646),
    // Color(0xff858a47),
    Color(0xff808d47),
    // Color(0xff799249),
    // Color(0xff769349),
    // Color(0xff72964a),
    Color(0xff6d994a),
    // Color(0xff6c9a4a),
    // Color(0xff659e4c),
    // Color(0xff639f4c),
    Color(0xff5ea34d),
    // Color(0xff5ba44d),
    Color(0xff58a64e),
    // Color(0xff53aa4e),
    Colors.green
  ];

  // Future<Null> getMasterPass() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String masterPass = prefs.getString('master') ?? "";
  //   masterPassString = masterPass;
  // }

  Future<Null> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    masterPassString = masterPass;
  }

  authenticate() async {
    try {
      var localAuth = LocalAuthentication();
      print(await localAuth.getAvailableBiometrics());
      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Por favor autentique para adicionar uma nova senha',
      );

      print(didAuthenticate);

      if (didAuthenticate == false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Homepage()),
            (Route<dynamic> route) => false);
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        // Handle this exception here.
      }
    }
  }

  double passwordStrength = 0.0;
  Color passwordStrengthBarColor = Colors.teal;
  bool obscureText = true;
  String show_hide = 'Mostrar senha';
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    pickedColor = Colors.teal;
    getMasterPass();
    pickedIcon = 0;
    // authenticate();
    super.initState();
  }

  checkPassStrength(String pass) {
    setState(() {
      passwordStrength = estimatePasswordStrength(pass);
      Color passwordStrengthBarColor = Colors.red;
      if (passwordStrength < 0.4) {
        passwordStrengthBarColor = Colors.red;
      } else if (passwordStrength > 0.4 && passwordStrength < 0.7) {
        passwordStrengthBarColor = Colors.deepOrangeAccent;
      } else if (passwordStrength < 0.7) {
        passwordStrengthBarColor = Colors.orange;
      } else if (passwordStrength > 0.7 || passwordStrength == 0.7) {
        passwordStrengthBarColor = Colors.green;
      }
      setState(() {
        this.passwordStrengthBarColor = passwordStrengthBarColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Text(
                  "Adicionar Conta",
                  style: TextStyle(
                      fontFamily: "Title", fontSize: 32, color: primaryColor),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor, insira um título';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Título",
                          labelStyle: TextStyle(fontFamily: "Subtitle"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6))),
                      controller: appNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor, insira um e-mail ou nome de usuário';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "E-mail ou nome de usuário",
                          labelStyle: TextStyle(fontFamily: "Subtitle"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6))),
                      controller: userNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      //TextField
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor, insira uma senha';
                        }
                      },
                      onChanged: (pass) {
                        checkPassStrength(pass);
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        //errorText: 'Please enter valid password',
                        labelText: "Senha",
                        labelStyle: TextStyle(fontFamily: "Subtitle"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      controller: passwordController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            String pass = randomAlphaNumeric(10);
                            passwordController.text = pass;
                            checkPassStrength(pass);
                          },
                          child: Text('Gerar'),
                        ),
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                              if (obscureText) {
                                show_hide = 'Mostrar senha';
                              } else {
                                show_hide = 'Esconder a senha';
                              }
                            });
                          },
                          child: Text(show_hide),
                        ),
                        FlatButton(
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                text: passwordController.text));
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Copiado para a área de transferência"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text('Copiar'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 10,
                        width: passwordStrength == 0
                            ? 5
                            : MediaQuery.of(context).size.width *
                                passwordStrength,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: passwordStrengthBarColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: Text(
                            "Escolha uma cor",
                            style: TextStyle(
                                fontFamily: 'Title',
                                fontSize: 20,
                                color: primaryColor),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _openColorPicker();
                          },
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 20, top: 8),
                              child: Material(
                                shape: CircleBorder(),
                                elevation: 4.0,
                                child: CircleAvatar(
                                    backgroundColor: pickedColor,
                                    radius: 25,
                                    child: icons[pickedIcon]),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 90),
                    child: GridView.count(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 6, //5
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.3,
                        children: List.generate(icons.length, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                pickedIcon = index;
                              });
                            },
                            child: Material(
                                elevation: 4.0,
                                color: pickedColor,
                                shape: CircleBorder(),
                                child: icons[index]),
                          );
                        })),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.done),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            encryptPass(passwordController.text);
            Password password = new Password(
                appName: appNameController.text,
                password: encryptedString,
                color: "#" + pickedColor.value.toRadixString(16),
                icon: iconNames[pickedIcon],
                userName: userNameController.text);
            DBProvider.db.newPassword(password);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Homepage()),
                (Route<dynamic> route) => false);
          } else {
            // print(Theme.of(context).accentColor);
          }
        },
      ),
    );
  }

  _openColorPicker() async {
    Color _tempShadeColor = pickedColor;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(7.0),
          title: Text("Selecionar cor"),
          actions: [
            FlatButton(
              child: Text('CANCELAR'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SALVAR'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  pickedColor = _tempShadeColor;
                });
              },
            ),
          ],
          content: MaterialColorPicker(
            allowShades: true,
            shrinkWrap: true,
            selectedColor: _tempShadeColor,
            onColorChange: (color) => setState(() => _tempShadeColor = color),
            onMainColorChange: (color) =>
                setState(() => _tempShadeColor = color),
          ),
        );
      },
    );
  }

  encryptPass(String text) {
    keyString = masterPassString;
    if (keyString.length < 32) {
      int count = 32 - keyString.length;
      for (var i = 0; i < count; i++) {
        keyString += ".";
      }
    }
    final key = encrypt.Key.fromUtf8(keyString);
    final plainText = text;
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final e = encrypter.encrypt(plainText, iv: iv);
    encryptedString = e.base64.toString();
  }
}
