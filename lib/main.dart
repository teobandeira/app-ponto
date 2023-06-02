import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Ponto',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String entryTime = '';
  String exitTime = '';

  void registerEntryTime() {
    // Lógica para registrar o horário de entrada
    DateTime now = DateTime.now();
    setState(() {
      entryTime = '${now.hour}:${now.minute}';
    });
  }

  void registerExitTime() {
    // Lógica para registrar o horário de saída
    DateTime now = DateTime.now();
    setState(() {
      exitTime = '${now.hour}:${now.minute}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Ponto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Horário de entrada: $entryTime',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Horário de saída: $exitTime',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: registerEntryTime,
              child: Text('Registrar Entrada'),
            ),
            ElevatedButton(
              onPressed: registerExitTime,
              child: Text('Registrar Saída'),
            ),
          ],
        ),
      ),
    );
  }
}
