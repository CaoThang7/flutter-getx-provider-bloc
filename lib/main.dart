import 'package:flutter/material.dart';
import 'package:flutter_getx_provider_bloc/provider/brightnessProvider.dart';
import 'package:flutter_getx_provider_bloc/provider/counterProvider.dart';
import 'package:flutter_getx_provider_bloc/provider/settingProvider.dart';
import 'package:flutter_getx_provider_bloc/screens/homescreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ChangeBrightness()),
      ChangeNotifierProvider(create: (_) => CounterProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: context.watch<ChangeBrightness>().isDark
              ? Brightness.dark
              : Brightness.light,
          primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

// class using provider (context.watch,context.read)
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: context.watch<ChangeBrightness>().isDark,
            onChanged: (newValue) {
              Provider.of<ChangeBrightness>(context, listen: false)
                  .setBrightness(newValue);
            },
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.watch<CounterProvider>().counter.toString(),
                style: TextStyle(color: Colors.red, fontSize: 100),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: Text("Go HomeScreen"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            context.read<CounterProvider>().add();
          });
        },
      ),
    );
  }
}

// class using provider (Consumer)
class MySettings extends StatefulWidget {
  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, mySettings, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("My Settings"),
          ),
          body: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${mySettings.text}",
                    style: TextStyle(color: Colors.red, fontSize: 100),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      mySettings.changeText();
                    },
                    child: Text("Change Text"),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
