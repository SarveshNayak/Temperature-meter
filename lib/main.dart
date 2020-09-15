import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "MY TEMPERATURER APP",
    home: Temp(),
    theme: ThemeData(
      primaryColor: Colors.black,
      accentColor: Colors.white,
      scaffoldBackgroundColor: Colors.red[800],
    ),
  ));
}

class Temp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Tempe();
  }
}

class _Tempe extends State<Temp> {
  final mar = 10.0;
  TextEditingController inputTempController = TextEditingController();
  TextEditingController outputTempController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  var displayResult = "";
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBar(
        title: Text("TEMPERATURE METER"),
      ),
      body: Form(
        key: formKey,
        //color: Colors.red[800],
        child: Padding(
            padding: EdgeInsets.all(mar - mar),
            child: ListView(
              children: [
                getImage(),
                Padding(
                  padding: EdgeInsets.only(
                      top: mar - 5, bottom: mar - 5, left: mar, right: mar),
                  child: TextFormField(
                    style: textStyle,
                    controller: inputTempController,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "PLEASE ENTER THE INPUT";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Input Temp",
                        hintText: "i.e celsius,kelvin or fahrenheit",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13.00,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: mar - 5.0, bottom: mar - 5.0, left: mar, right: mar),
                  child: TextFormField(
                    style: textStyle,
                    controller: outputTempController,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "PLEASE ENTER THE OUTPUT";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Output Temp",
                        hintText: "i.e celsius,kelvin or fahrenheit",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13.00,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: mar - 5.0, bottom: mar - 5.0, left: mar, right: mar),
                  child: TextFormField(
                    style: textStyle,
                    controller: valueController,
                    keyboardType: TextInputType.number,
                    validator: (String val) {
                      if (val.isEmpty) {
                        return "PLEASE ENTER THE VALUE";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Enter The Value",
                        hintText: "for eg -5,12.5 etc",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13.00,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: mar - 5.0,
                        bottom: mar - 5.0,
                        left: mar,
                        right: mar),
                    child: Row(
                      children: [
                        Expanded(
                            child: RaisedButton(
                                color: Colors.black,
                                elevation: 6.00,
                                child: Text(
                                  "Calculate",
                                  style: TextStyle(color: Colors.white),
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (formKey.currentState.validate()) {
                                      this.displayResult = calculation();
                                    }
                                  });
                                })),
                        Container(
                          width: mar - 5.0,
                        ),
                        Expanded(
                            child: RaisedButton(
                                elevation: 6.00,
                                child: Text(
                                  "Reset",
                                  style: TextStyle(color: Colors.black),
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: () {
                                  setState(() {
                                    resetFunction();
                                  });
                                })),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(mar - 5.0),
                  child: Text(this.displayResult),
                )
              ],
            )),
      ),
    );
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage('images/temperature.jpg');
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 150.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(mar * 5),
    );
  }

  String calculation() {
    String input = inputTempController.text;
    String output = outputTempController.text;
    double value = double.tryParse(valueController.text);
    double total;
    String degree = "celsius";
    String far = "fahrenheit";
    String kel = "kelvin";
    double a1;
    double a2;
    double a3;
    for (a1 = 1; a1 > 0 && input == degree; a1--) {
      if (output == far) {
        total = (value * 1.8) + 32;
      } else if (output == kel) {
        total = value + 273.15;
      } else {
        total = value;
      }
    }

    for (a2 = 1; a2 > 0 && input == far; a2--) {
      if (output == degree) {
        total = (value - 32) / 1.8;
      } else if (output == kel) {
        total = (value + 459.67) / 1.8;
      } else {
        total = value;
      }
    }

    for (a3 = 1; a3 > 0 && input == kel; a3--) {
      if (output == far) {
        total = (value * 1.8) - 459.67;
      } else if (output == degree) {
        total = value - 273.15;
      } else {
        total = value;
      }
    }

    String result = "Temperature is $total $output";
    return result;
  }

  void resetFunction() {
    inputTempController.text = "";
    outputTempController.text = "";
    valueController.text = "";
    displayResult = "";
  }
}
