import 'package:GrabPass/bloc/password_bloc.dart';
import 'package:GrabPass/database/database.dart';
import 'package:GrabPass/model/password_model.dart';
import 'package:GrabPass/pages/add_password.dart';
import 'package:GrabPass/pages/view_password.dart';
import 'package:GrabPass/pages/update_password.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();

  //Brightness brigntness = Brightness.light;

  //Homepage({this.brigntness});
}

class _HomepageState extends State<Homepage> {
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

  final bloc = PasswordBloc();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    // print(iconNames.indexOf('Icon 10'));

    /*void changeBrightness() {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
    }*/

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "GrabPass",
                      style: TextStyle(
                          fontFamily: "Title",
                          fontSize: 32,
                          color: primaryColor),
                    ),
                    Row(
                      children: <Widget>[
                        /*IconButton(
                          icon: Icon(
                            Icons.wb_sunny,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            changeBrightness();
                          },
                        ), 
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SettingsPage()));
                          },
                        ),*/
                      ],
                    ),
                  ],
                )),
          ),
          Expanded(
            child: StreamBuilder<List<Password>>(
              stream: bloc.passwords,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Password password = snapshot.data[index];
                        int i = 0;
                        i = iconNames.indexOf(password.icon);
                        Color color = hexToColor(password.color);
                        return Dismissible(
                          //Key(password.id.toString()), //Key(Uuid().v4().toString()), // ObjectKey(password.id), //UniqueKey(),
                          key: ObjectKey(password.id),
                          background: Container(
                            color: Colors.teal[400],
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " Editar",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red[300],
                            child: Align(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " Exluir",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                              alignment: Alignment.centerRight,
                            ),
                          ),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpadatePassword(pass: password)),
                              );
                            } else {
                              var item = password;
                              //To delete
                              DBProvider.db.deletePassword(item.id);
                              setState(() {
                                snapshot.data.removeAt(index);
                              });
                              //To show a snackbar with the UNDO button
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Senha excluída"),
                                  action: SnackBarAction(
                                      label: "DESFAZER",
                                      onPressed: () {
                                        DBProvider.db.newPassword(item);
                                        setState(() {
                                          snapshot.data.insert(index, item);
                                        });
                                      })));
                            }
                          },
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ViewPassword(
                                            password: password,
                                          )));
                            },
                            child: ListTile(
                              title: Text(
                                password.appName,
                                style: TextStyle(
                                  fontFamily: 'Title',
                                ),
                              ),
                              leading: Container(
                                  height: 48,
                                  width: 48,
                                  child: CircleAvatar(
                                      backgroundColor: color, child: icons[i])),
                              subtitle: password.userName != ""
                                  ? Text(
                                      password.userName,
                                      style: TextStyle(
                                        fontFamily: 'Subtitle',
                                      ),
                                    )
                                  : Text(
                                      "Nenhum nome de usuário especificado",
                                      style: TextStyle(
                                        fontFamily: 'Subtitle',
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Nenhuma senha salva. \nClick no botão \"+\" para adicionar uma senha",
                        textAlign: TextAlign.center,
                        // style: TextStyle(color: Colors.black54),
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddPassword()));
        },
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }
}
