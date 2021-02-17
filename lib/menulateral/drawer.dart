import 'package:Facedoc/homescreen.dart';
import 'package:Facedoc/menulateral/iconeQrcode/layout-qrcode.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ChamarDrawer extends StatefulWidget {
  @override
  _ChamarDrawerState createState() => _ChamarDrawerState();
}

class _ChamarDrawerState extends State<ChamarDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text(""),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imagens/facedc.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.blue[900],
            ),
            title: Text("Inicio"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => (HomeScreen())));
            },
          ),
          ListTile(
              leading: Icon(
                Icons.qr_code,
                color: Colors.blue[900],
              ),
              title: Text("Leitor QR Code"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => QrCode()));
              }),
          ListTile(
            title: Text("Compartilhar"),
            leading: Icon(
              Icons.share_outlined,
              color: Colors.blue[900],
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Share.share(
                'https://play.google.com/store/apps/details?id=br.com.alfadev.Facedoc',
              );
            },
          ),
        ],
      ),
    );
  }
}
