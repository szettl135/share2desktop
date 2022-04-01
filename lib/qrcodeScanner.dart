import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:share2desktop/connectionObject.dart';
import 'package:provider/provider.dart';
import 'package:share2desktop/main.dart';

class QRCodeScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            final String code = barcode.rawValue.toString();
            debugPrint('Barcode found! $code');
            Navigator.pop(context);
            Provider.of<ConnectionObject>(context, listen: false)
                .connectOffer(code);
            Navigator.of(context, rootNavigator: true).pop('dialog');
            waitingForConnection(code); // TODO execute this method from deviceSelection.dart aDeviceSelection class
          }),
    );
  }
}
