import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Ponto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  void _login(BuildContext context) async {
    String name = nameController.text;
    if (name.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userName', name);
      Navigator.pushNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentTime = '';
  String entryTime = '';
  String exitTime = '';
  Timer? timer;
  List<String> pointHistory = [];

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = _getCurrentTime();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    return '${now.hour}:${now.minute}:${now.second}';
  }

  void registerEntryTime() {
    DateTime now = DateTime.now();
    setState(() {
      entryTime = '${now.hour}:${now.minute}:${now.second}';
      pointHistory.add('Entrada: $entryTime - ${_getCurrentDate()}');
    });
  }

  void registerExitTime() {
    DateTime now = DateTime.now();
    setState(() {
      exitTime = '${now.hour}:${now.minute}:${now.second}';
      pointHistory.add('Saída: $exitTime - ${_getCurrentDate()}');
    });
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd/MM/yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Ponto'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Bem-vindo!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            currentTime,
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: registerEntryTime,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
                ),
                child: Text(
                  'Registrar Entrada',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: registerExitTime,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(16)),
                ),
                child: Text(
                  'Registrar Saída',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (pointHistory.isNotEmpty) ...[
            Text(
              'Histórico de Pontos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: pointHistory
                  .map((point) => Text(point, style: TextStyle(fontSize: 18)))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
