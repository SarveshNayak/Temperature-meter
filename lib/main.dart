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
      body: Form(
        key: formKey,
        child: Padding(
            padding: EdgeInsets.all(mar - mar),
            child: ListView(
              children: [
                getImage(),
                Padding(
                    padding: EdgeInsets.only(
                        top: mar - 5.0,
                        bottom: mar - 5.0,
                        left: mar,
                        right: mar),
                    child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey)),
                        child: DropdownButton<String>(
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          items: units1.map((String dropDownStringItem) {
                            return DropdownMenuItem(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem));
                          }).toList(),
                          onChanged: (String value1) {
                            setState(() {
                              this.currentItem1 = value1;
                            });
                          },
                          value: currentItem1,
                        ))),
                Padding(
                    padding: EdgeInsets.only(
                        top: mar - 5.0,
                        bottom: mar - 5.0,
                        left: mar,
                        right: mar),
                    child: Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.grey)),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: Colors.white,
                          items: units2.map((String dropDownStringItem) {
                            return DropdownMenuItem(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem));
                          }).toList(),
                          onChanged: (String value1) {
                            setState(() {
                              this.currentItem2 = value1;
                            });
                          },
                          value: currentItem2,
                        ))),
                Padding(
                  padding: EdgeInsets.only(
                      top: mar - 5.0, bottom: mar - 5.0, left: mar, right: mar),
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
                                      calculation();
                                    }
                                  });
                                })),
                        Container(
                          width: mar - 5.0,
                        ),
                        Expanded(
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
                                })),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(mar - 5.0),
                  child: Text(this.result),
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
    double value = double.tryParse(valueController.text);
    double total;

    if (currentItem1 == "celsius") {
      if (currentItem2 == "kelvin") {
        total = value + 273.15;
        result = "Temperature is $total $currentItem2";
      } else if (currentItem2 == "fahrenheit") {
        total = (value * 1.8) + 32;
        result = "Temperature is $total $currentItem2";
      } else {
        total = value;
        result = "Temperature is $total $currentItem2";
      }
    } else if (currentItem1 == "kelvin") {
      if (currentItem2 == "celsius") {
        total = value - 273.15;
        result = "Temperature is $total $currentItem2";
      } else if (currentItem2 == "fahrenheit") {
        total = (value * 1.8) - 459.67;
        result = "Temperature is $total $currentItem2";
      } else {
        total = value;
        result = "Temperature is $total $currentItem2";
      }
    } else if (currentItem1 == "fahrenheit") {
      if (currentItem2 == "kelvin") {
        total = (value + 459.67) / 1.8;
        result = "Temperature is $total $currentItem2";
      } else if (currentItem2 == "celsius") {
        total = (value - 32) / 1.8;
        result = "Temperature is $total $currentItem2";
      } else {
        total = value;
        result = "Temperature is $total $currentItem2";
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
