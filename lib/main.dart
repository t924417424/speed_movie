import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:speed_movie/page/hello.dart';
import 'package:speed_movie/page/home.dart';
import 'package:speed_movie/page/player.dart';
import 'package:speed_movie/page/search.dart';
import 'provide/theme.dart';
import 'package:move_to_background/move_to_background.dart';

void main() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyTheme()),
    ],
    child: MyApp(),
  ));
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Provider.of<MyTheme>(context).MyThemeMode ? SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light): SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '影',
      theme: Provider.of<MyTheme>(context).MyThemeMode
          ? ThemeData(brightness: Brightness.dark,accentColor: Colors.grey,textSelectionHandleColor:Colors.blueGrey,)
          : ThemeData(brightness: Brightness.light,textSelectionColor: Colors.black,),
      home: WillPopScope(
        child: Hello(),
        onWillPop: () async {
          MoveToBackground.moveTaskToBack();
          return false; //一定要return false
        },
      ),
    );
  }
}
