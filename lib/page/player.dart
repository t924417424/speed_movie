import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:speed_movie/page/video.dart';

class Player extends StatefulWidget {
  String vod_name = "";
  List<Map<String, dynamic>> vod_player_list = List();

  Player({
    Key key,
    @required this.vod_name,
    @required this.vod_player_list,
  }) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> with SingleTickerProviderStateMixin {
  int groupValue = 0;

  TabController controller;
  List<Tab> tabs = List();



  //String videoUrl = "https://www.runoob.com/try/demo_source/movie.mp4";
  String videoUrl = "https://yun.zxziyuan-yun.com/20180221/4C6ivf8O/index.m3u8";
  // String videoUrl = "http://vodkgeyttp8.vod.126.net/cloudmusic/1241/core/e30b/aec700ee466da6c8ce51d12953e7b89f.mp4?wsSecret=a6d7342a3ea018d632b3d7ce56ffd11f&wsTime=1580815486";
  // String videoUrl = "http://vod.anyrtc.cc/364c01b9c8ca4e46bd65e7307887341d/34688ef93da349628d5e4efacf8a5167-9fd7790c8f5862b09c350e4a916b203d.mp4";

  String mainSubtitles = ""; //主字幕
  String subSubtitles = ""; //辅字幕
  bool _isPlaying = false;
  bool _isFullscreen = false;

  bool showAdvertCover = false; //是否显示广告

  bool get isPlaying => _isPlaying;
  set isPlaying(bool playing) {
    print("playing  $playing");
    _isPlaying = playing;
  }




  @override
  void initState() {
    super.initState();
    videoUrl = widget.vod_player_list[0]['link'];
    tabs = Gettab(widget.vod_player_list.length);
    //print(Gettab(widget.vod_player_list.length));
    controller =
        TabController(initialIndex: 0, length: tabs.length, vsync: this);
  }

//  List list =[
//    {
//      "title": "影视特效",
//      "type":0,
//    },
//    {
//      "title": "室内设计",
//      "type":1
//    },
//    {
//      "title": "游戏原画",
//      "type":2
//    },
//    {
//      "title": "次时代",
//      "type":3
//    },
//    {
//      "title": "UI设计",
//      "type":4
//    },
//    {
//      "title": "后期合成",
//      "type":5
//    },
//  ];

//  final List<Map<String,dynamic>> items = List.generate(
//    20,
//        (i) => Map<String,dynamic>(
//      {
//        "test$i" : "",
//        "test" : "test",
//      }
//    ),
//  );
  void updateGroupValue(int v,String url) {
    setState(() {
      groupValue = v;
      videoUrl = url;
    });
  }

  Widget listitem(context, value) {
    //print(value['type']);
    return groupValue == value['index']
        ? RaisedButton(
      color: Colors.black,
      onPressed: () {
        //当前选中按钮的点击事件
        //print('切换${value}');
        //updateGroupValue(value['index']);
      },
      child: Text(
        value['title'],
        style: TextStyle(color: Colors.white),
      ),
    )
        : OutlineButton(
      onPressed: () {
        print(value['link']);
        //print('切换${value}');
        updateGroupValue(value['index'],value['link']);
      },
      child: Text(value['title']),
    );
  }

  Widget GetGrid(String text) {
    List<String> index_to = text.split('-');
    return GridView.builder(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
      itemCount: int.parse(index_to[1]) - (int.parse(index_to[0]) - 1),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //横轴元素个数
          crossAxisCount: 3,
          //纵轴间距
          //scrollDirection: Axis.vertical,
          // 左右间隔
          crossAxisSpacing: 10.0,
          // 上下间隔
          mainAxisSpacing: 15.0,
          //宽高比
          childAspectRatio: 1 / 0.4),
      itemBuilder: (BuildContext context, int index) {
        return listitem(
            context, widget.vod_player_list[int.parse(index_to[0]) - 1 + index]);
      },
    );
  }

//    List<Widget> Getlist(int count){
//      List<Widget> list = List();
//      if(count <= 50){
//        list.add(
//          GridView.builder(
//            padding: EdgeInsets.only(
//                left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
//            itemCount: count,
//            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//              //横轴元素个数
//                crossAxisCount: 3,
//                //纵轴间距
//                //scrollDirection: Axis.vertical,
//                // 左右间隔
//                crossAxisSpacing: 10.0,
//                // 上下间隔
//                mainAxisSpacing: 15.0,
//                //宽高比
//                childAspectRatio: 1 / 0.4),
//            itemBuilder: (BuildContext context, int index) {
//              return listitem(context, widget.vod_player_list[index]);
//            },
//          ),
//        );
//      }else{
//        int i = 1;
//        while(true)
//        {
//          if(count - i > 49){
//            //list.add(Tab(text: "$i-${i + 49}",));
//            print(widget.vod_player_list[i - 1]);
//            list.add(
//              GridView.builder(
//                padding: EdgeInsets.only(
//                    left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
//                itemCount: 50,
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  //横轴元素个数
//                    crossAxisCount: 3,
//                    //纵轴间距
//                    //scrollDirection: Axis.vertical,
//                    // 左右间隔
//                    crossAxisSpacing: 10.0,
//                    // 上下间隔
//                    mainAxisSpacing: 15.0,
//                    //宽高比
//                    childAspectRatio: 1 / 0.4),
//                itemBuilder: (BuildContext context, int index) {
//                  return listitem(context, widget.vod_player_list[i - 1 + index]);
//                },
//              ),
//            );
//            i += 50;
//
//          }else{
//           //list.add(Tab(text: "$i-${count}",));
//
//            list.add(
//              GridView.builder(
//                padding: EdgeInsets.only(
//                    left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
//                itemCount: count - i,
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  //横轴元素个数
//                    crossAxisCount: 3,
//                    //纵轴间距
//                    //scrollDirection: Axis.vertical,
//                    // 左右间隔
//                    crossAxisSpacing: 10.0,
//                    // 上下间隔
//                    mainAxisSpacing: 15.0,
//                    //宽高比
//                    childAspectRatio: 1 / 0.4),
//                itemBuilder: (BuildContext context, int index) {
//                  return listitem(context, widget.vod_player_list[i - 1 + index]);
//                },
//              ),
//            );
//
//            break;
//          }
//        }
//      }
//      return list;
//    }


