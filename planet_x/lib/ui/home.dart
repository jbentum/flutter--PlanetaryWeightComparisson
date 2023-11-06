import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  final TextEditingController _wieghtController = TextEditingController();
  int radioValue = 0;
  double _finalResult = 0.00;
  String _formattedText = "";
  // Track whether weight is in pounds or kilograms
  int _selectedIndex = 0;

  // ignore: unused_field
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page'),
    Text('Other Page'), // Replace with the widget you want to show for Home
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void handleRadioValueChanged(int? value) {
    setState(() {
      radioValue = value ?? 0;

      switch (radioValue) {
        case 0:
          _finalResult = calculateWeight(_wieghtController.text, 0.06);
          _formattedText =
              "Your weight on Pluto is ${_finalResult.toStringAsFixed(1)}";

          break;
        case 1:
          _finalResult = calculateWeight(_wieghtController.text, 0.38);
          _formattedText =
              "Your weight on Mars is ${_finalResult.toStringAsFixed(1)}";
          break;
        case 2:
          _finalResult = calculateWeight(_wieghtController.text, 0.91);
          _formattedText =
              "Your weight on Venus is ${_finalResult.toStringAsFixed(1)}";
      }
    });
  }

  void clearFields() {
    setState(() {
      _wieghtController.clear();
      _finalResult = 0.0;
      _formattedText = "";
    });
  }

  //source: https://www.livescience.com
  // Mercury: 0.38
  // Venus: 0.91
  // Earth: 1.00
  //Mars: 0.38
  // Jupiter: 2.34
  // Saturn: 1.06
  //Uranus: 0.92
  //Neptune: 1.19
  // Pluto: 0.06

  // weight = mass * multiplier(surface gravity)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planetary Weight Comparison"),
        centerTitle: true,
        backgroundColor: Colors.black38,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(2.5),
          children: [
            Image.asset(
              'images/planet.png',
              height: 133.0,
              width: 200.0,
            ),

            // Clear Button

            Container(
              margin: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  TextField(
                    controller: _wieghtController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: "Your Weight On Earth",
                        hintText: "In Pounds",
                        icon: Icon(Icons.person_outline)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  // three radio buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // radio buttons
                      Radio<int>(
                          activeColor: Colors.brown,
                          value: 0,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChanged),
                      const Text(
                        "Pluto",
                        style: TextStyle(color: Colors.white30),
                      ),
                      Radio<int>(
                          activeColor: Colors.red,
                          value: 1,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChanged),
                      const Text(
                        "Mars",
                        style: TextStyle(color: Colors.white30),
                      ),
                      Radio<int>(
                          activeColor: Colors.orangeAccent,
                          value: 2,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChanged),
                      const Text(
                        "Venus",
                        style: TextStyle(color: Colors.white30),
                      ),
                    ],
                  ),

                  // padding for the result
                  const Padding(
                    padding: EdgeInsets.all(15.6),
                  ),
                  // Result Test
                  Text(
                    // ignore: unnecessary_string_interpolations
                    //"$_formattedText lbs",
                    _wieghtController.text.isEmpty
                        ? "Please enter weight"
                        : "${_formattedText}lbs",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                  ),
                  ElevatedButton(
                    onPressed: clearFields,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 38.0, color: Colors.blueGrey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call), // Icon for the "Call" button
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_center), // Icon for the "Help" button
            label: 'Help Center',
          ),
          // Add more BottomNavigationBarItems for different pages
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueGrey,
      ),
    );
  }

  double calculateWeight(String weight, double multiplier) {
    if (int.parse(weight).toString().isNotEmpty && int.parse(weight) > 0) {
      return int.parse(weight) * multiplier;
    } else {
      ("Wrong");
      return int.parse("180") * 0.38;
    }
  }
}
