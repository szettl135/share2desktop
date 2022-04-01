import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share2desktop/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  bool themeSwitch = false;

  Future<void> _sprache() async {
    dialogOpen = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          //title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                 Text(AppLocalizations.of(context)!.chooseLang,
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(height: 20),
                TextButton(
                    child: Text(AppLocalizations.of(context)!.german),
                    onPressed: () {
                      //DeviceSelection.setLocale(context, Locale("de"));
                      MyApp.of(context)!
                          .setLocale(Locale.fromSubtags(languageCode: 'de'));
                    }),
                SizedBox(height: 10),
                TextButton(
                    child: Text(AppLocalizations.of(context)!.english),
                    onPressed: () {
                      //DeviceSelection.setLocale(context, Locale("en"));
                      MyApp.of(context)!
                          .setLocale(Locale.fromSubtags(languageCode: 'en'));
                    }),
              ],
            ),
          ),
        );
      },
    ).then((value) => dialogOpen = false);
  }

  void initState() {
    super.initState();
    AdaptiveTheme.getThemeMode().then((value) => {
          if (value == AdaptiveThemeMode.light)
            {
              setState(() {
                themeSwitch = false;
              })
            }
          else
            {
              setState(() {
                themeSwitch = true;
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Share2Desktop')),
        body: SettingsList(sections: [
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.settings),
            tiles: [
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.lang),

                leading: Icon(Icons.language),
                onPressed: (context) {
                  _sprache();
                },
              ),
              
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.savepath),
                description: Text(AppLocalizations.of(context)!.savepath_desc),
                leading: Icon(Icons.save),
                onPressed: (context) async {
                  String? selectedDirectory =
                      await FilePicker.platform.getDirectoryPath();
                      ownPath=true;
                      ownDir=selectedDirectory as Directory;
                  if (selectedDirectory == null) {
                    // User canceled the picker
                  }
                },
              ),
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.resetPath),
                description: Text(AppLocalizations.of(context)!.useStandard),
                leading: Icon(Icons.save),
                onPressed: (context) async {
                  ownPath=false;
                },
              ),
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.resetApp),
                description: Text(AppLocalizations.of(context)!.resetApp_desc),
                leading: Icon(Icons.restore),
                onPressed: (context) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('seen', false);
                  AdaptiveTheme.of(context).reset();
                },
              ),
            ],
          ),
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.appearance),
            tiles: [
              SettingsTile.switchTile(
                title: Text(AppLocalizations.of(context)!.appearance),
                leading: Icon(Icons.format_paint),
                initialValue: themeSwitch, //themeSwitch,
                onToggle: (bool value) {
                 // print("test");
                  setState(() {
                    themeSwitch = value;
                  });
                  if (themeSwitch) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                },
              ),
              /*SettingsTile(
                  title: Text('Systemtheme verwenden'),
                  leading: Icon(Icons.format_paint),
                  onPressed: (context) async {
                    print("test");
                    AdaptiveTheme.of(context).setSystem();
                    setState(() {
                      if (AdaptiveTheme.getThemeMode() ==
                          AdaptiveThemeMode.light) {
                        themeSwitch = false;
                      } else {
                        themeSwitch = true;
                      }
                    });
                  }),*/
            ],
          ),
        ]));
  }
}
