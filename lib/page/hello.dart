import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:speed_movie/page/search.dart';

class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((duration){
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
          context,
          new MaterialPageRoute(builder: (context) => new Search()),
              (route) => route == null,
        );
      });
      //print(box.localToGlobal(Offset.zero)); // Offset(107.0, 100.0)
    });

    ScreenUtil.init(context,
        width: 1080, height: 1920, allowFontScaling: false);
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("影 - Engine",style: TextStyle(fontSize: ScreenUtil().setSp(80))),
        ),
      ),
    );
  }
}
