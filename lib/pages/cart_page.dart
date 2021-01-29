import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/cart.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';
import '../provide/currentIndex.dart';



class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('购物车'),
        ),
      body: FutureBuilder(
        future: _getCartInfo(context),
        builder: (context, snapshot){
          return Provide<CartProvide>(
              builder: (context, child, childCategory){
                List cartList = Provide.value<CartProvide>(context).cartList;
                print('==========${cartList.length}=======');
                if(cartList.length > 0){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (context, index){
                            return CartItem(cartList[index]);
                          },
                        ),
                      ),
                      CartBottom(),
                    ],
                  );
                }else{
                  return Scaffold(
                    // backgroundColor: Colors.orange,
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('购物车是空的'),
                          InkWell(
                            onTap: (){
                              Provide.value<CurrentIndexProvide>(context).changeIndex(0);
                            },
                            child: Container(
                              // color: Colors.red,
                              margin: EdgeInsets.only(top: 10),
                              width: ScreenUtil().setWidth(220),
                              height: ScreenUtil().setHeight(60),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                              ),
                              child: Text(
                                  '随便逛逛',
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }
          );
          /*if(snapshot.hasData){
            return Stack(
              children: <Widget>[
                Provide<CartProvide>(
                builder: (context, child, childCategory){
                  List cartList = Provide.value<CartProvide>(context).cartList;
                  return ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (context, index){
                      return CartItem(cartList[index]);
                    },
                  );
                },
              ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: CartBottom(),
                )
              ],
            );
          }else{
            return Text('正在加载');
          }*/
        },
      )
    );
  }

  Future<String> _getCartInfo(BuildContext context) async{
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}



/*class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List <String>list = [];
  @override
  Widget build(BuildContext context) {
    _show();
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(list[index]),
                );
              },
            ),
          ),
          RaisedButton(
            onPressed: (){
              _add();
            },
            child: Text('增加'),
          ),
          RaisedButton(
            onPressed: (){
              _clear();
            },
            child: Text('清空'),
          )
        ],
      ),
    );
  }
  
  //增加方法
  void _add()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = '周博是最棒的！';
    list.add(temp);
    prefs.setStringList('testInfo', list);
    _show();
  }

  //查询
  void _show () async{
    SharedPreferences perfs = await SharedPreferences.getInstance();
    List <String>templist = perfs.getStringList('testInfo');
    if(templist != null){
      setState(() {
        list = templist;
      });
    }
  }

  //删除
  void _clear () async{
    SharedPreferences perfs = await SharedPreferences.getInstance();
    // perfs.clear();//删除所有
    perfs.remove('testInfo');

    setState(() {
      list = [];
    });
  }

}*/

