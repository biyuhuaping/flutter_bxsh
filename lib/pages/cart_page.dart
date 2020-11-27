import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartPage extends StatefulWidget {
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
            child: Text('删除'),
          )
        ],
      ),
    );
  }
  
  //增加方法
  void _add()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = 'ajsjalksdjlkja';
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

}

