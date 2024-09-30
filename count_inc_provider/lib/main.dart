import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  setupWindow();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AgeModel(),
      child: const MyApp(),
    ),
  );
}

const double windowWidth = 100;
const double windowHeight = 640;

void setupWindow() {
 
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Age Manager');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  
}

class AgeModel with ChangeNotifier {
  int age = 115;

  void increaseAge() {
    if (age < 120) {
      age += 1;
      notifyListeners();
    }
  }

  void decreaseAge() {
    if (age > 0) {
      age -= 1;
      notifyListeners();
    }
  }

  void divideAge() {
    if (age <=50) {
      age %= 2;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle =
        TextStyle(fontSize: 24); 

    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('I am ', style: textStyle),
                Consumer<AgeModel>(
                  builder: (context, ageModel, child) => Text(
                    '${ageModel.age} years old',
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<AgeModel>().increaseAge();
            },
            tooltip: 'Increase Age',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              context.read<AgeModel>().decreaseAge();
            },
            tooltip: 'Decrease Age',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
