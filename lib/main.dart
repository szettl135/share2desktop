import 'package:flutter/material.dart';
import 'package:share2desktop/smokinOnThat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share2Desktop',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        //primarySwatch: Colors.blue,
        // Define the default brightness and colors.
   
    ),
  
      
      home: Programm(),
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/*class _MyHomePageState extends State<MyHomePage> {
  
   bool _loadingButton1 = false;
  bool _loadingButton2 = false;
  bool switchListTileValue = false;

 

  /*@override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF5F79FF),
        automaticallyImplyLeading: true,
        title: Text(
          'Share2Desktop',
          
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      drawer: Drawer(
        elevation: 16,
        child: SwitchListTile(
          value: switchListTileValue ??= false,
          onChanged: (newValue) =>
              setState(() => switchListTileValue = newValue),
          title: Text(
            'Dark Mode',
            //style: FlutterFlowTheme.title3,
          ),
          subtitle: Text(
            'turns on dark mode',
            /*style: FlutterFlowTheme.subtitle2.override(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),*/
          ),
          tileColor: Color(0xFFF5F5F5),
          dense: false,
          controlAffinity: ListTileControlAffinity.trailing,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Einstellungen',
                    /*style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                    ),*/
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                    child: Icon(
                      Icons.settings_outlined,
                      color: Colors.black,
                      size: 24,
                    ),
                  )
                ],
              ),
            ),
            Spacer(flex: 3),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: Container(
                width: 150,
                height: 150,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/27/600',
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              child: Text(
                'Share2Desktop',
                /*style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  fontSize: 35,
                ),*/
              ),
            ),
            Spacer(flex: 2),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
              child: TextButton(
                onPressed: null,
                child: Text("Pa Brate")
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
              child: TextButton(
                onPressed: null,
                child: Text("Pa Brate")
              ),
            ),
            Spacer(flex: 5)
          ],
        ),
      ),
    );
  }
}
