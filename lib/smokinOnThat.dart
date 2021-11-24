import 'package:flutter/material.dart';

class Programm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar(title: new Text("Seas")),
        body: Column(
          children: [
            
            Row(
              children: [
                Spacer(flex: 1),
                 Container(alignment: Alignment.topRight, 
                child: TextButton(child: Row(children: [
                Text("Einstellungen"),
                Icon(Icons.settings)
              ]),            
            onPressed: null,
            ))
              ],
            )
           
          ],

        )
      );
  }
}