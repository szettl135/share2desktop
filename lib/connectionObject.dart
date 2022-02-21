import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';
import 'dart:convert';




class ConnectionObject {
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

  //state
  String _state = "";

  int _counter = 0;
  /// sends a message to the client it is connected to with a "hello" and a counter that keeps updating to make sure the messages are the right ones and in order
  void _incrementCounter() {
      _counter++;
      print('AAAAA $_counter');
      dataChannel.send(RTCDataChannelMessage('Hello! $_counter'));
  
  }

/// Disconnects the current client, Doesnt send a message to the client yet, only disconnects (the client pings anyways and disconnects itself after ~ 5 sec)
/// It disconnects by simply setting the peerconnection and datachannel to its "blank" state
///
///
void _disconnect() async {
    try {
      await _peerConnection?.close();
      await dataChannel.close();
      _peerConnection = null;
      await _createPeerConnecion().then((pc) {
        _peerConnection=pc;
        _createDataChannel(_peerConnection).then((dataChannel) {
          dataChannel = dataChannel;
        });
      });
    
    } catch (e) {
      print(e.toString());
    }
    
  }
  
  @override
  ///Sets up everything at the start of the app
  ConnectionObject() {
    /// creates peer connection and the underlying datachannel
    _createPeerConnecion().then((pc) {
      _peerConnection = pc;
      _createDataChannel(_peerConnection).then((dataChannel) {
        dataChannel = dataChannel;
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
            internalSocketId=data['id'];
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
      _state= e.toString();
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
    dataChannel.onMessage = (event) {
        print("message: ${event.text}");
        lastmessage = event.text;
    };
    

    return dataChannel;
  }


connectOffer(String Socketid) async {
    externalSocketId = Socketid;
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
      jsonString,externalSocketId
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
  _sendToServer(jsonString,externalSocketId);
}

createAnswer(answer) {
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
      jsonString,externalSocketId
  );
}
_handleoffer(offer,id) async {
  _peerConnection.setRemoteDescription(RTCSessionDescription(offer['sdp'],offer['type']));
  var answer = await _peerConnection.createAnswer();
  _peerConnection.setLocalDescription(answer);
  createAnswer(answer);
}

sendDisconnectRequest(String reason) {
  var jsonString = json.encode({
      'event' : "disconnect",
      'reason': reason,
    });
  _sendToServer(jsonString, externalSocketId);
}

_sendToServer(var message, String id) {
  var messageDestination = json.encode({
      'destination' : id,
      'message'    : message,
    });
  messageDestination = _fixNestedJsonString(messageDestination);
  _channel.sink.add(messageDestination);
}

getInternalSocketid() {
  _channel = WebSocketChannel.connect(
    //Uri.parse('ws://localhost:8080/socket'),
    Uri.parse('wss://share2desktop-signalling.herokuapp.com/socket'),
  );
}


/// Json string Shenanigans
String _fixNestedJsonString(String jsonString) {
  jsonString = jsonString.replaceAll(RegExp(r'(?<![\\])\\(?![\\])'),"");
  jsonString = jsonString.replaceAll("\\\\","\\");
  jsonString = jsonString.replaceAll("\"{","{");
  jsonString = jsonString.replaceAll("}\"","}");
  return jsonString;
}








}
