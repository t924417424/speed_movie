import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speed_movie/provide/theme.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 1920, allowFontScaling: false);
    return Scaffold(
      //appBar: AppBar(title: Text("data"),),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              DayNightSwitcher(
                isDarkModeEnabled: Provider.of<MyTheme>(context).MyThemeMode,
                onStateChanged: Provider.of<MyTheme>(context).change_theme,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('Dark mode is ' +
                    (Provider.of<MyTheme>(context).MyThemeMode
                        ? 'enabled'
                        : 'disabled') +
                    '.'),
              ),
              BlurryContainer(
                borderRadius: BorderRadius.circular(20),
                bgColor: Provider.of<MyTheme>(context).MyThemeMode
                    ? Colors.white30
                    : Colors.grey,
                height: 150,
                width: 250,
                child: Text("data"),
              ),
              Container(
                width: ScreenUtil.screenWidth,
                height: ScreenUtil.screenHeight / 2,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: BlurryContainer(
                          borderRadius: BorderRadius.circular(5),
                          bgColor: Provider.of<MyTheme>(context).MyThemeMode
                              ? Colors.white30
                              : Colors.grey,
                          height: 50,
                          width: ScreenUtil.screenWidth,
                          child: Text("data")),
                    );
                  },
                ),
              )
            ],
          ),
          width: ScreenUtil.screenWidth,
          height: ScreenUtil.screenHeight,
          decoration: BoxDecoration(
            color: Provider.of<MyTheme>(context).MyThemeMode
                ? Colors.black
                : Colors.white,
//            image: DecorationImage(
//              fit: BoxFit.cover,
//              image: NetworkImage(
//                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1596195726348&di=dfa17af86f754ab2bb2a408e1956fe0d&imgtype=0&src=http%3A%2F%2Ft9.baidu.com%2Fit%2Fu%3D1354939226%2C2054625343%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D1015'),
//            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
