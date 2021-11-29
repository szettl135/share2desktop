import 'package:flutter/material.dart';
import 'package:share2desktop/deviceSelection.dart';

class ChooseFiles extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Share2Desktop")),
      body: Column(children: [
        Container(padding: EdgeInsets.all(30), child:
        Row(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              SizedBox(width: 20),
              Column(children: [
                Text("Dein Gerät:"),
                Text("DeviceName"),
                Icon(Icons.phone_iphone)
              ],),
              //Spacer(flex:1),
              SizedBox(width: MediaQuery.of(context).size.width * 0.125),
              Icon(Icons.arrow_forward),
              //Spacer(flex:1),
              SizedBox(width: MediaQuery.of(context).size.width * 0.125),
               Column(children: [
                Text("Zum Gerät:"),
                Text("DeviceName"),
                Icon(Icons.computer)
              ],),
              SizedBox(width: 20)
            ],
          ),
        ),
        Spacer(flex:1),
        OutlinedButton(onPressed: () => print("E"), child: Text("Dateien auswählen")),
        Spacer(flex:2)
      ])
    );
  }
}