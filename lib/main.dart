import 'package:flutter/material.dart';
import 'package:frodit/Views/MainView.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  PermissionHandler().checkPermissionStatus(PermissionGroup.microphone).then(
    (s) {
      if(s != PermissionStatus.granted)
        PermissionHandler().requestPermissions([PermissionGroup.microphone]);
    });

  runApp(
    new MaterialApp(
      title: "FRODIT",
      home: new MainView()
  ));
  }


