// Shunting-yard algorithm
// get Reverse Polish notation (RPN)
// then use RPN get final result.

import 'dart:collection';
import 'dart:math';

enum _Ops {
  Plus,
  Minus,
  Times,
  Obelus,
  Power,
}

enum _Type {
  Number,
  Operator,
}

class _Token {
  final _Type type;
  final num _n;
  final _Ops _o;
  _Token.number(this._n)
      : type = _Type.Number,
        _o = null;
  _Token.op(this._o)
      : type = _Type.Operator,
        _n = 0;
}

// may raising an exeception
class Calculator {
  ListQueue<_Token> _results;

  Calculator.parse(String expresson) {
    ListQueue<_Ops> ops = ListQueue();
    StringBuffer temp = StringBuffer();
    _results = ListQueue();

    for (var char in expresson.runes) {
      var s = String.fromCharCode(char);
      if (s != '+' && s != '-' && s != '*' && s != '/' && s != '^') {
        temp.write(s);
      } else {
        _results.addFirst(_Token.number(num.parse(temp.toString()))); //
        temp.clear();
        /* 
        while(     (there is an operator at the top of the operator stack with greater precedence)
              or 
              (the operator at the top of the operator stack has equal precedence and is left associative)
        ) and (the operator at the top of the operator stack is not a left parenthesis)
          pop operators from the operator stack onto the output queue.
        push it onto the operator stack.
         */
        switch (s) {
          case '+':
            while (ops.isNotEmpty) {
              _results.addFirst(_Token.op(ops.removeFirst()));
            }
            ops.addFirst(_Ops.Plus);
            break;
          case '-':
            while (ops.isNotEmpty) {
              _results.addFirst(_Token.op(ops.removeFirst()));
            }
            ops.addFirst(_Ops.Minus);
            break;
          case '*':
            while (ops.isNotEmpty &&
                ops.first != _Ops.Plus &&
                ops.first != _Ops.Minus) {
              _results.addFirst(_Token.op(ops.removeFirst()));
            }
            ops.addFirst(_Ops.Times);
            break;
          case '/':
            while (ops.isNotEmpty &&
                ops.first != _Ops.Plus &&
                ops.first != _Ops.Minus) {
              _results.addFirst(_Token.op(ops.removeFirst()));
            }
            ops.addFirst(_Ops.Obelus);
            break;
          case '^':
            while (ops.isNotEmpty && ops.first == _Ops.Power) {
              _results.addFirst(_Token.op(ops.removeFirst()));
            }
            ops.addFirst(_Ops.Power);
            break;
          default:
        }
      }
    }
    if (temp.isNotEmpty) {
      _results.addFirst(_Token.number(num.parse(temp.toString())));
      temp.clear();
    }
    while (ops.isNotEmpty) {
      _results.addFirst(_Token.op(ops.removeFirst()));
    }
  }

  ///
  /// final result
  ///
  num getResult() {
    ListQueue<num> results_ = ListQueue();
    ListQueue<_Token> temp =ListQueue.from(_results);
    for (var item in temp.toList().reversed) {
      if (item.type == _Type.Number) {
        results_.addFirst(temp.removeLast()._n);
      } else if (item.type == _Type.Operator) {
        var b = results_.removeFirst(), a = results_.removeFirst();

        switch (temp.removeLast()._o) {
          case _Ops.Plus:
            results_.addFirst(a + b);
            break;
          case _Ops.Minus:
            results_.addFirst(a - b);
            break;
          case _Ops.Times:
            results_.addFirst(a * b);
            break;
          case _Ops.Obelus:
            results_.addFirst(a / b);
            break;
          case _Ops.Power:
            results_.addFirst(pow(a, b));
            break;
          default:
        }
      }
    }
    return results_.first;
  }

  ///
  /// Print RPN(Reverse Polish notation) string
  ///
  @override
  String toString() {
    StringBuffer sb = StringBuffer();
    for (var item in _results.toList().reversed) {
      if (item.type == _Type.Number) {
        sb.write(item._n);
      } else {
        switch (item._o) {
          case _Ops.Plus:
            sb.write('+');
            break;
          case _Ops.Minus:
            sb.write('-');
            break;
          case _Ops.Times:
            sb.write('*');
            break;
          case _Ops.Obelus:
            sb.write('/');
            break;
          case _Ops.Power:
            sb.write('^');
            break;
          default:
        }
      }
    }
    return sb.toString();
  }
}
