import 'package:flutter/material.dart';

class ReceiveFiles extends StatefulWidget {
  const ReceiveFiles({Key? key}) : super(key: key);

  @override
  _ReceiveFiles createState() => _ReceiveFiles();
}

class _ReceiveFiles extends State<ReceiveFiles> {
  Object? selectedDevice = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Share2Desktop")),
      body: Column(children: [
        Container(padding: EdgeInsets.all(30), child:  Text("Dateien empfangen",style: Theme.of(context).textTheme.headline2)),
        SizedBox(height: 50),
        Row(mainAxisAlignment:MainAxisAlignment.center ,children: [
          OutlinedButton(child: Text("Alles annehmen"), onPressed: () => {print("alles annehmen")}),SizedBox(width: 30),OutlinedButton(child: Text("Alles ablehnen"), onPressed: () => {print("ablehnen")})
        ],),
        Spacer(flex: 2),
        Container(

              padding: EdgeInsets.all(50),
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  TextButton(child: Text("video.mp4"),onPressed: () => (print("Video.mp4")),)
              
            
                ])),
        Spacer(flex:1)
       
      ])
    );
  }
}