import 'package:flutter/material.dart';

class ChooseFiles extends StatefulWidget {
  const ChooseFiles({Key? key}) : super(key : key);
  
  @override
  _ChooseFiles createState() => _ChooseFiles();
}

class _ChooseFiles extends State<ChooseFiles> {
   @override
  Widget build(BuildContext context) {
    final String deviceName;


    return Scaffold(
      appBar: new AppBar(title: new Text("Share2Desktop")),
      body: Column(children: [
        Container(padding: EdgeInsets.all(30), child:
        Row(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              SizedBox(width: 20),
              Column(children: [
                Text("Dein Gerät:",style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 10),
                Text("DeviceName"),
                SizedBox(height: 10),
                Icon(Icons.phone_iphone)
              ],),
              //Spacer(flex:1),
              SizedBox(width: MediaQuery.of(context).size.width * 0.125),
              Icon(Icons.arrow_forward),
              //Spacer(flex:1),
              SizedBox(width: MediaQuery.of(context).size.width * 0.125),
               Column(children: [
                Text("Zum Gerät:",style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 10),
                Text("DeviceName"),
                SizedBox(height: 10),
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