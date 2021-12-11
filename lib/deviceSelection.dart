import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share2desktop/chooseFiles.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DeviceSelection extends StatefulWidget {
  const DeviceSelection({Key? key}) : super(key: key);

  @override
  _DeviceSelection createState() => _DeviceSelection();
}

class _DeviceSelection extends State<DeviceSelection> {
  //bool isSwitched = false;
  Object? selectedDevice = null;
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  Future<void> _aboutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Über die App", style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                Text("Von Team Share2Desktop"),
                RichText(text: new TextSpan(
                  text: 'share2desktop.com',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch('http://share2desktop.com/');
                  },)),
                
                Text("2021-12-11")
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> _qrDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Dein QR-Code', style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                Image(
                    image: AssetImage("assets/qrtest.png"),
                    alignment: Alignment.center,
                    width: 400),
              ],
            ),
          ),
        );
      },
    );
  }

   Future<void> _selectTheme() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Wähle ein Theme', style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                TextButton(child: Text("Helles Erscheinungsbild"), onPressed: () {AdaptiveTheme.of(context).setLight();}),
                SizedBox(height: 10),
                TextButton(child: Text("Dunkles Erscheinungsbild"), onPressed: () {AdaptiveTheme.of(context).setDark();}),
    
                //TextButton(child: Text("mspaint"), onPressed:  () {_notifier.value = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light}),
              ],
            ),
          ),
        );
      },
      
    );
  }

  final names = ['Lennarts Desktop', 'Jonas Google Pixel 3', 'iPhone SE von David', 'Sebis Laptop','Christians MacBook Pro','Denis PCs','Alex Computer'];

  final subtitles = ['12.34.56.78', '12.34.56.78', '12.34.56.78', '12.34.56.78','12.34.56.78', '12.34.56.78','12.34.56.78'];

  final icons = [
    Icons.computer,
    Icons.computer,
    Icons.phone_iphone,
    Icons.phone_iphone,
    Icons.computer,
    Icons.phone_iphone,
    Icons.phone_iphone,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Text('Share2Desktop'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: const Text('Einstellungen'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.visibility),
                title: const Text('Aussehen'),
                onTap: () {
                
                  _selectTheme();
                  //Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: const Text('Über die App'),
                onTap: () {
                  _aboutDialog();
                  //das pop würden den dialog deleten
                  //Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: new AppBar(title: new Text("Share2Desktop")),
        
        body: Column(children: [
          //Einstellungen
          /*Row(
            children: [
              Spacer(flex: 1),
              Container(
                  //width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.all(30),
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    child: Row(children: [
                      Icon(Icons.qr_code),
                      SizedBox(width: 10),
                      Text("Dein Gerät", style: Theme.of(context).textTheme.headline4),
                    ]),
                    onPressed: () => {_qrDialog()},
                  )),
              Spacer(flex: 1)
            ],
          ),*/
          SizedBox(height: 20),
          Row(
            children: [
              Spacer(flex: 1),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.all(10),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16))),
                    child: Row(children: [
                      
                      Icon(Icons.qr_code),
                      SizedBox(width: 10),
                      Text("Dein Gerät", style: Theme.of(context).textTheme.headline4),
                    ]),
                    onPressed: () => {_qrDialog()},

                    ),
                    Expanded(
      child: IconButton(onPressed: () => (print("camera")), iconSize: 40.0, icon: Icon(Icons.photo_camera)),
      ),
                    
                    
                    ],)
                    
                    
                  ),

                  
              Spacer(flex: 1)
            ],
          ),

          //Abstand
          Spacer(flex: 1),
          Text("Geräte in der Nähe: ",style: Theme.of(context).textTheme.headline2),
          SizedBox(height:20),
          Container(
              padding: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: names.length,
                itemExtent: MediaQuery.of(context).size.height * 0.125,
                itemBuilder: (context, index) {
                  return Card(
                    //                           <-- Card widget
                    child: ListTile(
                        //leading: Column(mainAxisAlignment: MainAxisAlignment.center, children: [(Icon(icons[index]))]),
                        title: Row(
                          
                          mainAxisAlignment: MainAxisAlignment.center, 
                          children: [
                            
                          

                            
                            /*Icon(icons[index]), SizedBox(width: 30),*/ Text(names[index], style: Theme.of(context).textTheme.headline3)/*, SizedBox(width: 30)*/
                            ]),
                        //subtitle: Text(subtitles[index]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChooseFiles(
                                    targetDeviceName: names[index],
                                  )));
                        }),
                  );
                },
              )),
          //Row(children: [
          //SizedBox(width: 100),
          /*Container(
            
              padding: EdgeInsets.all(50),
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  //https://protocoderspoint.com/flutter-listview-ontap-selected-item-send-data-to-new-screen/
                  //Weiter button weg und einfach wen man device wählt weiter
                  //jo das passt mal wir brauchen noch dynamisches adden dieser dinger damit das workt

                  ListTile(
                      leading: const Icon(Icons.computer),
                      title: const Text("Computer 1"),
                      subtitle: Text("Windows-PC von JUMBO"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChooseFiles(
                                  targetDeviceName: 'computer 1',
                                )));
                      }),
                  ListTile(
                      leading: const Icon(Icons.computer),
                      title: const Text("Computer 2"),
                      subtitle: Text("Windows-PC von Schreiner"),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChooseFiles(
                                  targetDeviceName: 'computer 2',
                                )));
                      }),
                  ListTile(
                      leading: const Icon(Icons.phone_iphone),
                      title: const Text("Smartphone"),
                      subtitle: Text("iPhone von Fabian"),
                      onTap: () {
                        print("bc 1");
                      }),
                  ListTile(
                      leading: const Icon(Icons.phone_iphone),
                      title: const Text("Smartphone"),
                      subtitle: Text("iPhone SE von Lennart"),
                      onTap: () {
                        print("bc 1");
                      }),
                  ListTile(
                      leading: const Icon(Icons.phone_iphone),
                      title: const Text("Smartphone"),
                      subtitle: Text("iPhone 12 von Lennart"),
                      onTap: () {
                        print("bc 1");
                      }),
                ],
              )),

          //],

          //),*/
          SizedBox(height: 20),
          /*OutlinedButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseFiles()),
                    )
                  },
              child: Text("Weiter"))*/
          Spacer(flex: 1),
        ]));
  }
}
