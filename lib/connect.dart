import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';
import 'dart:convert';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
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

class _MyHomePageState extends State<MyHomePage>with WidgetsBindingObserver {
  /// These are all the important variables
  ///
  ///
  /// _channel is the connection to the server, the URL will change to the one of the actual server ofc
  final _channel = WebSocketChannel.connect(
    //Uri.parse('ws://localhost:8080/socket'),
    Uri.parse('wss://share2desktop-signalling.herokuapp.com/socket'),
  );
  /// peerconnection is a description on how the connection works
  var _peerConnection;
  /// Datachannel is the channel inside peerconnection that sends messages on a p2p basis
  var _dataChannel;

  ///the socketid the client wants to / is connected to
  String tryToConnectSocketId ="";
  String externalSocketId = "";

  /// the socketid that points to this client
  String internalSocketId = "";

  ///unimportant
  int _counter = 0;

  /// the last message the client has recieved from another client (not the server)
  String _lastmessage = "";

  /// the state of the connection (connected, waiting, checking, disconnected)
  String _state = "";

  /// sends a message to the client it is connected to with a "hello" and a counter that keeps updating to make sure the messages are the right ones and in order
  void _incrementCounter() {
    
  setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print('AAAAA $_counter');
      _dataChannel.send(RTCDataChannelMessage('Hello! $_counter'));
    });
  
  }

/// Disconnects the current client, Doesnt send a message to the client yet, only disconnects (the client pings anyways and disconnects itself after ~ 5 sec)
/// It disconnects by simply setting the peerconnection and datachannel to its "blank" state
///
///
void _disconnect() async {
    try {
      await _peerConnection?.close();
      await _dataChannel.close();
      _peerConnection = null;
      await _createPeerConnecion().then((pc) {
        _peerConnection=pc;
        _createDataChannel(_peerConnection).then((dataChannel) {
          _dataChannel = dataChannel;
        });
      });
    
    } catch (e) {
      print(e.toString());
    }
    
  }
  
  @override
  ///Sets up everything at the start of the app
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    /// creates peer connection and the underlying datachannel
    _createPeerConnecion().then((pc) {
      _peerConnection = pc;
      _createDataChannel(_peerConnection).then((dataChannel) {
        _dataChannel = dataChannel;
      });  
    });
    /// listens to messages from the server, the messages from the server are always in a "event" and "data" json object
    /// The "data" json object itself often includes json objects
    _channel.stream.listen((message) {
      Map<String, dynamic> content = jsonDecode(message);
      print(message);
      var data = content['data'];
      switch(content['event']) { 
          /// Answer send by client via server, sets up a connection
          case "answer": {
             _peerConnection.setRemoteDescription(RTCSessionDescription(data['sdp'],data['type']));
          } 
          break; 
          /// an Ice candidate sent by a client via server, adds the candidate to its pool (Ice candidate = description of how to get to any given client)
          case "candidate":{  
            _peerConnection.addCandidate(RTCIceCandidate(data['candidate'],data['sdpMid'],data['sdpMlineIndex']));
          }
          break;

          /// right now in case of an offer it simply immediatly sends a client
          case "offer": {
            _handleoffer(data,content['id']);
          }
          break;

          /// A message sent directly by the server, includes the socketId of the client who received the message
          case "socketId": {
            setState(() {internalSocketId=data['id'];});
            break;
          }
          /// a message directly by the Server, in case the client (somehow) enters a Socket ID that no longer exists.
          case "wrongId": {
            _disconnect();
            break;
          }
          default: { print("this event (${content['event']}) isnt valid!"); } 
          break; 
      } 
    }); 
  }
   @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

