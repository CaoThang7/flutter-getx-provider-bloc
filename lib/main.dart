import 'package:flutter/material.dart';
import 'package:flutter_getx_provider_bloc/provider/brightnessProvider.dart';
import 'package:flutter_getx_provider_bloc/provider/counterProvider.dart';
import 'package:flutter_getx_provider_bloc/provider/infoProvider.dart';
import 'package:flutter_getx_provider_bloc/provider/settingProvider.dart';
import 'package:flutter_getx_provider_bloc/screens/homescreen.dart';
import 'package:flutter_getx_provider_bloc/screens/productscreen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => GioiTinh()),
      ChangeNotifierProvider(create: (_) => BangCap()),
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
      // theme: ThemeData(
      //     brightness: context.watch<ChangeBrightness>().isDark
      //         ? Brightness.dark
      //         : Brightness.light,
      //     primarySwatch: Colors.blue),
      home: Infomation(),
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

// class using provider (Consumer2)
class Infomation extends StatefulWidget {
  @override
  State<Infomation> createState() => _InfomationState();
}

class _InfomationState extends State<Infomation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Demo'),
      ),
      body: Consumer2<GioiTinh, BangCap>(
        builder: (context, infoGioiTinh, infoBangCap, child) {
          return Column(
            children: [
              RadioListTile<gioi_tinh?>(
                value: gioi_tinh.nam,
                title: Text("Nam"),
                secondary: Icon(Icons.male),
                groupValue: infoGioiTinh.gioiTinh,
                onChanged: (value) {
                  infoGioiTinh.gioiTinh = value;
                },
              ),
              RadioListTile<gioi_tinh?>(
                  value: gioi_tinh.nu,
                  title: Text('Nu'),
                  secondary: Icon(Icons.female),
                  groupValue: infoGioiTinh.gioiTinh,
                  onChanged: (value) {
                    infoGioiTinh.gioiTinh = value;
                  }),
              Text('Bang Cap'),
              RadioListTile<bang_cap?>(
                  value: bang_cap.caoDang,
                  title: Text('Cao Dang'),
                  groupValue: infoBangCap.bangCap,
                  onChanged: (value) {
                    infoBangCap.bangCap = value;
                  }),
              RadioListTile<bang_cap?>(
                  value: bang_cap.daiHoc,
                  title: Text('Dai Hoc'),
                  groupValue: infoBangCap.bangCap,
                  onChanged: (value) {
                    infoBangCap.bangCap = value;
                  }),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductScreen()),
                  );
                },
                child: Text("Xem san pham"),
              )
            ],
          );
        },
      ),
    );
  }
}
