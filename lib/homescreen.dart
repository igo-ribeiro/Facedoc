import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'menulateral/drawer.dart';
import 'package:minimize_app/minimize_app.dart';

import 'onesgnal/onesgnal.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var bloc = BlocHome();

  @override
  void initState() {
    bloc.initOneSignal();
    super.initState();
  }

//Comando para a tecla de voltar/sair do app
  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text("Que sair do App?"),
        actions: <Widget>[
          RaisedButton(
            color: Color(0xff01a0c7),
            child: Text(
              "Sim",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => MinimizeApp.minimizeApp(),
          ),
          RaisedButton(
            color: Color(0xff01a0c7),
            child: Text("Não", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }
  //final do comando

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: Colors.blue[900],
          ),
        ),
        body: WebView(
          initialUrl: "https://facedoc.com.br/login",
          javascriptMode: JavascriptMode.unrestricted,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Color.fromRGBO(55, 28, 5, 1),
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.blue[900],
          notchMargin: 6,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
          ),
        ),
        drawer: ChamarDrawer(),
      ),
    );
  }
}
