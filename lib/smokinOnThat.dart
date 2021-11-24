import 'package:flutter/material.dart';

class Programm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar(title: new Text("Seas")),
        body: Column(
          children: [
          //Einstellungen
            Row(
              children: [
                Spacer(flex: 1),
                 Container(padding: EdgeInsets.all(10),
                 alignment: Alignment.topRight, 
                child: TextButton(child: Row(children: [
                Text("Einstellungen"),
                SizedBox(width: 2),
                Icon(Icons.settings)
              ]),            
            onPressed: () => {
  print("lmao")
},
            ))
              ],
            ),
          
          SizedBox(height: 20),
          //Logo und Titel
          Text("sample text")
          ],

        )
      );
  }
}