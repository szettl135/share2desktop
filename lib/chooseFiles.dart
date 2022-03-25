import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/provider.dart';
import 'package:share2desktop/connectionObject.dart';
import 'package:share2desktop/main.dart';
import 'package:share2desktop/receiveFiles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/foundation.dart';

class ChooseFiles extends StatefulWidget {
  final String targetDeviceName;
  //https://pub.dev/packages/device_info

  const ChooseFiles({Key? key, required this.targetDeviceName})
      : super(key: key);

  @override
  _ChooseFiles createState() => _ChooseFiles();
}

class _ChooseFiles extends State<ChooseFiles> {
  var devicesGroup = AutoSizeGroup();
  var buttonsGroup = AutoSizeGroup();

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
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    //_files = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      //files = result.paths.map((path) => File(path!)).toList();
      setState(() {
        //_files = result.paths.map((path) => File(path!)).toList();
        _files.addAll(result.paths.map((path) => File(path!)).toList());

        //var existingItem = _files.firstWhere((result) => result..link == _files., orElse: () => null);
      });
    } else {
      // User canceled the picker
    }
  }

  void _clearFile() async {
    setState(() {
      //_files = result.paths.map((path) => File(path!)).toList();
      _files.clear();
    });
  }

  void _sendFile() async {
    print('test');
    for (File file in _files) {
      print('file: ' + basename(file.path));
      var fileBytes = await file.readAsBytes();

      var data = jsonEncode(
          {"name": basename(file.path), "bytes": fileBytes as Uint8List});

      int size = fileBytes.length;
      print(size);
      for (int i = 0; i < size;) {
        print(i);
        if ((size - i) > 64) {
          var data = jsonEncode({
            "name": basename(file.path),
            "bytes": fileBytes.sublist(i, i + 64) as Uint8List,
            'finished': "false"
          });
        } else {
          var data = jsonEncode({
            "name": basename(file.path),
            "bytes": fileBytes.sublist(i) as Uint8List,
            'finished': "true"
          });
        }
        print("going to send");
        Provider.of<ConnectionObject>(
                navigatorKey.currentContext as BuildContext,
                listen: false)
            .dataChannel
            .send(RTCDataChannelMessage(data));
        i = i + 64;
      }

      print('file should be sent');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          onPressed: _clearFile,
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.40,
              child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: AutoSizeText(AppLocalizations.of(context)!.clear,
                      group: buttonsGroup,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 5,
                      maxFontSize: 30,
                      stepGranularity: 1,
                      style: Theme.of(context).textTheme.headline3))),
        ),
        OutlinedButton(
            onPressed: () => {
                  _sendFile()
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ReceiveFiles()),
                  // )
                },
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.40,
                child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: AutoSizeText(AppLocalizations.of(context)!.continuee,
                        maxLines: 1,
                        group: buttonsGroup,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 5,
                        maxFontSize: 30,
                        stepGranularity: 1,
                        style: Theme.of(context).textTheme.headline3)))),
      ],
    );

    return Scaffold(
        appBar: new AppBar(title: new Text("Share2Desktop")),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Row(
              //mainAxisAlignment:MainAxisAlignment.center ,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                //SizedBox(width: 20),
                //Spacer(flex:3),
                Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: AutoSizeText(
                              AppLocalizations.of(context)!.yourDevice,
                              style: Theme.of(context).textTheme.headline4,
                              group: devicesGroup,
                              maxLines: 1,
                              minFontSize: 5,
                              maxFontSize: 30,
                              stepGranularity: 1,
                              overflow: TextOverflow.ellipsis)),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                //Spacer(flex:1),
                SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                //SizedBox(width: MediaQuery.of(context).size.width * 0.125),
                Icon(Icons.arrow_forward),
                SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                //Spacer(flex:1),
                //SizedBox(width: MediaQuery.of(context).size.width * 0.125),
                Container(
                  alignment: Alignment.topCenter,
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height:10),
                      //Text("Zum Gerät:",style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 10),
                      Icon(
                        Icons.computer,
                        size: 30.0,
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: AutoSizeText(
                          widget.targetDeviceName,
                          textAlign: TextAlign.center,
                          group: devicesGroup,
                          maxLines: 1,
                          minFontSize: 5,
                          maxFontSize: 25,
                          stepGranularity: 1,
                          style: Theme.of(context).textTheme.headline4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
                //SizedBox(width: 20)
                Spacer()
                //Spacer(flex:3)
              ],
            ),
          ),
          Spacer(flex: 2),
          OutlinedButton(
              onPressed: _pickFile,
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: AutoSizeText(AppLocalizations.of(context)!.chooseFiles,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 5,
                      maxFontSize: 30,
                      stepGranularity: 1,
                      style: Theme.of(context).textTheme.headline3))),
          Spacer(flex: 4),
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
                                        basename(_files[index].path.toString()),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        group: devicesGroup,
                                        maxFontSize: 25,
                                        stepGranularity: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                ],
                              )
                            ]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChooseFiles(
                                    targetDeviceName: _files[index].toString(),
                                  )));
                        }),
                  );
                },
              )),
          buttonSection,
          Spacer(flex: 1)
          //SizedBox(height: MediaQuery.of(context).size.width * 0.02)
        ]));
  }
}
