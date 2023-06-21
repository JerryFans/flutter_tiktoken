import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tiktoken/flutter_tiktoken.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TiktokenDataProcessCenter().initata();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'GPT-3 or GPT-4',
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: CupertinoTextField(
                style: const TextStyle(fontSize: 15),
                textAlignVertical: TextAlignVertical.top,
                textAlign: TextAlign.start,
                placeholderStyle: const TextStyle(
                    fontSize: 15, color: CupertinoColors.placeholderText),
                placeholder: 'Enter some things',
                maxLines: 20,
                controller: textController,
                onSubmitted: (v) {
                  if (v.isEmpty) {
                    return;
                  }
                  setState(() {
                    _counter = _calcuateTokens(text: v);
                  });
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tokens: $_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CupertinoButton(
                    child: const Text(
                      'Calcuate',
                    ),
                    onPressed: () {
                      var v = textController.text;
                      if (v.isEmpty) {
                        return;
                      }
                      setState(() {
                        _counter = _calcuateTokens(text: v);
                      });
                    })
              ],
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  static int _calcuateTokens(
      {required String text, String modelName = 'gpt-4'}) {
    final encoding = encodingForModel(modelName);
    final numTokens = encoding.encode(text).length;
    return numTokens;
  }
}
