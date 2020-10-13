import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speed_movie/page/result.dart';
import 'package:speed_movie/plugin/Dialog.dart';
import 'package:speed_movie/provide/theme.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  String hintText = "请输入搜索内容";

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 1920, allowFontScaling: false);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil.screenHeight * 0.39,
                  child: Center(
                    child: Text(
                      "影 - Engine",
                      style: TextStyle(fontSize: ScreenUtil().setSp(80)),
                    ),
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxHeight: ScreenUtil().setHeight(160),
                      maxWidth: ScreenUtil.screenWidth * 0.9),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      hintText: hintText,
                      prefixIcon: Icon(Icons.search),
                      // contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color(0xffaaaaaa),
                    ),
                    onSubmitted: (text) {
                      if(text.isEmpty || text.trim().isEmpty){
//                        setState(() {
//                          hintText = "搜索内容不能为空";
//                        });
                        ShowToast(context, "搜索内容不能为空！",type: DialogType.Toast);
                        return;
                      }
                      //内容提交(按回车)的回调
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return result(
                            search_text: text,
                          );
                        }),
                      );
                      print('submit $text');
                    },
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setSp(50),
                ),
                Container(
                  width: ScreenUtil.screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Center(
                        child: DayNightSwitcherIcon(
                          isDarkModeEnabled:
                              Provider.of<MyTheme>(context).MyThemeMode,
                          onStateChanged:
                              Provider.of<MyTheme>(context).change_theme,
                        ),
                      ),
                      Center(
                        child: DayNightSwitcherIcon(
                          isDarkModeEnabled:
                          Provider.of<MyTheme>(context).MyThemeMode,
                          onStateChanged:
                          Provider.of<MyTheme>(context).change_theme,
                        ),
                      ),
                      Center(
                        child: DayNightSwitcherIcon(
                          isDarkModeEnabled:
                          Provider.of<MyTheme>(context).MyThemeMode,
                          onStateChanged:
                          Provider.of<MyTheme>(context).change_theme,
                        ),
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            DayNightSwitcherIcon(
                              isDarkModeEnabled:
                              Provider.of<MyTheme>(context).MyThemeMode,
                              onStateChanged:
                              Provider.of<MyTheme>(context).change_theme,
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
//                Container(
//                  width: ScreenUtil.screenWidth * 0.9,
//                  child: Padding(
//                    padding: EdgeInsets.only(top: ScreenUtil.screenWidth * 0.3),
//                    child: BlurryContainer(
//                        borderRadius: BorderRadius.circular(5),
//                        bgColor: Provider.of<MyTheme>(context).MyThemeMode
//                            ? Colors.white30
//                            : Colors.grey,
//                        height: 50,
//                        width: ScreenUtil.screenWidth,
//                        child: Text("Toast")),
//                  ),
//                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
