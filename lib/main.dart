//import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "MY TEMPERATURER APP",
    home: Temp(),
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
  String result = "";
  TextEditingController valueController = TextEditingController();
  var displayResult = "";
  var units1 = ['input unit', 'celsius', 'fahrenheit', 'kelvin'];
  var units2 = ['output unit', 'celsius', 'fahrenheit', 'kelvin'];
  var currentItem1 = "input unit";
  var currentItem2 = "output unit";
  var formKey = GlobalKey<FormState>();
  var backcolor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("TEMPERATURE METER"),
        ),
        body: Container(
          color: backcolor,
          child: Column(children: [
            getImage(),
            Row(
              children: [
                Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.47,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        padding: EdgeInsets.only(left: 10.00),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          items: units1.map((String dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (String newValueSelected) {
                            setState(() {
                              this.currentItem1 = newValueSelected;
                            });
                          },
                          value: currentItem1,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.47,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        padding: EdgeInsets.only(left: 10.00),
                        child: Align(
                          alignment: Alignment.center,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: units2.map((String dropDownStringItem) {
                              return DropdownMenuItem(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this.currentItem2 = newValueSelected;
                              });
                            },
                            value: currentItem2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.47,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Align(
                  alignment: Alignment.center,
                  child: TextFormField(
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
                        focusColor: Colors.black,
                        errorStyle: TextStyle(
                          color: Colors.red[900],
                          fontSize: 13.00,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.47,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(this.result),
                ),
              )
            ]),
            Container(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.47,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                    ),
                    child: Text(
                      "Calculate",
                      style: TextStyle(color: Colors.white),
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        if (formKey.currentState.validate()) {
                          calculation();
                        }
                      });
                    }),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.46,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.00),
                      ),
                    ),
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.black),
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        resetFunction();
                      });
                    }),
              ),
            ])
          ]),
        ));
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
    double value = double.tryParse(valueController.text);
    double total;

    if (currentItem1 == "celsius") {
      if (currentItem2 == "kelvin") {
        total = value + 273.15;
        result = "$total";
      } else if (currentItem2 == "fahrenheit") {
        total = (value * 1.8) + 32;
        result = "$total";
      } else {
        total = value;
        result = "$total";
      }
    } else if (currentItem1 == "kelvin") {
      if (currentItem2 == "celsius") {
        total = value - 273.15;
        result = "$total";
      } else if (currentItem2 == "fahrenheit") {
        total = (value * 1.8) - 459.67;
        result = "$total";
      } else {
        total = value;
        result = "T$total";
      }
    } else if (currentItem1 == "fahrenheit") {
      if (currentItem2 == "kelvin") {
        total = (value + 459.67) / 1.8;
        result = "$total";
      } else if (currentItem2 == "celsius") {
        total = (value - 32) / 1.8;
        result = "$total";
      } else {
        total = value;
        result = "$total";
      }
    } else {
      result = "INVALID UNITS";
    }

    if (total > 0 && total <= 15) {
      backcolor = Colors.yellow[50];
    } else if (total > 15 && total <= 30) {
      backcolor = Colors.yellow[100];
    } else if (total > 30 && total <= 45) {
      backcolor = Colors.yellow[200];
    } else if (total > 45 && total <= 60) {
      backcolor = Colors.yellow[300];
    } else if (total > 60 && total <= 75) {
      backcolor = Colors.yellow[400];
    } else if (total > 75 && total <= 90) {
      backcolor = Colors.yellow[500];
    } else if (total > 90 && total <= 105) {
      backcolor = Colors.yellow[600];
    } else if (total > 105 && total <= 120) {
      backcolor = Colors.yellow[700];
    } else if (total > 120 && total <= 135) {
      backcolor = Colors.yellow[900];
    } else if (total > 135 && total <= 150) {
      backcolor = Colors.orange[700];
    } else if (total > 150 && total <= 165) {
      backcolor = Colors.orange[800];
    } else if (total > 165 && total <= 180) {
      backcolor = Colors.orange[900];
    } else if (total > 180 && total <= 195) {
      backcolor = Colors.red[400];
    } else if (total > 195 && total <= 210) {
      backcolor = Colors.red[500];
    } else if (total > 210 && total <= 225) {
      backcolor = Colors.red[600];
    } else if (total > 225 && total <= 240) {
      backcolor = Colors.red[700];
    } else if (total > 240 && total <= 255) {
      backcolor = Colors.red[800];
    } else if (total > 255) {
      backcolor = Colors.red[900];
    }
    if (total >= -15 && total <= 0) {
      backcolor = Colors.blue[50];
    } else if (total >= -30 && total < -15) {
      backcolor = Colors.blue[100];
    } else if (total >= -45 && total < -30) {
      backcolor = Colors.blue[200];
    } else if (total >= -60 && total < -45) {
      backcolor = Colors.blue[300];
    } else if (total >= -75 && total < -60) {
      backcolor = Colors.blue[400];
    } else if (total >= -90 && total < -75) {
      backcolor = Colors.blue[500];
    } else if (total >= -105 && total < -90) {
      backcolor = Colors.blue[600];
    } else if (total >= -120 && total < -105) {
      backcolor = Colors.blue[700];
    } else if (total >= -135 && total < -120) {
      backcolor = Colors.blue[900];
    } else if (total >= -150 && total < -135) {
      backcolor = Colors.deepPurple[500];
    } else if (total >= -165 && total < -150) {
      backcolor = Colors.deepPurple[600];
    } else if (total >= -180 && total < -165) {
      backcolor = Colors.deepPurple[700];
    } else if (total >= -195 && total < -180) {
      backcolor = Colors.deepPurple[800];
    } else if (total >= -210 && total <= -195) {
      backcolor = Colors.deepPurple[900];
    }

    return result;
  }

  void resetFunction() {
    currentItem1 = "celsius";
    currentItem2 = "celsius";
    valueController.text = "";
    result = "";
    backcolor = Colors.white;
  }
}
