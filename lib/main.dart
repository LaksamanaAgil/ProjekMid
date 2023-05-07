import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}

class Calculator extends StatelessWidget { //TODO: KELAS KALKULATOR
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulagil',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: KalkulatorApp(),
    );
  }
}

class KalkulatorApp extends StatefulWidget {
  @override
  _KalkulatorState createState() => _KalkulatorState();
}

class _KalkulatorState extends State<KalkulatorApp> {

  String equation = "0"; //TODO: PENGATURAN PENJUMLAHAN DASAR(JIKA TIDAK DIISI ANGKA APAPUN)
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0; //TODO: UKURAN FONT PENJUMLAHAN DAN DIBAWAHNYA FONT HASIL
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){ //TODO: PENGATURAN TOMBOL CLEAR
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "⌫"){ //TODO: PENGATURAN TOMBOL DELETE
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){ //TODO:: PENGATURAN TOMBOL HASIL
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{ //TODO: MENGUJI JIKA KALKULASI DAPAT DI PARSING
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){ //TODO: MENANGKAP ERROR SETELAH UJI TRY
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container( //TODO: KONTAINER SETTINGAN BENTUK TOMBOL
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16.0)),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid)
                  )
              )
          ),

          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kalkulagil')), //TODO:APPBAR BAGIAN ATAS APLIKASI UNTUK DISPLAY JUDUL
      body: Column(
        children: <Widget>[


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize),),
          ),


          Expanded(
            child: Divider(),
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container( //TODO: TABLEROW UNTUK TOMBOL-TOMBOL ANGKA KALKULATOR
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, Colors.deepOrange),
                          buildButton("⌫", 1, Colors.deepOrange),
                          buildButton("÷", 1, Colors.deepOrange),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black38),
                          buildButton("8", 1, Colors.black38),
                          buildButton("9", 1, Colors.black38),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black38),
                          buildButton("5", 1, Colors.black38),
                          buildButton("6", 1, Colors.black38),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black38),
                          buildButton("2", 1, Colors.black38),
                          buildButton("3", 1, Colors.black38),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black38),
                          buildButton("0", 1, Colors.black38),
                          buildButton("00", 1, Colors.black38),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.deepOrange),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.deepOrange),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.deepOrange),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.deepOrange),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}