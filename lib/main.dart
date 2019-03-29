import 'package:flutter/material.dart';
import 'package:demo/calculator.dart';

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

enum EState{
  I,  // can input
  B,  // can't do anything
  E   // got result, can change to I to input, cannot change to B
}

class _MainState extends State<_Main> {
  List<Opareator> _ops = [];
  List<double> _nums = [];
  double _result = 0.0;
  String _str = '';

  EState _eState = EState.I;


  RaisedButton numpad(String text, VoidCallback onpress) {
    return RaisedButton(
      onPressed: _eState == EState.B ? null : onpress,
      child: Text(text),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.all(20),
    );
  }

  insert(String s){
    setState(() {
      if(_eState ==EState.E){
        _str = '';
        _eState =EState.I;
      }
      _str = '$_str$s';
    });
  }

  equal(){
    var expression = _str;
    setState(() {
      _eState =EState.B;
      try {
        _str = 'Result: ${Calculator.parse(expression).getResult()}';
      } catch (e) {
        _str = 'Error!';
      }
      _eState = EState.E;
    });
  }

  Widget build(context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox.expand(
              child: Card(
                  child: Center(
                    child: Text(
                      _str,
                      style: TextStyle(
                        fontSize: _eState == EState.I ? 20 : 40
                      ),
                    ),
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
                            });
                          }),
                          numpad('DEL', (){
                            setState(() {
                              _str = _str.substring(0, _str.length - 1);
                            });
                          }),
                          numpad('^', (){
                            insert('^');
                          }),
                          numpad('+', (){
                            insert('+');
                          }),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          numpad('1', (){
                            insert('1');
                          }),
                          numpad('2', (){
                            insert('2');
                          }),
                          numpad('3', (){
                            insert('3');
                          }),
                          numpad('-', (){
                            insert('-');
                          }),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          numpad('4', (){
                            insert('4');
                          }),
                          numpad('5', (){
                            insert('5');
                          }),
                          numpad('6', (){
                            insert('6');
                          }),
                          numpad('*', (){
                            insert('*');
                          }),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          numpad('7', (){
                            insert('7');
                          }),
                          numpad('8', (){
                            insert('8');
                          }),
                          numpad('9', (){
                            insert('9');
                          }),
                          numpad('/', (){
                            insert('/');
                          }),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      margin: EdgeInsets.all(10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          numpad('.', (){
                            insert('.');
                          }),
                          numpad('0', (){
                            insert('0');
                          }),
                          Expanded(child: numpad('=', (){
                            equal();
                          })),
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