/// creates a peer connection, and configures it
  _createPeerConnecion() async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"},
      ]
    };
    /// the constraint might change to fit the actual message contents
    final Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      },
      "optional": [],
    };
    RTCPeerConnection pc = await createPeerConnection(configuration, offerSdpConstraints);

    /// if the client creates an ice candidate on its own, send it to the client you want to connect with immediatly
    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        _createCandidate(e);
        
      }
    };
    ///If the  connection changes (disconnects most likely) do something
    pc.onIceConnectionState = (e) {
      if(e==RTCIceConnectionState.RTCIceConnectionStateDisconnected) {
        _disconnect();
      }
      print(e.toString());
      setState(() {
      _state= e.toString();
      });
    };

    pc.onDataChannel = (e) {
        _dataChannel = e;
  	};
    return pc;
  }

  /// create a datachannel inside a given peerconnection
  _createDataChannel(RTCPeerConnection pc) async {
    var dataChannel;
    var _dataChannelDict = RTCDataChannelInit();
    dataChannel = await pc.createDataChannel('dataChannel', _dataChannelDict);

    /// when the datachannel receives a message, do something
    dataChannel.onMessage = (event) {
        print("message: ${event.text}");
        setState(() {
          _lastmessage = event.text;
        });
    };
    

    return dataChannel;
  }


_createOffer() async {
    var offer = await _peerConnection.createOffer();
    var jsonData = json.encode({
        'sdp' : offer.sdp,
        'type' : offer.type,
      });
    var jsonString = json.encode({
        'event' : "offer",
        'data'  : jsonData,
      });
    jsonString = _fixNestedJsonString(jsonString);
    _sendToServer(
      jsonString,tryToConnectSocketId
    );
    _peerConnection.setLocalDescription(offer);
}

_createCandidate(RTCIceCandidate e) async {
  var jsonData = json.encode({
    'candidate':e.candidate,
    'sdpMid':e.sdpMid,
    'sdpMlineIndex':e.sdpMLineIndex,
  });
  var jsonString = json.encode({
          'event' : 'candidate',
          'data'  : jsonData,
        });
  
  jsonString = _fixNestedJsonString(jsonString);
  _sendToServer(jsonString,tryToConnectSocketId);
}

_createAnswer(answer) {
  String answerData = json.encode({
        'sdp' : answer.sdp,
        'type' : answer.type,
      });
  var jsonString = json.encode({
      'event' : "answer",
      'data'  : answerData.toString(),
    });
  jsonString = _fixNestedJsonString(jsonString);
  _sendToServer(
      jsonString,tryToConnectSocketId
  );
}
_handleoffer(offer,id) async {
  _peerConnection.setRemoteDescription(RTCSessionDescription(offer['sdp'],offer['type']));
  var answer = await _peerConnection.createAnswer();
  _peerConnection.setLocalDescription(answer);
  _createAnswer(answer);
}

_sendDisconnectRequest(String reason) {
  var jsonString = json.encode({
      'event' : "disconnect",
      'reason': reason,
    });
  _sendToServer(jsonString, tryToConnectSocketId);
}

_sendToServer(var message, String id) {
  var messageDestination = json.encode({
      'destination' : id,
      'message'    : message,
    });
  messageDestination = _fixNestedJsonString(messageDestination);
  _channel.sink.add(messageDestination);
}




/// Json string Shenanigans
String _fixNestedJsonString(String jsonString) {
  jsonString = jsonString.replaceAll(RegExp(r'(?<![\\])\\(?![\\])'),"");
  jsonString = jsonString.replaceAll("\\\\","\\");
  jsonString = jsonString.replaceAll("\"{","{");
  jsonString = jsonString.replaceAll("}\"","}");
  return jsonString;
}








  
  @override
  Widget build(BuildContext context)  {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SelectableText(
              '$internalSocketId'
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Last Message',
            ),
            Text(
              '$_lastmessage',
              style: Theme.of(context).textTheme.headline4,
            ),
            const Text(
              'Current State',
            ),
            Text(
              '$_state',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField (  
              onChanged: (text) {  
                tryToConnectSocketId = text;  
              }, 
              decoration: InputDecoration(  
                border: InputBorder.none,  
                labelText: 'Enter user connect',  
                hintText: 'Connected user'  
              ),  
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      FloatingActionButton(
        child: Icon(
          Icons.local_offer
        ),
        tooltip: 'createoffer',
        onPressed: _createOffer,
        heroTag: null,
      ),
      SizedBox(
        height: 10,
      ),
      FloatingActionButton(           
        child: Icon(
          Icons.add
        ),
        tooltip: 'sendmessage',
        onPressed: _incrementCounter,
        heroTag: null,
      ),
      FloatingActionButton(           
        child: Icon(
          Icons.delete
        ),
        tooltip: 'closeconnection',
        onPressed: _disconnect,
        heroTag: null,
      )
    ]
  )
    );
  }
}
