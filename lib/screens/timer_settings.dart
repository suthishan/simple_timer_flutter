import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:simple_interval_timer/model/models.dart';
import 'package:simple_interval_timer/screens/timer_screen.dart';
import 'package:simple_interval_timer/utils.dart';
import '../widgets/durationpicker.dart';
import 'settings_screen.dart';
import 'timer_screen.dart';

class TimerSettings extends StatefulWidget {
  final Settings settings;
  final Function onSettingsChanged;

  TimerSettings({@required this.settings, @required this.onSettingsChanged});

  @override
  State<StatefulWidget> createState() => _TimerSettingsState();
}

class _TimerSettingsState extends State<TimerSettings> {
  Tabata _tabata = defaultTabata;

  _onTabataChanged() {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unwind Timer'),
        leading: Icon(Icons.timer),
        // leading: Image.asset('assets/images/lake.jpg'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingsScreen(
                          settings: widget.settings,
                          onSettingsChanged: widget.onSettingsChanged)));
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          // ListTile(
          //     title: Text('Sets'),
          //     subtitle: Text('${_tabata.sets}'),
          //     leading: Icon(Icons.settings_cell),
          //     onTap: () {
          //       showDialog<int>(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return NumberPickerDialog.integer(
          //               minValue: 1,
          //               maxValue: 10,
          //               initialIntegerValue: _tabata.sets,
          //               title: Text('Sets in the workout'),
          //             );
          //           }).then((sets) {
          //         if (sets == null) return;
          //         _tabata.sets = sets;
          //         _onTabataChanged();
          //       });
          //     }),
          // ListTile(
          //     title: Text('Repetition'),
          //     subtitle: Text('${_tabata.reps}'),
          //     leading: Icon(Icons.repeat),
          //     onTap: () {
          //       showDialog<int>(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return NumberPickerDialog.integer(
          //               minValue: 1,
          //               maxValue: 10,
          //               initialIntegerValue: _tabata.reps,
          //               title: Text('Repetitions in each set'),
          //             );
          //           }).then((reps) {
          //         if (reps == null) return;
          //         _tabata.reps = reps;
          //         _onTabataChanged();
          //       });
          //     }),
          Divider(
            height:15,
          ),
          ListTile(
              title: Text('Set Timer'),
              subtitle: Text(formatTime(_tabata.exerciseTime)),
              leading: Icon(Icons.timer),
              onTap: () {
                showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationPickerDialog(
                        initialDuration: _tabata.exerciseTime,
                        title: Text('Excercise time per repetition'),
                      );
                    }).then((exerciseTime) {
                  if (exerciseTime == null) return;
                  _tabata.exerciseTime = exerciseTime;
                  _onTabataChanged();
                });
              }),
          // ListTile(
          //     title: Text('Set Additional Timer'),
          //     subtitle: Text(formatTime(_tabata.restTime)),
          //     leading: Icon(Icons.timer),
          //     onTap: () {
          //       showDialog<Duration>(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return DurationPickerDialog(
          //               initialDuration: _tabata.restTime,
          //               title: Text('Additional Timer'),
          //             );
          //           }).then((restTime) {
          //         if (restTime == null) return;
          //         _tabata.restTime = restTime;
          //         _onTabataChanged();
          //       });
          //     }),
           Divider(height: 15),
          ListTile(
              title: Text('Set Silence Period'),
              subtitle: Text(formatTime(_tabata.breakTime)),
              leading: Icon(Icons.add_alarm),
              onTap: () {
                showDialog<Duration>(
                    context: context,
                    builder: (BuildContext context) {
                      return DurationPickerDialog(
                        initialDuration: _tabata.breakTime,
                        title: Text('Set Additional Timer between time'), 
                      );
                    }).then((breakTime) {
                  if (breakTime == null) return;
                  _tabata.breakTime = breakTime;
                  _onTabataChanged();
                });
              }),
          Divider(height: 15),
          ListTile(
            title: Text(
              'Total Time',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(formatTime(_tabata.getTotalTime())),
            leading: Icon(Icons.timelapse),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TimerScreen(
                      settings: widget.settings, tabata: _tabata)));
        },
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryTextTheme.button.color,
        tooltip: 'Start Workout',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
