import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReceiveFiles extends StatefulWidget {
  const ReceiveFiles({Key? key}) : super(key: key);

  @override
  _ReceiveFiles createState() => _ReceiveFiles();
}

class _ReceiveFiles extends State<ReceiveFiles> {
  Object? selectedDevice = null;

var filesGroup = AutoSizeGroup();
var subGroup = AutoSizeGroup();

final titel = [
    "Urlaub.mp4",
    "landschaft.png",
    "bib.zip",
    "trainingsplan.docx"
  ];

  final untertitel = [
    "Video | 10 MB",
    "Bild | 25 kB",
    "Archiv | 5 MB",
    "Text (Word) | 15 kB"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Column(children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.only(top: 30),
              child: AutoSizeText(AppLocalizations.of(context)!.receiveFiles,
                  style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.center, maxLines: 1, presetFontSizes: [30, 15, 5])),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                  child: Container(width: MediaQuery.of(context).size.width * 0.33, child: AutoSizeText(AppLocalizations.of(context)!.acceptAll, textAlign: TextAlign.center, maxLines: 1, minFontSize: 5, maxFontSize: 25, stepGranularity: 1,overflow: TextOverflow.ellipsis)),
                  onPressed: () => {print("alles annehmen")}),
              SizedBox(width: 30),
              OutlinedButton(
                  child: Container(width: MediaQuery.of(context).size.width * 0.33, child: AutoSizeText(AppLocalizations.of(context)!.rejectAll, textAlign: TextAlign.center, maxLines: 1, minFontSize: 5, maxFontSize: 25, stepGranularity: 1,overflow: TextOverflow.ellipsis)),
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
                    color: Theme.of(context).scaffoldBackgroundColor,

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
                    child: Column( mainAxisAlignment: MainAxisAlignment.center,
 crossAxisAlignment: CrossAxisAlignment.center, children:[ ListTile(
                        
                        title: Container(width: MediaQuery.of(context).size.width*0.50, child: AutoSizeText(titel[index], group: filesGroup, maxLines: 1, minFontSize: 5, maxFontSize: 30, stepGranularity: 1,overflow: TextOverflow.ellipsis)),
                        trailing: Container(alignment: Alignment.centerRight, width: MediaQuery.of(context).size.width*0.25,child: Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
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
                  subtitle: Container(width:MediaQuery.of(context).size.width*0.50, child:  AutoSizeText(untertitel[index], group: subGroup, maxLines: 1, minFontSize: 5, maxFontSize: 25, stepGranularity: 1,overflow: TextOverflow.ellipsis)
                )),
                              /*Icon(icons[index]), SizedBox(width: 30),*/ /*, SizedBox(width: 30)*/
                            
                        //subtitle: Text(subtitles[index]),
                        
                    ]));
                
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
