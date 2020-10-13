import 'dart:async';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:speed_movie/page/player.dart';
import 'package:speed_movie/plugin/HttpUtil.dart';
import 'package:speed_movie/provide/theme.dart';

enum DialogType {
  Toast, //会自动消失
  Window, //只能点击消失
}

class LoadingDialog extends Dialog {
  String text;
  Timer timer;
  DialogType dtype;

  LoadingDialog({Key key, @required this.text, DialogType this.dtype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dtype == DialogType.Toast) {
      timer = new Timer(new Duration(seconds: 1), () {
        Navigator.pop(context);
        timer?.cancel();
      });
    }
    return GestureDetector(
      child: Material(
        //创建透明层
        type: MaterialType.transparency,
        child: Center(
          //保证控件居中效果
          child: SizedBox(
            child: BlurryContainer(
              borderRadius: BorderRadius.circular(20),
              bgColor: Provider.of<MyTheme>(context).MyThemeMode
                  ? Colors.white30
                  : Colors.grey,
              child: Text(text),
            ),
          ),
        ),
      ),
      onTap: () {
        timer?.cancel();
        Navigator.pop(context); //点击取消
      },
    );
  }
}

void ShowToast(@required BuildContext context, @required String text,
    {DialogType type = DialogType.Toast}) {
  showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new LoadingDialog(
          //调用对话框
          text: text,
          dtype: type,
        );
      });
}

class ContentDialog extends Dialog {
  Map<String, dynamic> vod_info;

  ContentDialog({Key key, @required this.vod_info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 1920, allowFontScaling: false);
    return GestureDetector(
      child: Material(
        //创建透明层
        type: MaterialType.transparency,
        child: Center(
          //保证控件居中效果
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: ScreenUtil().setSp(1200),
                        width: ScreenUtil().setSp(800),
                        color: Colors.white54,
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              LoadingBumpingLine.circle(),
                          errorWidget: (context, url, error) {Icon(Icons.error);print(error);},
                          fit: BoxFit.cover,
                          imageUrl: vod_info['vod_pic'],
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setSp(800),
                          ),
                          BlurryContainer(
                            height: ScreenUtil().setSp(400),
                            width: ScreenUtil().setSp(800),
                            borderRadius: BorderRadius.circular(0),
                            bgColor: Provider.of<MyTheme>(context).MyThemeMode
                                ? Colors.white30
                                : Colors.grey,
                            child: SingleChildScrollView(
                              child: Text(
                                "\r\n" + vod_info['vod_content'],
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                        child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: ScreenUtil().setSp(715),
                        ),
                        FloatingActionButton(
                          child: Icon(
                            Icons.play_arrow,
                            size: ScreenUtil().setSp(120),
                            color: Colors.white54,
                          ),
                          onPressed: () {
                            Start_loading(context);
                            //print(vod_info['vod_play_url'].split('#'));
                            List<dynamic> vod_count = vod_info['vod_play_url'].split('#');
                            List<Map<String,dynamic>> vod_player_list = List.generate(vod_count.length, (i) {
                              List tmp = vod_count[i].split("\$");
                              return {
                                "title": tmp[0],
                                "link": tmp[1],
                                "index": i,
                              };
                            });
                            //print(vod_player_list);
                            Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Player(
                                  vod_name: vod_info['vod_name'],
                                  vod_player_list: vod_player_list,
                                );
                              }),
                            );

                          },
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context); //点击取消
      },
    );
  }
}

void ShowVod(@required BuildContext context, int vod) {
  Start_loading(context);
  Map<String, dynamic> vod_info;
  HttpUtil.get("/api/detail/$vod", success: (data) {
    vod_info = data;
    Navigator.pop(context);
    showDialog<Null>(
        context: context, //BuildContext对象
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new ContentDialog(
            vod_info: vod_info,
            //调用对话框
          );
        });
  }, error: (errorMsg) {
    ShowToast(context, errorMsg, type: DialogType.Window);
  });
}

void Start_loading(BuildContext context) {
  showDialog<Null>(
    context: context, //BuildContext对象
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        child: Center(
          child: BlurryContainer(
            borderRadius: BorderRadius.circular(10),
            bgColor: Provider.of<MyTheme>(context).MyThemeMode
                ? Colors.white30
                : Colors.grey,
            child: LoadingBouncingGrid.square(),
          ),
        ),
        onWillPop: () async {
          return Future.value(false);
        },
      );
    },
  );
}