  Widget VideoView(){
    return videoUrl != ""
        ? AwsomeVideoPlayer(
      videoUrl,

      /// 视频播放配置
      playOptions: VideoPlayOptions(
          seekSeconds: 30,
          //左侧垂直手势调节视频亮度的单位（0～1之间，不能小于0，不能大于1）
          brightnessGestureUnit: 0.05,
          //右侧垂直手势调节视频音量的单位（0～1之间，不能小于0，不能大于1）
          volumeGestureUnit: 0.05,
          //横行手势调节视频进度的单位秒数
          progressGestureUnit: 2000,
          aspectRatio: 16 / 9,
          loop: false,
          autoplay: true,
          allowScrubbing: true,
          startPosition: Duration(seconds: 0)),

      /// 自定义视频样式
      videoStyle: VideoStyle(
        /// 自定义视频暂停时视频中部的播放按钮
        playIcon: Icon(
          Icons.play_circle_outline,
          size: 80,
          color: Colors.white,
        ),

        /// 暂停时是否显示视频中部播放按钮
        showPlayIcon: true,

        videoLoadingStyle: VideoLoadingStyle(
          /// 重写部分（二选一）
          // 重写Loading的widget
          // customLoadingIcon: CircularProgressIndicator(strokeWidth: 2.0),
          // 重写Loading 下方的Text widget
          // customLoadingText: Text("加载中..."),
          /// 设置部分（二选一）
          // 设置Loading icon 下方的文字
          loadingText: "Loading...",
          // 设置loading icon 下方的文字颜色
          loadingTextFontColor: Colors.white,
          // 设置loading icon 下方的文字大小
          loadingTextFontSize: 20,
        ),

        /// 自定义顶部控制栏
        videoTopBarStyle: VideoTopBarStyle(
          show: true, //是否显示
          height: 30,
          padding:
          EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          barBackgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
          popIcon: Icon(
            Icons.wifi_tethering,
            size: 16,
            color: Colors.white,
          ),
          contents: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '视频源于网络，切勿相信广告',
                  style: TextStyle(
                      color: Colors.white, fontSize: 12),
                ),
              ),
            )
          ], //自定义顶部控制栏中间显示区域
          actions: [
//            GestureDetector(
//              onTap: () {
//                ///1. 可配合自定义拓展元素使用，例如广告
//                setState(() {
//                  showAdvertCover = true;
//                });
//
//                ///
//              },
//              child: Icon(
//                Icons.more_horiz,
//                size: 16,
//                color: Colors.white,
//              ),
//            )
          ], //自定义顶部控制栏右侧显示区域
          /// 设置cusotmBar之后，以上属性均无效(除了`show`之外)
          // customBar: Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   child: Container(
          //     width: double.infinity,
          //     height: 50,
          //     color: Colors.yellow,
          //     child: Text("12312312"),
          //   ),
          // ),
          // customBar: Align(
          //   alignment: Alignment.topLeft,
          //   child: Container(
          //     width: double.infinity,
          //     height: 30,
          //     color: Colors.yellow,
          //     child: GestureDetector(
          //       onTap: () {
          //         print("yes");
          //       },
          //       child: Text("123123132")
          //     )
          //   ),
          // ),
        ),

        /// 自定义底部控制栏
        videoControlBarStyle: VideoControlBarStyle(
          /// 自定义颜色
          // barBackgroundColor: Colors.blue,

          ///添加边距
          padding:
          EdgeInsets.symmetric(vertical: 8, horizontal: 10),

          ///设置控制拦的高度，默认为30，如果图标设置过大但是高度不够就会出现图标被裁剪的现象
          height: 30,

          /// 自定义进度条样式
          // progressStyle: VideoProgressStyle(
          //     // padding: EdgeInsets.all(0),
          //     padding: EdgeInsets.symmetric(
          //         vertical: 0,
          //         horizontal: 10), //vertical不能设置太大，不然被把进度条压缩肉眼无法识别
          //     playedColor: Colors.red,
          //     bufferedColor: Colors.yellow,
          //     backgroundColor: Colors.green,
          //     dragBarColor: Colors
          //         .white, //进度条为`progress`时有效，如果时`basic-progress`则无效
          //     height: 4,
          //     progressRadius:
          //         2, //进度条为`progress`时有效，如果时`basic-progress`则无效
          //     dragHeight:
          //         5 //进度条为`progress`时有效，如果时`basic-progress`则无效
          //     ),

          /// 更改进度栏的播放按钮
          playIcon: Icon(Icons.play_arrow,
              color: Colors.white, size: 16),

          /// 更改进度栏的暂停按钮
          pauseIcon: Icon(
            Icons.pause,
            color: Colors.white,
            size: 16,
          ),

          /// 更改进度栏的快退按钮
          rewindIcon: Icon(
            Icons.replay_30,
            size: 16,
            color: Colors.white,
          ),

          /// 更改进度栏的快进按钮
          forwardIcon: Icon(
            Icons.forward_30,
            size: 16,
            color: Colors.white,
          ),

          /// 更改进度栏的全屏按钮
          fullscreenIcon: Icon(
            Icons.fullscreen,
            size: 20,
            color: Colors.white,
          ),

          /// 更改进度栏的退出全屏按钮
          fullscreenExitIcon: Icon(
            Icons.fullscreen_exit,
            size: 20,
            color: Colors.red,
          ),

          /// 决定控制栏的元素以及排序，示例见上方图3
          itemList: [
            "rewind",
            "play",
            "forward",
            "position-time", //当前播放时间
            "progress", //线条形进度条（与‘basic-progress’二选一）
            // "basic-progress",//矩形进度条（与‘progress’二选一）
            "duration-time", //视频总时长
            // "time",//格式：当前时间/视频总时长
            "fullscreen"
          ],
        ),

        /// 自定义字幕
        videoSubtitlesStyle: VideoSubtitles(
          mianTitle: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 30),
              child: Text(mainSubtitles,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 14)),
            ),
          ),
          subTitle: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(subSubtitles,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: 14)),
            ),
          ),
        ),
      ),

      /// 自定义拓展元素
      children: [
        /// DEMO1 自定义视频播放状态Toast
        /// 待完善

        /// DEMO2 这个将会覆盖的视频内容，因为这个层级是最高级，因此手势会失效(慎用)
        /// 这个可以用来做视频广告
        showAdvertCover
            ? Align(
          alignment: Alignment.center,
          child: Container(
            width: 200,
            height: 100,
            color: Colors.blue[500],
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                //关闭广告
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showAdvertCover = false;
                      });
                    },
                    child: Icon(
                      Icons.cancel,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "一个广告封面",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        )
            : Align(),
      ],

      oninit: (value){
        print("onload over");
      },

      onnetwork: (value){
        print(value);
      },
      /// 视频暂停回调
      onpause: (value) {
        print("video paused");
        setState(() {
          isPlaying = false;
        });
      },

      /// 视频播放回调
      onplay: (value) {
        print("video played");
        setState(() {
          isPlaying = true;
        });
      },

      /// 视频播放结束回调
      onended: (value) {
        print("video ended");
      },

      /// 视频播放进度回调
      /// 可以用来匹配字幕
      ontimeupdate: (value) {
        // print("timeupdate ${value}");
        // var position = value.position.inMilliseconds / 1000;
        //根据 position 来判断当前显示的字幕
      },

      onprogressdrag: (position, duration) {
        print("进度条拖拽的时间节点： ${position}");
        print("进度条总时长： ${duration}");
      },

      onvolume: (value) {
        print("onvolume ${value}");
      },

      onbrightness: (value) {
        print("onbrightness ${value}");
      },

      onfullscreen: (fullscreen) {
        print("is fullscreen $fullscreen");
        setState(() {
          _isFullscreen = fullscreen;
        });
      },

      /// 顶部控制栏点击返回按钮
      onpop: (value) {
        print("返回上一页");
      },
    )
        : AspectRatio(
      aspectRatio: 16 / 9,
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2.0),
      ),
    );
  }

  GlobalKey _key1 = GlobalKey();
  Size Video_Size = Size(0.0, 0.0);


  @override
  Widget build(BuildContext context) {

    // 监听widget渲染完成
    WidgetsBinding.instance.addPostFrameCallback((duration){
      RenderBox box = _key1.currentContext.findRenderObject();
      // _key1.currentContext.size; Size(200.0, 100.0)
      print(box.size); // Size(200.0, 100.0)
      if(Video_Size.height == 0){
        setState(() {
          Video_Size = box.size;
        });
      }
      //print(box.localToGlobal(Offset.zero)); // Offset(107.0, 100.0)
    });

    //GlobalKey _myKey = new GlobalKey();

    ScreenUtil.init(context,
        width: 1080, height: 1920, allowFontScaling: false);
    return Scaffold(
      appBar: !_isFullscreen
          ?  PreferredSize(
        child: AppBar(
          title: Text("${widget.vod_name}"),
        ),
        preferredSize: Size.fromHeight(ScreenUtil.screenHeight * 0.06),
      ) : null,
      body: Container(
        height: !_isFullscreen ? MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            ScreenUtil.screenHeight * 0.06 : MediaQuery.of(context).size.height , //屏幕总高度 - 状态栏高度 - Appbar高度
        child: Column(
          children: <Widget>[
            Container(
              key: _key1,
              //key: _myKey,
              color: Colors.blueGrey,
              //height: !_isFullscreen ? ScreenUtil.screenHeight / 3 : ScreenUtil.screenHeight,
              //width: ScreenUtil.screenWidth,
              child: VideoView(),
            ),
            !_isFullscreen
                ?
            Container(
              height: ScreenUtil.screenHeight -
                  MediaQuery.of(context).padding.top -
                  ScreenUtil.screenHeight * 0.06 -
                  Video_Size.height,
              child: Scaffold(
                appBar: TabBar(
                  tabs: tabs,
                  controller: controller,
                  //配置控制器
                  isScrollable: true,
                  indicatorWeight: 2,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: EdgeInsets.only(bottom: 10.0),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
                body: TabBarView(
                    controller: controller, //配置控制器
                    children: tabs
                        .map(
                          (Tab tab) => GetGrid(tab.text),
                        )
                        .toList()),
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }
}

List<Tab> Gettab(int count) {
  List<Tab> list = List();
  if (count <= 50) {
    list.add(Tab(
      text: "1-${count}",
    ));
  } else {
    int i = 1;
    while (true) {
      if (count - i > 49) {
        list.add(Tab(
          text: "$i-${i + 49}",
        ));
        i += 50;
      } else {
        list.add(Tab(
          text: "$i-${count}",
        ));
        break;
      }
    }
  }
  return list;
}
