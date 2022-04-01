import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share2desktop/chooseFiles.dart';
import 'package:share2desktop/chooseFiles.dart';
import 'package:share2desktop/deviceSelection.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';
import 'dart:convert';
import 'package:share2desktop/main.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

class ConnectionObject extends ChangeNotifier {
  static final ConnectionObject _connector = ConnectionObject._internal();
  factory ConnectionObject() {
    return _connector;
  }

  /// These are all the important variables
  ///
  ///
  /// _channel is the connection to the server, the URL will change to the one of the actual server ofc
  WebSocketChannel _channel = WebSocketChannel.connect(
    //Uri.parse('ws://localhost:8080/socket'),
    Uri.parse('wss://share2desktop-signalling.herokuapp.com/socket'),
  );

  /// peerconnection is a description on how the connection works
  var _peerConnection;

  /// Datachannel is the channel inside peerconnection that sends messages on a p2p basis
  var dataChannel;

  ///the socketid the client wants to / is connected to
  String externalSocketId = "";

  /// the socketid that points to this client
  String internalSocketId = "";

  /// the last message the client has recieved from another client (not the server)
  String lastmessage = "";

  late Map<String, List<dynamic>> buffer;
  //late List<dynamic> buffer;

  //state
  String state = "";
  bool connected = false;
  bool waitingForAnswer = false;
  int _counter = 0;
  //bool empfangen = false;

  @override

