
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:share2desktop/receiveFiles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

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

  
  late List<File> _files = [];
  final icons = [
    Icons.computer,
    Icons.computer,
    Icons.phone_iphone,
    Icons.phone_iphone,
    Icons.computer,
    Icons.phone_iphone,
    Icons.phone_iphone,
    Icons.phone_iphone,
    Icons.phone_iphone
  ];

  void _pickFile() async {
      
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    //_files = await FilePicker.platform.pickFiles(allowMultiple: true);
  
    // if no file is picked
    if (_files == null) return;

    if (result != null) {
      //files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        _files = result.paths.map((path) => File(path!)).toList();
      });
    } else {
      // User canceled the picker
    }
  
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    // print(_files!.files.first.name);
    // print(_files!.files.first.size);
    // print(_files!.files.first.path);
    // print(_files!.count);
    // print(_files!.files[0]);
    
  }

  Widget _buildRow(String pair) {
     return ListTile(
       title: Text(
         pair,
       ),
     );
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
        Spacer(flex:2),
        Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: _files.length,
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
                    child: ListTile(
                        leading: Container(
                            height: double.infinity, child: Icon(icons[index])),
                        trailing: Container(
                            height: double.infinity,
                            child: Icon(Icons.arrow_right_alt)),
                        title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: AutoSizeText(
                                        basename(_files[index].path),
                                        //style: Theme.of(context)
                                        //.textTheme
                                        // .headline3,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        //maxLines: 3,
                                        maxLines: 1,
                                        //presetFontSizes: [25, 15, 5],
                                        //minFontSize: 0,
                                        group: devicesGroup,
                                        //overflowReplacement: Text(names[index].substring(0,2)+"..."),
                                        maxFontSize: 25,
                                        stepGranularity: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              )

                              /*Icon(icons[index]), SizedBox(width: 30),*/ /*, SizedBox(width: 30)*/
                            ]),
                        //subtitle: Text(subtitles[index]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChooseFiles(
                                    targetDeviceName: _files[index].toString(),
                                  )));
                        }),
                  );
                },
              )),
        
      ])
    );
  }
}