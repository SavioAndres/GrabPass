import 'package:flutter/material.dart';

class ImportExport extends StatefulWidget {
  @override
  _ImportExportState createState() => _ImportExportState();
}

class _ImportExportState extends State<ImportExport> {
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
              child: Text("Importar/Exportar Contas",
                  style: TextStyle(
                      fontFamily: "Title", fontSize: 26, color: primaryColor)),
            ),
          ),
        ],
      ),
    );
  }
}
