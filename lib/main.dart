import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hello world',
      theme: ThemeData(
        accentColor: Colors.grey,
        primaryColor: Colors.lightBlue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('helloworld'),
        ),
        body: _Main(),
      ),
    );
  }
}

class _Main extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainState();
  }
}

enum Opareator {
  Plus,
  Minus,
  Times,
  Divide,
  Equals,
}

class _MainState extends State<_Main> {
  List<Opareator> _ops = [];
  List<double> _nums = [];
  double _result = 0.0;
  String _str = '';
  String _temp = '';


  RaisedButton numpad(String text, VoidCallback onpress) {
    return RaisedButton(
      onPressed: onpress,
      child: Text(text),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.all(20),
    );
  }

  Widget build(context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox.expand(
              child: Card(
                  child: Center(
                    child: Text(_str),
                    widthFactor: 1,
                    heightFactor: 2,
                  ),
                  color: HSLColor.fromAHSL(1, 160, 0.6, 0.6).toColor()),
            ),
            flex: 1,
          ),
          Expanded(
            child: Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          numpad('AC', (){
                            setState(() {
                              _str = '';
                              _temp = '';

                            });
                          }),
                          numpad('DEL', (){}),
                          numpad('3', (){}),
                          numpad('+', (){}),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          numpad('1', (){}),
                          numpad('2', (){}),
                          numpad('3', (){}),
                          numpad('-', (){}),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          numpad('4', (){}),
                          numpad('5', (){}),
                          numpad('6', (){}),
                          numpad('x', (){}),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          numpad('7', (){}),
                          numpad('8', (){}),
                          numpad('9', (){}),
                          numpad('/', (){}),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          numpad('.', (){}),
                          numpad('0', (){}),
                          Expanded(child: numpad('=', (){})),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              color: HSLColor.fromAHSL(1, 160, 0.6, 0.6).toColor(),
            ),
            flex: 3,
          )
        ],
      ),
    );
  }
}
