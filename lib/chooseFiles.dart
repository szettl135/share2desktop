
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:share2desktop/receiveFiles.dart';


import 'package:flutter/foundation.dart';

class ChooseFiles extends StatefulWidget {
  final String targetDeviceName;
  //https://pub.dev/packages/device_info

  const ChooseFiles({Key? key, required this.targetDeviceName}) : super(key : key);
  
  @override
  _ChooseFiles createState() => _ChooseFiles();
}

class _ChooseFiles extends State<ChooseFiles> {
 


   @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: new AppBar(title: new Text("Share2Desktop")),
      body: Column(children: [
        Container(padding: EdgeInsets.all(30), child:
        Row(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              Spacer(),
              //SizedBox(width: 20),
              //Spacer(flex:3),
              Container(width:MediaQuery.of(context).size.width * 0.33, child:
              Column(children: [
                SizedBox(height:10),
                AutoSizeText("Dein Gerät:",style: TextStyle(fontSize: 30.0), minFontSize: 0),
                SizedBox(height: 10),
              
              ],),
              ),
              //Spacer(flex:1),
              SizedBox(width:MediaQuery.of(context).size.width * 0.025),
              //SizedBox(width: MediaQuery.of(context).size.width * 0.125),
              Icon(Icons.arrow_forward),
              SizedBox(width:MediaQuery.of(context).size.width * 0.025),
              //Spacer(flex:1),
              //SizedBox(width: MediaQuery.of(context).size.width * 0.125),
               Container(alignment: Alignment.topCenter, width:MediaQuery.of(context).size.width * 0.33, child:
               Column(crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center, children: [
                 
                // SizedBox(height:10),
                //Text("Zum Gerät:",style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 10),
                Icon(Icons.computer, size: 30.0,),
                SizedBox(height: 10),
                AutoSizeText(widget.targetDeviceName, textAlign: TextAlign.center, style: TextStyle(fontSize: 25.0), minFontSize: 0, stepGranularity: 1, maxLines: 4,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10)
              ],),
              ),
              //SizedBox(width: 20)
              Spacer()
              //Spacer(flex:3)
            ],
          ),
        ),
        Spacer(flex:1),
        OutlinedButton(onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReceiveFiles()),
                    )
                  },child: Text("Dateien auswählen", style: Theme.of(context).textTheme.headline3 )),
        Spacer(flex:2)
      ])
    );
  }
}