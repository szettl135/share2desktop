import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share2desktop/deviceSelection.dart';

class ConnectionLost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            appBar: new AppBar(title: new Text("Share2Desktop"),leading: IconButton(icon:Icon(Icons.home),
            onPressed:() =>  Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DeviceSelection())))),
            body: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: AutoSizeText(
                          AppLocalizations.of(context)!.connectionLost,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 16,
                          maxFontSize: 30,
                          stepGranularity: 1,
                          style: Theme.of(context).textTheme.headline3)),

                  OutlinedButton(onPressed: ()=>{} ,child: Container(alignment: Alignment.center, padding: EdgeInsets.all(10),
                    
                    width: MediaQuery.of(context).size.width * 0.60,
                    child:  Container(alignment: Alignment.center, width: MediaQuery.of(context).size.width * 0.50,
                  child:AutoSizeText(AppLocalizations.of(context)!.reconnect, maxLines: 1, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, minFontSize: 12, maxFontSize: 25, stepGranularity: 1, style: Theme.of(context).textTheme.headline4 ))),
                  )

                ]))));
  }
}
