import 'package:Facedoc/homescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  String qrCodeResult = "";

  //Faz o Scaneamento
  Future<void> scanner() async {
    String codeScanner = await BarcodeScanner.scan();
    setState(() {
      qrCodeResult = codeScanner;
    });
  }
  //Fim do Codigo

  //Abrir o link escaneado pelo qrcode
  abrirSite() async {
    if (await canLaunch(qrCodeResult)) {
      await launch(
        qrCodeResult,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      print('A informação $qrCodeResult não é um link Valido');
    }
  }
  //final do comando

  //Faz um alerta caso o botão de abrir link for apertado sem ser escaneado antes.
  Future<bool> _notificar() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text("Faça o Escaneamento Primeiro!"),
        actions: <Widget>[
          RaisedButton(
            color: Colors.blue[900],
            child: Text("ok", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
        ],
      ),
    );
  }
  //final do comando

  //Comando para a tecla de voltar/sair do app
  Future<bool> _onWillPop() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text("Volta ao Menu Anteior?"),
        actions: <Widget>[
          RaisedButton(
            color: Color(0xff01a0c7),
            child: Text("Sim", style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => (HomeScreen())));
            },
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            title: Text("Leitor QR Code"),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.blue[900],
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp),
              onPressed: () => _onWillPop(),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            //LayoutQrcode(),
            Container(
              padding: EdgeInsets.only(top: 30),
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue[900],
              child: Align(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.only(top: 35, bottom: 20),
                      height: 310,
                      width: 310,
                      child: Image.asset("assets/imagens/qrc.png"),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 40, right: 40, bottom: 30, top: 400),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "$qrCodeResult",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 300),
              child: FlatButton(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Scanner".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.blue[900],
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  scanner();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          tooltip: "Abrir Link",
          icon: Icon(Icons.open_in_new_outlined),
          backgroundColor: Colors.blue[900],
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.orange, width: 2.0),
            borderRadius: BorderRadius.circular(30),
          ),
          label: Text("LINK"),
          onPressed: () {
            if (qrCodeResult != "") {
              return abrirSite();
            } else if (qrCodeResult == "") {
              _notificar();
            }
          },
        ),
      ),
    );
  }
}
