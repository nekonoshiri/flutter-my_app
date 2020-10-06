import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const FirstPage(title: 'First Page'),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String _buttonMessage = 'Go Second Page';
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _setMessage(String message) {
    setState(() {
      _buttonMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              onPressed: () async {
                final messageFromSecond = await Navigator.push(
                  context,
                  MaterialPageRoute<String>(
                    builder: (context) {
                      return const SecondPage('Go back');
                    },
                    fullscreenDialog: true,
                  ),
                );
                _setMessage(messageFromSecond);
              },
              child: Text(_buttonMessage),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage(this.messageFromFirst);

  final String messageFromFirst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(messageFromFirst)),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context, 'Go Second Page Again');
          },
          child: Text(messageFromFirst),
        ),
      ),
    );
  }
}
