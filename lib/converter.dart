import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temp Converter',
      debugShowCheckedModeBanner: false,
      home: ConvertScreen(),
    );
  }
}

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({Key? key}) : super(key: key);

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

enum OptionConvert { ctof, ftoc }

class _ConvertScreenState extends State<ConvertScreen> {
  OptionConvert? _optionValue = OptionConvert.ctof;
  String result = 'Show result';
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Converter'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('Conversion', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            Column(
              children: [
                ListTile(
                  title: Text('C to F'),
                  leading: Radio<OptionConvert>(
                      value: OptionConvert.ctof,
                      groupValue: _optionValue,
                      onChanged: (value) {
                        setState(() {
                          _optionValue = value;
                        });
                      }),
                ),
                ListTile(
                  title: Text('F to C'),
                  leading: Radio<OptionConvert>(
                      value: OptionConvert.ftoc,
                      groupValue: _optionValue,
                      onChanged: (value) {
                        setState(() {
                          _optionValue = value;
                        });
                      }),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  child: TextField(
                    controller: _inputController,
                  ),
                ),
                Text(
                  ' = ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Container(
                  width: 50,
                  child: TextField(
                    enabled: false,
                    controller: _outputController,
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                if(_inputController.text.isEmpty){
                  Fluttertoast.showToast(
                    msg: 'Please enter your value',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.grey,
                    textColor: Colors.white,
                  );
                } else{
                  double degree = double.parse(_inputController.text);
                  if(_optionValue == OptionConvert.ctof){
                    double rs = (degree*9.0/5.0)+32.0;
                    setState(() {
                      _outputController.text = rs.toString();
                      result = result + '\nC to F: '+_outputController.text;
                    });
                  } else{
                    double rs = (degree-32.0)*5.0/9.0;
                    setState(() {
                      _outputController.text = rs.toString();
                      result = result + '\nF to C: '+_outputController.text;
                    });
                  }
                }
              },
              child: Container(
                child: Text('CONVERT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                        style: BorderStyle.solid)),
              ),
            ),
            Text(result),
          ],
        ),
      ),
    );
  }
}
