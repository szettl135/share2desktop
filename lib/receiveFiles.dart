import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ReceiveFiles extends StatefulWidget {
  const ReceiveFiles({Key? key}) : super(key: key);

  @override
  _ReceiveFiles createState() => _ReceiveFiles();
}

class _ReceiveFiles extends State<ReceiveFiles> {
  Object? selectedDevice = null;

final titel = [
    "Urlaub.mp4",
    "landschaft.png",
  ];

  final untertitel = [
    "Video | 10 MB",
    "Bild | 25 kB"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.only(top: 30),
              child: AutoSizeText("Dateien empfangen",
                  style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.center, maxLines: 1, presetFontSizes: [30, 15, 5])),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  child: Container(width: MediaQuery.of(context).size.width * 0.33, child: AutoSizeText("Alles annehmen", textAlign: TextAlign.center, maxLines: 1, presetFontSizes: [25, 15, 5])),
                  onPressed: () => {print("alles annehmen")}),
              SizedBox(width: 30),
              OutlinedButton(
                  child: Container(width: MediaQuery.of(context).size.width * 0.33, child: AutoSizeText("Alles ablehnen", textAlign: TextAlign.center, maxLines: 1,presetFontSizes: [25, 15, 5])),
                  onPressed: () => {print("ablehnen")})
            ],
          ),
          Spacer(flex: 2),
          Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: titel.length,
                itemExtent: MediaQuery.of(context).size.height * 0.125,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xffEBF7FF),

                    //
                    //                 <-- Card widget
                    shape: ContinuousRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // if you need this
                      side: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                        
                        title: Container(width: MediaQuery.of(context).size.width*0.50, child: AutoSizeText(titel[index], maxLines: 1, presetFontSizes: [30, 20, 15])),
                        trailing: Container(width: MediaQuery.of(context).size.width*0.25,child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    IconButton(
                        onPressed: () => {print("angenommen")},
                        icon: const Icon(Icons.save_alt)),
                    Spacer(flex:1),
                    IconButton(
                        onPressed: () => {print("abgelehnt")},
                        icon: const Icon(Icons.close)),
                        Spacer(flex:3)
                  ])),
                  subtitle: Container(width:MediaQuery.of(context).size.width*0.50, child:  AutoSizeText(untertitel[index], maxLines: 1, presetFontSizes: [20, 15, 10])
                )),
                              /*Icon(icons[index]), SizedBox(width: 30),*/ /*, SizedBox(width: 30)*/
                            
                        //subtitle: Text(subtitles[index]),
                        
                  );
                
              })),
          /*Container(
              padding: EdgeInsets.all(50),
              height: MediaQuery.of(context).size.height * 0.5,
              child:
                  ListView(padding: const EdgeInsets.all(8), children: <Widget>[
                //TextButton(child: Text("video.mp4"),onPressed: () => (print("Video.mp4")),)

                //ein einzelnes Element
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("video.mp4"),
                    SizedBox(width: 50),
                    IconButton(
                        onPressed: () => {print("angenommen")},
                        icon: const Icon(Icons.save_alt)),
                    SizedBox(width: 50),
                    IconButton(
                        onPressed: () => {print("abgelehnt")},
                        icon: const Icon(Icons.close))
                  ],
                ),*/

                ListTile(
                  title: Text('urlaub.mp4'),
                  subtitle: Text('Video | 10 MB'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: ()=> {print("annehmen")}, icon: Icon(Icons.save_alt)),
                      SizedBox(width: 30),
                      IconButton(onPressed: ()=> {print("ablehnen")}, icon: Icon(Icons.close)),
                    ],
                  ),
                ),
                //wir verwenden MB statt das richtige MiBi, um Leute nicht zu verwirren (Windows Standard)
                ListTile(
                  title: Text('landschaft.jpg'),
                  subtitle: Text('Bild | 1 MB'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(onPressed: ()=> {print("annehmen")}, icon: Icon(Icons.save_alt)),
                      SizedBox(width: 30),
                      IconButton(onPressed: ()=> {print("ablehnen")}, icon: Icon(Icons.close)),
                    ],
                  ),
                )
              ]))*/
          Spacer(flex: 1)
    ]));
  }
}
