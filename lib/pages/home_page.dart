import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../routers/application.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  int page = 1;
  List<Map> hotGoodsList = [];

  EasyRefreshController _controller = EasyRefreshController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('1111111111111');
    _getHotGoods(page, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formData = {'lon':'115.02932','lat':'35.76189'};
    return Scaffold(
      appBar: AppBar(title: Text('百姓生活+'),),
      body: FutureBuilder(
        future:request('homePageContext',formData:formData),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            List<Map> recommendList = (data['data']['recommend'] as List).cast();
            String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
            String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
            List<Map> floor1  = (data['data']['floor1'] as List).cast();
            List<Map> floor2  = (data['data']['floor2'] as List).cast();
            List<Map> floor3  = (data['data']['floor3'] as List).cast();

            return EasyRefresh(
              controller: _controller,
              footer: ClassicalFooter(
                bgColor: Colors.white,
                textColor: Colors.pink,
                infoColor: Colors.pink,
                showInfo: true,
                noMoreText: '没有更多数据',
                // infoText: '加载中',
                loadReadyText: '上拉加载……'
              ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiper),
                    TopNavigator(navigatorList),
                    AdBanner(adPicture),
                    LeaderPhone(leaderImage, leaderPhone),
                    Recommend(recommendList),
                    FloorTitle(floor1Title),
                    FloorContent(floor1),
                    FloorTitle(floor2Title),
                    FloorContent(floor2),
                    FloorTitle(floor3Title),
                    FloorContent(floor3),
                    // HotGoods(),
                    _hotGoods(),
                  ],
                ),
              onRefresh: () async{
                //刷新
                page = 1;
                _getHotGoods(page, true);
              },
              onLoad: () async {
                //加载更多
                page++;
                _getHotGoods(page, false);
              },
            );
          }else{
            return Center(
              child: Text('数据加载中……'),
            );
          }
        },
      ),
    );
  }

  //火爆商品接口，上拉加载、下拉刷新
  void _getHotGoods(int page, bool isRefresh){
    var formPage = {'page':page};
    request('homePageBelowConten', formData: formPage).then((value){
      var data = json.decode(value.toString());
      List<Map> newGoodsList = (data['data'] as List ).cast();

      if(page == 1){
        hotGoodsList.clear();
      }
      if(isRefresh){//下拉刷新
        _controller.resetLoadState();
      }else{//加载更多
        if(newGoodsList.length < 20){
          _controller.finishLoad(success: true, noMore: true);
        }
      }

      setState(() {
        hotGoodsList.addAll(newGoodsList);
      });
    });
  }

  //火爆专区标题
  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    padding:EdgeInsets.all(5.0),
    alignment:Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        border:Border(
            bottom: BorderSide(width:0.5 ,color:Colors.black12)
        )
    ),
    child: Text('火爆专区'),
  );

  //火爆专区子项
  Widget _wrapList(){
    if(hotGoodsList.length!=0){
      List<Widget> listWidget = hotGoodsList.map((val){
        return InkWell(
            onTap:(){
              Application.router.navigateTo(context,"/detail?id=${val['goodsId']}");
            },
            child: Container(
              width: ScreenUtil().setWidth(372),
              color:Colors.white,
              padding: EdgeInsets.all(5.0),
              margin:EdgeInsets.only(bottom:3.0),
              child: Column(
                children: <Widget>[
                  Image.network(val['image'],width: ScreenUtil().setWidth(375),),
                  Text(
                    val['name'],
                    maxLines: 1,
                    overflow:TextOverflow.ellipsis ,
                    style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(26)),
                  ),
                  Row(
                    children: <Widget>[
                      Text('￥${val['mallPrice']}'),
                      Text(
                        '￥${val['price']}',
                        style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),
                      )
                    ],
                  )
                ],
              ),
            )
        );
      }).toList();

      return Wrap(
        spacing: 2,//2列
        children: listWidget,
      );
    }else{
      return Text('火爆专区数据为空');
    }
  }

  //火爆专区组合
  Widget _hotGoods(){
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }
}

//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  SwiperDiy(this.swiperDataList);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: ScreenUtil().setHeight(275),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              Application.router.navigateTo(context,"/detail?id=${swiperDataList[index]['goodsId']}");
            },
            child: Image.network("${swiperDataList[index]['image']}"),
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true ,
      ),
    );
  }
}

//首页金刚位
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator(this.navigatorList);
  Widget _gridViewItemUI(BuildContext context, item){
    return InkWell(
      onTap: (){
        // _goCategory(context,index,item['mallCategoryId']);
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'],width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  // void _goCategory(context,int index,String categroyId) async {
  //   await request('getCategory').then((val) {
  //     var data = json.decode(val.toString());
  //     CategoryModel category = CategoryModel.fromJson(data);
  //     List list = category.data;
  //     Provide.value<ChildCategory>(context).changeCategory(categroyId,index);
  //     Provide.value<ChildCategory>(context).getChildCategory( list[index].bxMallSubDto,categroyId);
  //     Provide.value<CurrentIndexProvide>(context).changeIndex(1);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if(this.navigatorList.length > 10){
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }
    return Container(
      height: ScreenUtil().setHeight(260),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),//禁止滚动
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item){
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//广告区域
class AdBanner extends StatelessWidget {
  final String adPicture;
  AdBanner(this.adPicture);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

//店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage;//店长图片
  final String leaderPhone;//店长电话
  LeaderPhone(this.leaderImage, this.leaderPhone);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          _launchURL();
        },
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async{
    print('电话号码：${leaderPhone}');
    String url = 'tel:' + leaderPhone;//'https://www.baidu.com';
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw '============= url无法访问';
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend(this.recommendList);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          _titleWidget(),
          _recommedList(context)
        ],
      ),
    );
  }

  //推荐商品标题
  Widget _titleWidget(){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 5.0),
      decoration: BoxDecoration(//BoxDecoration盒子控件
        color: Colors.white,
        border: Border(//Border边界控件
          bottom: BorderSide(width: 0.5, color: Colors.black12)
        )
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink)
      )
    );
  }

  //商品单独项方法
  Widget _item(context,index){
    return InkWell(
      onTap: (){
        Application.router.navigateTo(context,"/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(width: 0.5,color: Colors.black12)
          )
        ),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text(
              '¥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }

  //横向列表方法
  Widget _recommedList(BuildContext context){
    return Container(
      height: ScreenUtil().setHeight(270),
      // margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index){
          return _item(context,index);
        },
      ),
    );
  }
}

//楼层标题
class FloorTitle extends StatelessWidget {
  final String picture_address;
  FloorTitle(this.picture_address);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(picture_address),
    );
  }
}

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  FloorContent(this.floorGoodsList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context)
        ],
      ),
    );
  }

  Widget _firstRow(context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context,floorGoodsList[1]),
            _goodsItem(context,floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context){
    return Row(
      children: <Widget>[
        _goodsItem(context,floorGoodsList[3]),
        _goodsItem(context,floorGoodsList[4]),
      ],
    );
  }


  Widget _goodsItem(context, Map goods){
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: (){
          Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

//火爆专区
class HotGoods extends StatefulWidget {
  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  @override
  void initState() {
    request('homePageBelowConten',formData: 1).then((value){
      print(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
