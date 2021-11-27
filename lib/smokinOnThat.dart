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
                SizedBox(width: 5),
                Icon(Icons.settings)
              ]),            
            onPressed: () => {
            print("Einstellungen")
          },
            ))
              ],
            ),
          
          
          //Abstand
          Spacer(flex: 1),

          //Logo und Titel

          Image(image: AssetImage("assets/icon.png"), alignment: Alignment.center,width: 200),
          SizedBox(height: 20),
          Text("Share2Desktop"),

          Spacer(flex: 1),

          //Buttons
          /*Row(children: [
            Spacer(flex:1),
            OutlinedButton(onPressed: () => {print("Senden")}, child: Container(padding: EdgeInsets.all(10), child: Row(children: [
              SizedBox(width:20),Spacer(flex:1),Text("Senden"),Spacer(flex:1),Icon(Icons.arrow_forward),SizedBox(width:20)
            ],))),
            Spacer(flex:1)
          ],),*/
          Row(
              children: [
                Spacer(flex:1),
            
                //SizedBox(width: 50),
              /*Spacer(flex:1),
                Container(padding: EdgeInsets.all(10), alignment:  Alignment.center,
                  child: OutlinedButton(child: Row(children: [
                    SizedBox(width: 20),
                    Spacer(flex:1),
                    Text("Senden"),
                    Spacer(flex: 1),
                    Icon(Icons.arrow_forward),
                    SizedBox(width: 20)
                  ]),            
                  onPressed: () => {
                  print("Einstellungen")
                  },
                  )),
              Spacer(flex:1)*/
              OutlinedButton(onPressed: () => {print("Einstellungen")}, child: Row(children: [SizedBox(width:10),Text("Senden"),Icon(Icons.arrow_forward),SizedBox(width:10)],)),
              Spacer(flex: 1)
              ],
            ),
          

          Spacer(flex:1)
          ],

        )
      );
  }
}