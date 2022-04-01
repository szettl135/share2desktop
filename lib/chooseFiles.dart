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
  aChooseFiles createState() => aChooseFiles();
}

class aChooseFiles extends State<ChooseFiles> {
  var devicesGroup = AutoSizeGroup();
  var buttonsGroup = AutoSizeGroup();
  late List<File> _files = [];

  @override
  Widget build(BuildContext context) {
    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          onPressed: _clearFiles,
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.075,
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
                height: MediaQuery.of(context).size.height * 0.075,
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

    return WillPopScope(
        onWillPop: () {
          Provider.of<ConnectionObject>(context, listen: false)
              .sendDisconnectRequest("User hat die Verbindung getrennt!");
          //trigger leaving and use own data
          Navigator.pop(context, false);

          //we need to return a future
          return Future.value(false);
        },
        child: Scaffold(
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

              // (empfangen)? Spacer(flex:1) : SizedBox(height:10),
              //  (empfangen)? Text("Eine Datei wird gerade übertragen..."): Text("Gerade wird nichts empfangen."),
              SizedBox(height: 20),
              Spacer(flex: 2),
              OutlinedButton(
                  onPressed: _pickFile,
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: AutoSizeText(
                          AppLocalizations.of(context)!.chooseFiles,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 5,
                          maxFontSize: 30,
                          stepGranularity: 1,
                          style: Theme.of(context).textTheme.headline3))),
              Spacer(flex: 2),
              Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.33,
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
                                height: double.infinity,
                                child: Icon(Icons.insert_drive_file_outlined)),
                            trailing: Container(
                                height: double.infinity,
                                child: Icon(Icons.highlight_remove)),
                            title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          child: AutoSizeText(
                                            basename(
                                                _files[index].path.toString()),
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
                              _deleteFile(index);
                            }),
                      );
                    },
                  )),
              buttonSection,
              Spacer(flex: 1),
              SizedBox(height: MediaQuery.of(context).size.width * 0.02)
            ])));
  }

  void _pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        for (PlatformFile file in result.files) {
          for (File u in _files) {
            if (u.path == file.path) {
              _files.remove(u);
              break;
            }
          }
          ;
        }
        _files.addAll(result.paths.map((path) => File(path!)).toList());
      });
    } else {
      // User canceled the picker
    }
  }

  void _clearFiles() async {
    setState(() {
      _files.clear();
    });
  }

  void _deleteFile(int index) async {
    setState(() {
      _files.removeAt(index);
    });
  }

  int packSize = 65536;
  Future<void> waitingForFile() async {
    dialogOpen = true;
    return showDialog<void>(
      context: navigatorKey.currentContext as BuildContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text("Daten werden gesendet...",
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 30),
                    Center(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            height: MediaQuery.of(context).size.width * 0.1,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              color: Theme.of(context)
                                  .primaryColor, //Colors.purple,
                              strokeWidth: 10,
                            ))),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ));
      },
    ).then((value) => dialogOpen = false);
  }

  void _sendFile() async {
    waitingForFile();
    for (File file in _files) {
      print('file: ' + basename(file.path));
      var fileBytes = await file.readAsBytes();

      var data = jsonEncode({"name": basename(file.path), "bytes": fileBytes});

      int size = fileBytes.length;
      int speed = 60;
      if (size >= 10000) {
        speed = 200;
      }
      for (int i = 0; i < size;) {
        if ((size - i) >= packSize) {
          data = jsonEncode({
            "name": basename(file.path),
            "bytes": fileBytes.sublist(i, i + packSize),
            "finished": false
          });
          //print('big enough: ' + i.toString());
        } else {
          data = jsonEncode({
            "name": basename(file.path),
            "bytes": fileBytes.sublist(i),
            "finished": true
          });
          //print('to big: ' + i.toString());
        }
        await Future.delayed(Duration(milliseconds: speed), () {});
        await Provider.of<ConnectionObject>(
                navigatorKey.currentContext as BuildContext,
                listen: false)
            .dataChannel
            .send(RTCDataChannelMessage(data));
        i = i + packSize;
        //print('Current i: ' + i.toString());
      }
    }
    setState(() {
      _clearFiles();
    });
    if (dialogOpen) {
      Navigator.of(navigatorKey.currentContext as BuildContext,
              rootNavigator: true)
          .pop('dialog');
    }
  }
}
