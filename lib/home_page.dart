import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _chosenQuality = 15.0;
  double _toTip = 0.0;
  String _toTipString = "0";
  final _costOfServiceController = TextEditingController();
  var _roundUpSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip time'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 14),
          ListTile(
            leading: const Icon(
              Icons.store,
              color: Colors.green,
            ),
            title: Padding(
              padding: const EdgeInsets.only(right: 24),
              child: TextField(
                controller: _costOfServiceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cost of Service',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.room_service,
              color: Colors.green,
            ),
            title: Text("How was the service?"),
          ),
          Container(
            margin: const EdgeInsets.only(left: 45),
            child: Column(
              children: [
                qualityRadio('Amazing (20%)', 20.0),
                qualityRadio('Good (18%)', 18.0),
                qualityRadio('Okay (15%)', 15.0),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.call_made,
              color: Colors.green,
            ),
            title: const Text("Round up tip"),
            trailing: Switch(
              value: _roundUpSwitch,
              onChanged: (value) {
                setState(() {
                  _roundUpSwitch = value;
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: MaterialButton(
              onPressed: _tipCalculation,
              color: Colors.green[600],
              child: const Text(
                "CALCULATE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Tip amount: \$$_toTipString",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  RadioListTile<dynamic> qualityRadio(String title, double percentage) {
    return RadioListTile(
      title: Text(title),
      value: percentage,
      groupValue: _chosenQuality,
      onChanged: (value) {
        setState(() {
          _chosenQuality = value;
        });
      },
    );
  }

  void _tipCalculation() {
    _toTip = double.parse(_costOfServiceController.text);
    _toTip = _toTip * _chosenQuality / 100;

    if (_roundUpSwitch) {
      _toTip = _toTip.ceilToDouble();
      _toTipString = _toTip.toStringAsFixed(0);
    } else {
      _toTipString = _toTip.toStringAsFixed(2);
    }

    setState(() {});
  }
}
