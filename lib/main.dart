import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/models.dart';
import 'package:simple_interval_timer/screens/timer_settings.dart';


void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  var prefs = await SharedPreferences.getInstance();
  runApp(TimerApp(settings: Settings(prefs)));
}

class TimerApp extends StatefulWidget {
  final Settings settings;

  TimerApp({this.settings});

  @override
  State<StatefulWidget> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  _onSettingsChanged() {
    setState(() {});
    widget.settings.save();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unwind Timer',
      theme: ThemeData(
        primarySwatch: widget.settings.primarySwatch,
        brightness:
            widget.settings.nightMode ? Brightness.dark : Brightness.light,
      ),
      home: TimerSettings(
          settings: widget.settings, onSettingsChanged: _onSettingsChanged),
    );
  }
}


