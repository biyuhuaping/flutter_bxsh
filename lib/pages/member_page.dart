import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(),
          _orderType(),
          _actionList(),
        ],
      )
    );
  }

  //headerView
  Widget _topHeader(){
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network('https://t7.baidu.com/it/u=2701208059,2978966657&fm=193&f=GIF', width: 100, height: 100,)
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
                '用户姓名',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }

  //我的订单顶部
  Widget _orderTitle(){
    return Container(
      margin: EdgeInsets.only(top:10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:BorderSide(width: 0.5,color:Colors.black12)
          )
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title:Text('我的订单'),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }


  Widget _orderType(){
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                Text('待付款')
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货')
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('待收货')
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30,
                ),
                Text('待评价')
              ],
            ),
          ),
        ],
      ),
    );
  }


  //通用ListTitle (cell)
  Widget _myListTile(title){
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:BorderSide(width: 0.5,color:Colors.black12)
          )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title:Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }


  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('客服电话'),
          _myListTile('关于我们'),
        ],
      ),
    );
  }
}