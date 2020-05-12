import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormLessonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FormLesson',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FormLessonAppPage(),
    );
  }
}

class FormLessonAppPage extends StatefulWidget {
  FormLessonAppPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormLessonAppPageSate();
  }
}

class _FormLessonAppPageSate extends State<FormLessonAppPage> {
  String _errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FormLesson'),
      ),
      body: Center(
        child: TextField(
          onSubmitted: (String text) {
            setState(() {
              if (!isEmail(text)) {
                _errorText = 'Error: This is not an email';
              } else {
                _errorText = null;
              }
            });
          },
          decoration: InputDecoration(
              hintText: "This is a hint", errorText: _getErrorText()),
        ),
      ),
    );
  }

  _getErrorText() {
    return _errorText;
  }

  bool isEmail(String em) {
    String emailRegexp =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailRegexp);
    return regExp.hasMatch(em);
  }
}

class CustomDayPicker extends StatefulWidget {
  @override
  _CustomDayPickerState createState() {
    return _CustomDayPickerState();
  }
}

class _CustomDayPickerState extends State<CustomDayPicker> {
  DateTime _data = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 350,
      width: 200,
      child: DayPicker(
        selectedDate: _data,
        currentDate: DateTime.now(),
        onChanged: (date) {
          setState(() {
            _data = date;
          });
        },
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
        displayedMonth: DateTime.now(),
      ),
    );
  }
}

class CustomCupertinoDatePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomCupertinoDatePickerState();
  }
}

class _CustomCupertinoDatePickerState extends State<CustomCupertinoDatePicker> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('当前日期：${_dateTime.toIso8601String()}',
          style: TextStyle(color: Colors.grey, fontSize: 16),),

      ],
    );
  }

  Container buildPicker(CupertinoDatePickerMode mode) {
    return Container(
      margin: EdgeInsets.all(10),
      child: CupertinoDatePicker(
        mode: mode,
        initialDateTime: DateTime.now(),
        minimumYear: 2018,
        maximumYear: 2030,
        use24hFormat: false,
        minuteInterval: 1,
        backgroundColor: Colors.white,
        onDateTimeChanged: (date) {
          print(date);
          setState(() {
            _dateTime = date;
          });
        },
      ),
    );
  }

}