  ///Sets up everything at the start of the app
  ConnectionObject._internal() {
    Timer timer = Timer.periodic(Duration(seconds: 15), (Timer t) => ping());
    _peerConnection = null;
    dataChannel = null;
    buffer = Map();

    /// creates peer connection and the underlying datachannel
    _createPeerConnecion().then((pc) {
      _peerConnection = pc;
      _createDataChannel(_peerConnection).then((dataChannel) {
        dataChannel = dataChannel;
      });
    });

    /// listens to messages from the server, the messages from the server are always in a "event" and "data" json object
    /// The "data" json object itself often includes json objects
    _setUpChannelStream();
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
    RTCPeerConnection pc =
        await createPeerConnection(configuration, offerSdpConstraints);

    /// if the client creates an ice candidate on its own, send it to the client you want to connect with immediatly
    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        _createCandidate(e);
      }
    };

    ///If the  connection changes do something
    pc.onIceConnectionState = (e) {
      state = e.toString();
      if (e == RTCIceConnectionState.RTCIceConnectionStateDisconnected) {
        connected = false;
        _disconnect("Client Timed out");
      }
      if (e == RTCIceConnectionState.RTCIceConnectionStateConnected) {
        connected = true;
        print("CONNECTED");
        if (dialogOpen) {
          Navigator.of(navigatorKey.currentContext as BuildContext,
                  rootNavigator: true)
              .pop('dialog');
        }
        Navigator.of(navigatorKey.currentContext as BuildContext)
            .push(MaterialPageRoute(
                builder: (context) => ChooseFiles(
                      targetDeviceName: externalSocketId,
                    )));
      }
      notifyListeners();
    };

    pc.onDataChannel = (e) {
      dataChannel = e;
    };
    return pc;
  }

  /// create a datachannel inside a given peerconnection
  _createDataChannel(RTCPeerConnection pc) async {
    var dataChannel;
    var dataChannelDict = RTCDataChannelInit();
    dataChannel = await pc.createDataChannel('dataChannel', dataChannelDict);

    /// when the datachannel receives a message, do something
    dataChannel.onMessage = (event) async {
      // setEmpfangen(true);
      //aChooseFiles.empfangen = true;
      print("paket empfangen");
      try {
        var decodedJSON = json.decode(event.text) as Map<String, dynamic>;
        //print(decodedJSON['name']);
        // print(decodedJSON['finished']);

        if (decodedJSON['finished']) {
          // print("finished");
          if (!buffer.containsKey(decodedJSON["name"])) {
            print("absent name (small file)");
            await buffer.putIfAbsent(decodedJSON["name"],
                () => List.filled(0, "na", growable: true));
          }

          await buffer.update(
              decodedJSON["name"], (value) => value + decodedJSON["bytes"]);
          if (Platform.isWindows) {
            Directory? downdir = await getDownloadsDirectory();

            File newFile = File(downdir!.path + "\\" + decodedJSON['name']);

            print("file wird geschrieben");

            SmartDialog.showToast(
                "Datei " + decodedJSON["name"] + " wurde gespeichert.");

            await newFile.writeAsBytes(buffer[decodedJSON['name']]!.cast<int>(),
                flush: true);
          } else if (Platform.isMacOS || Platform.isLinux) {
            Directory? downdir = await getDownloadsDirectory();

            File newFile = File(downdir!.path + "/" + decodedJSON['name']);
            print(newFile.toString());

            print("file wird geschrieben");
            SmartDialog.showToast(
                "Datei " + decodedJSON["name"] + " gespeichert.");
            await newFile.writeAsBytes(buffer[decodedJSON['name']]!.cast<int>(),
                flush: true);
          } else if (Platform.isAndroid || Platform.isIOS) {
            
            File newFile;
            if(Platform.isAndroid) {
              newFile = File("/storage/emulated/0/Download/"+decodedJSON['name']);
            } else {
              Directory? downdir = await getApplicationDocumentsDirectory();


              newFile = File(downdir.path + "/" + decodedJSON['name']);
            }
            print(newFile.toString());
            print("file wird geschrieben");

           Fluttertoast.showToast(
                  msg: "Datei " + decodedJSON["name"] + " gespeichert.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);

            await newFile.writeAsBytes(buffer[decodedJSON['name']]!.cast<int>(),
                flush: true);
          }

          if (buffer.containsKey(decodedJSON["name"])) {
            buffer.removeWhere((key, value) => key == decodedJSON['name']);
          }
          //aChooseFiles.empfangen = false;
        } else {
          if (!buffer.containsKey(decodedJSON["name"])) {
            if (Platform.isIOS || Platform.isAndroid) {
              Fluttertoast.showToast(
                  msg: "Datei " + decodedJSON["name"] + " wird empfangen...",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              SmartDialog.showToast(
                  "Datei " + decodedJSON["name"] + " wird empfangen...");
            }
          }
          print("buffer wird geadded");
          await buffer.putIfAbsent(
              decodedJSON["name"], () => List.filled(0, "na", growable: true));
          buffer.update(
              decodedJSON["name"], (value) => value + decodedJSON["bytes"]);
        }
      } on FormatException catch (e) {
        print('The provided string is not valid JSON');
        print("message: ${event.text}");
        lastmessage = event.text;
      }
      notifyListeners();
    };

    return dataChannel;
  }

  connectOffer(String Socketid) async {
    externalSocketId = Socketid;
    notifyListeners();
    var offer = await _peerConnection.createOffer();
    var jsonData = json.encode({
      'sdp': offer.sdp,
      'type': offer.type,
    });
    var jsonString = json.encode({
      'event': "offer",
      'data': jsonData,
    });
    jsonString = _fixNestedJsonString(jsonString);
    _sendToServer(jsonString, externalSocketId);
    _peerConnection.setLocalDescription(offer);
    waitingForAnswer = true;
    notifyListeners();
  }

  _createCandidate(RTCIceCandidate e) async {
    var jsonData = json.encode({
      'candidate': e.candidate,
      'sdpMid': e.sdpMid,
      'sdpMlineIndex': e.sdpMLineIndex,
    });
    print(jsonData + "JSONDATA SENT");
    var jsonString = json.encode({
      'event': 'candidate',
      'data': jsonData,
    });
    //print(jsonString.toString() + "JSONSTRING NOT FIXED");
    jsonString = _fixNestedJsonString(jsonString);
    print(jsonString.toString() + "JSONSTRING FIXED");
    _sendToServer(jsonString, externalSocketId);
  }

  createAnswer() async {
    var answer = await _peerConnection.createAnswer();
    _peerConnection.setLocalDescription(answer);
    String answerData = json.encode({
      'sdp': answer.sdp,
      'type': answer.type,
    });
    var jsonString = json.encode({
      'event': "answer",
      'data': answerData.toString(),
    });
    jsonString = _fixNestedJsonString(jsonString);
    _sendToServer(jsonString, externalSocketId);
  }

  _handleoffer(offer, id) async {
    externalSocketId = id;
    _peerConnection.setRemoteDescription(
        RTCSessionDescription(offer['sdp'], offer['type']));
    if (dialogOpen) {
      Navigator.of(navigatorKey.currentContext as BuildContext,
              rootNavigator: true)
          .pop('dialog');
    }
    acceptRejectConnection(externalSocketId);
  }

  sendDisconnectRequest(String reason) {
    var jsonString = json.encode({
      'event': "disconnect",
      'reason': reason,
    });
    _sendToServer(jsonString, externalSocketId);
    _disconnect("chosen");
  }

  _sendToServer(var message, String id) {
    var messageDestination = json.encode({
      'destination': id,
      'message': message,
    });
    messageDestination = _fixNestedJsonString(messageDestination);
    _channel.sink.add(messageDestination);
  }

  ping() {
    _channel.sink.add("Ping");
  }

  /// Json string Shenanigans
  String _fixNestedJsonString(String jsonString) {
    jsonString = jsonString.replaceAll(RegExp(r'(?<![\\])\\(?![\\])'), "");
    jsonString = jsonString.replaceAll("\\\\", "\\");
    jsonString = jsonString.replaceAll("\"{", "{");
    jsonString = jsonString.replaceAll("}\"", "}");
    return jsonString;
  }

  /// Disconnects the current client, Doesnt send a message to the client yet, only disconnects (the client pings anyways and disconnects itself after ~ 5 sec)
  /// It disconnects by simply setting the peerconnection and datachannel to its "blank" state
  ///
  ///
  void _disconnect(String reason) async {
    try {
      print("DISCONNECTING");
      connected = false;
      waitingForAnswer = false;
      await dataChannel?.close();
      await _peerConnection?.close();
      _peerConnection = null;
      await _createPeerConnecion().then((pc) {
        _peerConnection = pc;
        _createDataChannel(_peerConnection).then((dataChannel) {
          dataChannel = dataChannel;
        });
      });
      externalSocketId = "";
      notifyListeners();
      Navigator.of(navigatorKey.currentContext as BuildContext)
          .push(MaterialPageRoute(builder: (context) => DeviceSelection()));
      if (reason != "chosen") {
        disconnectPopup(reason);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _setUpChannelStream() {
    _channel.stream.listen((message) {
      Map<String, dynamic> content = jsonDecode(message);
      var data = content['data'];
      print(content['event']);
      switch (content['event']) {

        /// Answer sent by client via server, sets up a connection
        case "answer":
          {
            if (content['id'] == externalSocketId) {
              waitingForAnswer = false;
              _peerConnection.setRemoteDescription(
                  RTCSessionDescription(data['sdp'], data['type']));
            }
          }
          break;

        /// an Ice candidate sent by a client via server, adds the candidate to its pool (Ice candidate = description of how to get to any given client)
        case "candidate":
          {
            print(message.toString() + "MESSAGE RECEIVD");
            print(data.toString() + "DATA RECEIVED");
            _peerConnection.addCandidate(RTCIceCandidate(
                data['candidate'], data['sdpMid'], data['sdpMlineIndex']));
          }
          break;

        /// right now in case of an offer it simply immediatly sends an answer
        case "offer":
          {
            if (externalSocketId == "") {
              _handleoffer(data, content['id']);
            }
          }
          break;

        /// A message sent directly by the server, includes the socketId of the client who received the message
        case "socketId":
          {
            internalSocketId = data['id'];
            break;
          }

        /// a message directly by the Server, in case the client (somehow) enters a Socket ID that no longer exists.
        case "wrongId":
          {
            _disconnect("Falsche ID!");
            break;
          }
        case "disconnect":
          {
            if (content['id'] == externalSocketId) {
              _disconnect(content['reason']);
            }
            break;
          }
        default:
          {
            print("this event (${content['event']}) isnt valid!");
          }
          break;
      }
      notifyListeners();
    });
  }
}
