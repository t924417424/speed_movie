import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:provider/provider.dart';
import 'package:speed_movie/plugin/Dialog.dart';
import 'package:speed_movie/plugin/HttpUtil.dart';
import 'package:speed_movie/provide/theme.dart';

class result extends StatefulWidget {
  final String search_text;

  result({
    Key key,
    @required this.search_text,
  }) : super(key: key);

  @override
  _resultState createState() => _resultState();
}

class _resultState extends State<result> {
  List<dynamic> result_list = List();
  ScrollController _scrollController;
  int loadpage = 0;
  int pagecount = 0;
  bool isload = false;

  void MyUpDate(Map<String,dynamic> data){
    setState(() {
      this.pagecount = data['pagecount'];
      this.loadpage ++;
      if(loadpage > 1){
        Navigator.pop(context);
      }
      data['list'].forEach((item){
        //print(item);
        this.result_list.add(item);
      });
      this.isload = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Loaddata(context, widget.search_text,loadpage,pagecount, this.MyUpDate);
    _scrollController = ScrollController();
    // 监听ListView是否滚动到底部
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        if(pagecount > 0){
          if(!isload && loadpage < pagecount){  //当前不处于加载状态,且当前加载的页码小于总页码
            print('滑动到了底部');
            setState(() {
              this.isload = true;
            });
            Loaddata(context, widget.search_text,loadpage,pagecount, this.MyUpDate);
          }
        }
        // 这里可以执行上拉加载逻辑
      }
    });
  }

//  HttpUtil.get('/api/search/${widget.search_text}', success: (data) {
//  print(data.toString());
//  //result_list = data['list'];
//  print(data['list'].length);
//  setState(() {
//  result_list = data['list'];
//  });
//  }, error: (errorMsg) {
//  ShowToast(context, errorMsg,type: DialogType.Window);
//  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 1080, height: 1920, allowFontScaling: false);
    print(MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text(widget.search_text),
          ),
          preferredSize: Size.fromHeight(ScreenUtil.screenHeight * 0.06)),
      body: Container(
        child: Column(
          children: <Widget>[
//            SizedBox(
//              height: ScreenUtil.screenHeight * 0.03,
//            ),
            //start_load(context),
            Container(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - ScreenUtil.screenHeight * 0.06,   //屏幕总高度 - 状态栏高度 - Appbar高度
              //padding: EdgeInsets.only(top: 0,bottom: 0),
              child: ListView.builder(
                //padding: EdgeInsets.only(bottom: 100),
                controller: _scrollController,
                itemCount: result_list.isEmpty ? 5 : result_list.length,
                itemBuilder: (BuildContext context, int i) {
                  if (result_list.isEmpty){
                    return start_load(context);
                  }
                  return GestureDetector(
                    child: result_item(context,result_list[i]),
                    onTap: (){
                      ShowInfo(context,result_list[i]['vod_id']);
                    },
                  );
                }),
            )
          ],
        ),
      ),
    );
  }
}

Widget start_load(BuildContext context) {
  return Provider.of<MyTheme>(context).MyThemeMode
      ? PKDarkCardSkeleton(
          isCircularImage: true,
          isBottomLinesActive: true,
        )
      : PKCardSkeleton(
          isCircularImage: true,
          isBottomLinesActive: true,
        );
}

Widget result_item(BuildContext context,Map<String,dynamic> result) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: BlurryContainer(
      padding: EdgeInsets.all(16),
      width: ScreenUtil.screenWidth,
      height: ScreenUtil().setSp(410),
      borderRadius: BorderRadius.circular(10),
      bgColor: Provider.of<MyTheme>(context).MyThemeMode
          ? Colors.white30
          : Colors.grey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: ScreenUtil.screenWidth * 0.13,
                height: ScreenUtil.screenWidth * 0.13,
                color: Colors.white54,
                child: Center(
                  child: Text(
                    result['vod_name'].toString().substring(0,1),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(90),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                height: ScreenUtil.screenWidth * 0.13,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //height: ScreenUtil.screenHeight * 0.008,
                      width: ScreenUtil.screenWidth * 0.6,
                      //color: Colors.white54,
                      child: Text(result['vod_name'],style: TextStyle(fontSize: ScreenUtil().setSp(45)),overflow: TextOverflow.ellipsis,maxLines: 2,softWrap: true,),
                    ),
//                    Container(
////                      height: ScreenUtil.screenHeight * 0.007,
////                      width: ScreenUtil.screenWidth * 0.2,
////                      color: Colors.white54,
//                      child: Text(result['type_name'],style: TextStyle(fontSize: ScreenUtil().setSp(45)),overflow: TextOverflow.ellipsis,maxLines: 1,),
//                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: ScreenUtil().setSp(110),
            width: ScreenUtil.screenWidth,
            child: Text(
              "类别：${result['type_name']}\t\t\t\t\t\t\t\t\t说明：${result['vod_remarks']}\r\n更新时间：${result['vod_time']}",
              style: TextStyle(fontSize: ScreenUtil().setSp(40)),
              softWrap: true,
              overflow: TextOverflow.fade,
              maxLines: 3,
            ),
          )
        ],
      ),
    ),
  );
}

void Loaddata(BuildContext context,String search_text,int page,int count,Function success_callback){
  String url = '/api/search/${search_text}';
  if(count > 1 && page <= count){
    url = url + "?page=${page + 1}";
    Start_loading(context);
  }
  //Start_loading(context);
  HttpUtil.get(url.toString(), success: (data) {
   // Navigator.pop(context);
    if(data['list'].isEmpty){
      print("结果为空");
      ShowToast(context, "搜索结果为空", type: DialogType.Window);
      return;
    }
    success_callback(data);
  }, error: (errorMsg) {
    Navigator.pop(context);
    ShowToast(context, errorMsg, type: DialogType.Window);
  });
}

void ShowInfo(BuildContext context,int vid){
  ShowVod(context,vid);
}