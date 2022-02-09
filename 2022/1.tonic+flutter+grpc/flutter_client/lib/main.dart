import 'package:flutter/material.dart';
import 'package:flutter_client/src/generated/helloworld.pbgrpc.dart';
import 'package:grpc/grpc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    () async {
      await testTheGRPCconnection();
    }();
  }

  Future<void> testTheGRPCconnection() async {
    final channel = ClientChannel(
      // '127.0.0.1',
      "10.0.2.2",
      port: 40051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    final stub = GreeterClient(channel);

    try {
      var response = await stub.sayHello(HelloRequest()..name = "yingshaoxo");
      print('Greeter client received: ${response.message}');

      response = await stub.sayHelloAgain(HelloRequest()..name = "Flutter");
      print('Greeter client received: ${response.message}');
    } catch (e) {
      print('Caught error: $e');
    }

    await channel.shutdown();
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
            const Text("..."),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add_reaction),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
