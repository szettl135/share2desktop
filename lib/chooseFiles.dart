
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:share2desktop/receiveFiles.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/foundation.dart';

class ChooseFiles extends StatefulWidget {
  final String targetDeviceName;
  //https://pub.dev/packages/device_info

  const ChooseFiles({Key? key, required this.targetDeviceName}) : super(key : key);
  
  @override
  _ChooseFiles createState() => _ChooseFiles();
}

class _ChooseFiles extends State<ChooseFiles> {
 
var devicesGroup = AutoSizeGroup();

  void _pickFile() async {
      
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
  
    // if no file is picked
    if (result == null) return;
  
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    print(result.files.first.size);
    print(result.files.first.path);
  }

   @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: new AppBar(title: new Text("Share2Desktop")),
      body: Column(children: [
        Container(padding: EdgeInsets.all(30), child:
        Row(
            //mainAxisAlignment:MainAxisAlignment.center ,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              //SizedBox(width: 20),
              //Spacer(flex:3),
              Container(width:MediaQuery.of(context).size.width * 0.33, child:
              Column(children: [
                SizedBox(height:10),
                Container(alignment: Alignment.center, width: MediaQuery.of(context).size.width * 0.30,
                  child:
                AutoSizeText(AppLocalizations.of(context)!.yourDevice,style: Theme.of(context).textTheme.headline4, group: devicesGroup, maxLines: 1, minFontSize: 5, maxFontSize: 30, stepGranularity: 1,overflow: TextOverflow.ellipsis)),
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
                Container(alignment: Alignment.center, width: MediaQuery.of(context).size.width * 0.30,
                child: 
                AutoSizeText(widget.targetDeviceName, textAlign: TextAlign.center, group: devicesGroup, maxLines: 1, minFontSize: 5, maxFontSize: 25, stepGranularity: 1, style: Theme.of(context).textTheme.headline4,overflow: TextOverflow.ellipsis,),
                ),SizedBox(height: 10)
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
                  },child: Container(alignment: Alignment.center, padding: EdgeInsets.all(10),
                    
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: AutoSizeText(AppLocalizations.of(context)!.chooseFiles, maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, minFontSize: 5, maxFontSize: 30, stepGranularity: 1, style: Theme.of(context).textTheme.headline3 ))
                    ),
        Spacer(flex:1),
        OutlinedButton(onPressed: _pickFile ,child: Container(alignment: Alignment.center, padding: EdgeInsets.all(10),
                    
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: AutoSizeText("Dateien auswählen", maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, minFontSize: 5, maxFontSize: 30, stepGranularity: 1, style: Theme.of(context).textTheme.headline3 ))
                    
                    ),
        Spacer(flex:2)
      ])
    );
  }
}