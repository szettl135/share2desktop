import 'package:flutter/material.dart';
import 'package:share2desktop/chooseFiles.dart';

class DeviceSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Column(children: [
          //Einstellungen
          Row(
            children: [
              Spacer(flex: 1),
              Container(
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  child: TextButton(
                    child: Row(children: [
                      Icon(Icons.qr_code),
                      SizedBox(width: 10),
                      Text("Dein Gerät: XYZ Phone"),
                    ]),
                    onPressed: () => {print("QR Code")},
                  )),
              Spacer(flex: 1)
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Spacer(flex: 1),
              Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    child: Row(children: [
                      Icon(Icons.camera),
                      SizedBox(width: 10),
                      Text("QR Code einscannen"),
                    ]),
                    onPressed: () => {print("QR Code einscannen")},
                  )),
              Spacer(flex: 1)
            ],
          ),

          //Abstand
          Spacer(flex: 1),

          //Row(children: [
          //SizedBox(width: 100),
          Container(
              padding: EdgeInsets.all(50),
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.computer),
                      title: const Text("Computer 1"),
                      subtitle: Text("Windows-PC von JUMBO"),
                      onTap: () => {print: "AAAAAAAAAAAAA"}),
                  ListTile(
                      leading: const Icon(Icons.computer),
                      title: const Text("Computer 2"),
                      subtitle: Text("Windows-PC von Schreiner"),
                      onTap: () => {print: "BBBBB"}),
                  ListTile(
                      leading: const Icon(Icons.phone_iphone),
                      title: const Text("Smartphone"),
                      subtitle: Text("iPhone von Fabian"),
                      onTap: () => {print: "CCCCC"}),
                  ListTile(
                      leading: const Icon(Icons.phone_iphone),
                      title: const Text("Smartphone"),
                      subtitle: Text("iPhone SE von Lennart"),
                      onTap: () => {print: "DDDD"}),
                  ListTile(
                      leading: const Icon(Icons.phone_iphone),
                      title: const Text("Smartphone"),
                      subtitle: Text("iPhone 12 von Lennart"),
                      onTap: () => {print: "EEEE"}),
                ],
              )),
                      
          //],

          //),
          SizedBox(height: 20),
          OutlinedButton(
            
              onPressed: () => {Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseFiles()),
              )},
              child: Text("Weiter")),
          Spacer(flex: 1),
        ]));
  }
}
