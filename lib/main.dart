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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("TEMPERATURE METER"),
        ),
        body: Container(
          child: Column(children: [
            getImage(),
            Row(
              children: [
                Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.03,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(width: 1, color: Colors.grey),
                          color: Colors.white,
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
                        width: MediaQuery.of(context).size.width * 0.04,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(width: 1, color: Colors.grey),
                          color: Colors.white,
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
                width: MediaQuery.of(context).size.width * 0.03,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
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
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
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
                width: MediaQuery.of(context).size.width * 0.06,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.38,
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
                          calculation();
                        }
                      });
                    }),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.12,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.38,
                child: RaisedButton(
                    color: Colors.white,
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

    return result;
  }

  void resetFunction() {
    currentItem1 = "celsius";
    currentItem2 = "celsius";
    valueController.text = "";
    result = "";
  }
}
