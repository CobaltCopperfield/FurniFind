import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FurniFind',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'FurniFind'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _woodTypeController = TextEditingController();
  final _thicknessController = TextEditingController();
  final _widthController = TextEditingController();
  final _heightController = TextEditingController();
  final _qualityController = TextEditingController();
  String _serverResponse = '';

  @override
  void dispose() {
    _woodTypeController.dispose();
    _thicknessController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _qualityController.dispose();
    super.dispose();
  }

  Future<void> _sendDataToServer() async {
    final woodType = _woodTypeController.text;
    final thickness = double.tryParse(_thicknessController.text);
    final width = double.tryParse(_widthController.text);
    final height = double.tryParse(_heightController.text);
    final quality = _qualityController.text;

    final data = {
      'woodType': woodType,
      'thickness': thickness,
      'width': width,
      'height': height,
      'quality': quality,
    };

    // Add ip address
    final url = Uri.parse('http://192.168.8.100:5000/getFurniture');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        _serverResponse = responseData['data'];
      });
    } else {
      setState(() {
        _serverResponse = 'Failed to fetch data from server';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _woodTypeController,
              decoration: InputDecoration(
                labelText: 'Wood Type',
              ),
            ),
            TextFormField(
              controller: _thicknessController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Thickness (0.25 - 4 inches)',
              ),
            ),
            TextFormField(
              controller: _widthController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Width (2 - 12 inches)',
              ),
            ),
            TextFormField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (4 - 16 inches)',
              ),
            ),
            TextFormField(
              controller: _qualityController,
              decoration: InputDecoration(
                labelText: 'Wood Quality',
              ),
            ),
            SizedBox(height: 30.0),
            Text.rich(
              TextSpan(
                text: 'Most suitable furniture: ',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: _serverResponse,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0),
            ElevatedButton(
              onPressed: _sendDataToServer,
              child: Text('Analyze'),
            ),
          ],
        ),
      ),
    );
  }
}