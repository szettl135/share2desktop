import 'package:flutter/material.dart';
import 'package:share2desktop/chooseFiles.dart';

class DeviceSelection extends StatefulWidget {
  const DeviceSelection({Key? key}) : super(key: key);

  @override
  _DeviceSelection createState() => _DeviceSelection();
}

class _DeviceSelection extends State<DeviceSelection> {
  //bool isSwitched = false;
  Object? selectedDevice = null;
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);

  Future<void> _qrDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Dein QR-Code'),
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
              children: const <Widget>[
                Text('Wähle ein Theme'),
                SizedBox(height: 20),
                //TextButton(child: Text("mspaint"), onPressed:  () {_notifier.value = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light}),
              ],
            ),
          ),
        );
      },
    );
  }

  final names = ['computer1', 'computer2', 'handy1', 'handy2','hatzer pc1','hatzerphone 5','yeeeet'];

  final subtitles = ['bumbo sein pc', 'jumbos computer', 'xd', 'yeet','xd', 'yeet','yought'];

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
                
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: const Text('Über die App'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: new AppBar(title: new Text("Share2Desktop")),
        
        body: Column(children: [
          //Einstellungen
          Row(
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
                      Text("Dein Gerät", style: Theme.of(context).textTheme.bodyText2),
                    ]),
                    onPressed: () => {_qrDialog()},
                  )),
              Spacer(flex: 1)
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Spacer(flex: 1),
              Container(
                  //width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: OutlinedButton(
                    child: Row(children: [
                      Icon(Icons.camera),
                      SizedBox(width: 10),
                      Text("QR Code einscannen", style: Theme.of(context).textTheme.bodyText1),
                    ]),
                    onPressed: () => {print("QR Code einscannen")},
                  )),
              Spacer(flex: 1)
            ],
          ),

          //Abstand
          Spacer(flex: 1),
          Container(
              padding: EdgeInsets.all(8),
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return Card(
                    //                           <-- Card widget
                    child: ListTile(
                        leading: Icon(icons[index]),
                        title: Text(names[index]),
                        subtitle: Text(subtitles[index]),
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
