import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import 'package:provide/provide.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CateGoryPage extends StatefulWidget {
  @override
  _CateGoryPageState createState() => _CateGoryPageState();
}

class _CateGoryPageState extends State<CateGoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Container(
          child: Row(
            children: <Widget>[
              LeftCaetgoryNav(),
              Column(
                children: <Widget>[
                  RightCategoryNav(),
                  CategoryGoodsList(),
                ],
              )
            ],
      )),
    );
  }
}

//左侧导航菜单
class LeftCaetgoryNav extends StatefulWidget {
  @override
  _LeftCaetgoryNavState createState() => _LeftCaetgoryNavState();
}

class _LeftCaetgoryNavState extends State<LeftCaetgoryNav> {
  List list = [];
  var listIndex = 0;//索引

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, val){
        _getGoodsList(context);
        // listIndex = val.categoryIndex;
        return Container(
          width: ScreenUtil().setWidth(180),
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1, color: Colors.black12)
              )
          ),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index){
              return _leftInkWell(index);
            },
          ),
        );
      },
    );
  }

  Widget _leftInkWell(int index){
    bool isClick = false;
    isClick = (index == listIndex)?true:false;
    return InkWell(
      onTap: (){
        setState(() {
          listIndex = index;
        });

        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        // Provide.value<ChildCategory>(context).changeCategory(categoryId,index);
        Provide.value<ChildCategory>(context).getChildCategory(childList,categoryId);
        _getGoodsList(context,categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(80),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick?Color.fromRGBO(236, 238, 239, 1.0):Colors.white,
            border: Border(
            bottom: BorderSide(width: 1,color: Colors.black12)
          )
        ),
        child: Text(list[index].mallCategoryName, style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );
  }

  //left得到后台大类数据
  void _getCategory(){
    request('getCategory').then((value){
      var data = jsonDecode(value.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      setState(() {
        list = category.data;
        // Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto,'4');
      });
      Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto,'4');
    });
  }

  //left得到商品列表数据
  void _getGoodsList(context,{String categoryId}){
    var data = {
      'categoryId':categoryId==null?Provide.value<ChildCategory>(context).categoryId:categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).subId,
      'page':1
    };
    request('getMallGoods',formData:data ).then((val){
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      // Provide.value<CategoryGoodsList>(context).getGoodsList(goodsList.data);
      Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
    });
  }
}


//右侧小类类别
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  //List list = ['111','222','333','444','555','666','777','888','999','000'];
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context,child,childCategory){
        return Container(
          width: ScreenUtil().setWidth(570),
          height: ScreenUtil().setHeight(80),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(width: 1,color: Colors.black12)
              )
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index){
              return _rightInkWell(childCategory.childCategoryList[index], index);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDto item, int index){
    bool isClick = false;
    isClick = (index == Provide.value<ChildCategory>(context).childIndex)?true:false;

    return InkWell(
      onTap: (){
        Provide.value<ChildCategory>(context).changeChildIndex(index, item.mallSubId);
        _getGoodsList(context, item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28),
            color: isClick?Colors.pink:Colors.black
          ),
        ),
      ),
    );
  }

  //right得到商品列表数据
  void _getGoodsList(context,String categorySubId) {
    var data = {
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':categorySubId,
      'page':1
    };

    request('getMallGoods',formData:data ).then((val){
      var  data = json.decode(val.toString());
      CategoryGoodsListModel goodsList =  CategoryGoodsListModel.fromJson(data);
      // Provide.value<CategoryGoodsList>(context).getGoodsList(goodsList.data);
      if(goodsList.data == null){
        print('>>>>>>>>>>>>>>>>>>>>>>>空的！！');
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList([]);
      }else{
        print('>>>>>>>>>>>>>>>>>>>>>>>>有！！');
        Provide.value<CategoryGoodsListProvide>(context).getGoodsList(goodsList.data);
      }
    });
  }
}


//商品列表，可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data){
        try{
          if(Provide.value<ChildCategory>(context).page == 1){
            //列表位置滚回最上边
            scrollController.jumpTo(0.0);
          }
        }catch(e){
          print('进入页面第一次初始化${e}');
        }

        if(data.goodsList.length > 0){
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              // height: ScreenUtil().setHeight(972),
              child: EasyRefresh(
                footer: ClassicalFooter(
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    infoColor: Colors.pink,
                    showInfo: true,
                    noMoreText: Provide.value<ChildCategory>(context).noMoreText,
                    // infoText: '加载中',
                    loadReadyText: '上拉加载……'
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: data.goodsList.length,
                  itemBuilder: (context, index){
                    print('===============有数据');
                    return _listWidget(data.goodsList, index);
                  },
                ),
                // onRefresh: () async{
                //   //刷新
                //   page = 1;
                //   _getHotGoods(page, true);
                // },
                onLoad: () async {
                  //加载更多
                  if(Provide.value<ChildCategory>(context).noMoreText == '没有更多了'){
                    Fluttertoast.showToast(
                        msg: "已经到底了",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.pink,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }else{
                    _getMoreList();
                  }
                },
              ),
            ),
          );
        }else{
          print('===============没数据');
          return Text('暂无数据');
        }
      },
    );
  }

  //上拉加载更多的方法
  void _getMoreList(){
    Provide.value<ChildCategory>(context).addPage();
    var data = {
      'categoryId':Provide.value<ChildCategory>(context).categoryId,
      'categorySubId':Provide.value<ChildCategory>(context).subId,
      'page':Provide.value<ChildCategory>(context).page
    };

    request('getMallGoods',formData:data ).then((val){
      var  data = json.decode(val.toString());
      CategoryGoodsListModel goodsList=  CategoryGoodsListModel.fromJson(data);
      if(goodsList.data == null){
        Provide.value<ChildCategory>(context).changeNoMore('没有更多了');
      }else{
        Provide.value<CategoryGoodsListProvide>(context).addGoodsList(goodsList.data);
      }
    });
  }

  Widget _listWidget(List newList, index){
    return InkWell(
      onTap: (){
        // Application.router.navigateTo(context,"/detail?id=${newList[index].goodsId}");
      },
      child: Container(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 0.5, color: Colors.black12),
          )
        ),
        child: Row(
          children: <Widget>[
            _goodsImage(newList,index),
            Column(
              children: <Widget>[
                _goodsName(newList,index),
                _goodsPrice(newList,index)
              ],
            )
          ],
        ),
      ),
    );
  }

  //商品图片
  Widget _goodsImage(List newList, index){
    return Container(
      // padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(150),
      child: Image.network(newList[index].image),
    );
  }

  //商品名称方法
  Widget _goodsName(List newList, index){
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //商品价格方法
  Widget _goodsPrice(List newList, index){
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：¥${newList[index].presentPrice}',
            style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),),
          Text(
            '¥${newList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough),)
        ],
      ),
    );
  }
}
