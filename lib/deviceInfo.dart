import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:platform_device_id/platform_device_id.dart';

enum DeviceType {
  Web,
  Mobile,
  Desktop,
  Other
}

class _Device {
  String name;
  String id;
  String device;
  DeviceType deviceType;

  _Device({required this.name, required this.id, required this.device, required this.deviceType});
}

_Device ?_device;

Future<_Device> getDeviceInfo() async { // TODO check if names are correct
  if(_device == null){
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceID = (await PlatformDeviceId.getDeviceId)!;
    try {
      if (kIsWeb) {
        WebBrowserInfo value = (await deviceInfoPlugin.webBrowserInfo); // TODO check if the ID is really unique
        _device = _Device(name: "Web Browser", id: (value.vendor! + deviceID + value.hardwareConcurrency.toString()), device: "Web Browser", deviceType: DeviceType.Web);
      } else {
        if (Platform.isAndroid) {
          AndroidDeviceInfo value = await deviceInfoPlugin.androidInfo;
          _device = _Device(name: value.model!, id: deviceID, device: value.device!, deviceType: DeviceType.Mobile);
        } else if (Platform.isIOS) {
          IosDeviceInfo value = await deviceInfoPlugin.iosInfo;
          _device = _Device(name: value.name!, id: deviceID, device: value.model!, deviceType: DeviceType.Mobile);
        } else if (Platform.isLinux) {
          LinuxDeviceInfo value = await deviceInfoPlugin.linuxInfo;
          _device = _Device(name: value.name, id: deviceID, device: "Linux Device", deviceType: DeviceType.Desktop);
        } else if (Platform.isMacOS) {
          MacOsDeviceInfo value = await deviceInfoPlugin.macOsInfo;
          _device = _Device(name: value.hostName, id: deviceID, device: value.model, deviceType: DeviceType.Desktop);
        } else if (Platform.isWindows) {
          WindowsDeviceInfo value = await deviceInfoPlugin.windowsInfo;
          _device = _Device(name: value.computerName, id: deviceID, device: "Windows Computer", deviceType: DeviceType.Desktop);
        }
      }
      List<int> deviceIDEncoded = utf8.encode(_device!.id);
      Digest hash = md5.convert(deviceIDEncoded);
      _device!.id = hash.toString();
    } on Exception {
      // do nothing
    }
  }
  return _device!;
}

void resetDeviceInfo() {
  _device = null;
}

void setName(String name) {
  if(_device == null)
    getDeviceInfo(); // TODO check if this doesnt create issues with notnull
  _device!.name = name;
}
