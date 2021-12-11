

import 'package:flutter/material.dart';

abstract class Languages {
  
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get aboutTheApp;

  String get fromTeamS2D;

  String get yourQR;

  String get chooseATheme;

  String get lightTheme;

  String get darkTheme;

  String get settings;

  String get appearance;

  //über die App kann man zweimal verweden

  String get yourDevice;

  String get scanQR;

  //yourDevice nochmal

  String get toDevice;

  String get chooseFiles;

  String get receiveFiles;

  String get acceptAll;

  String get rejectAll;

}