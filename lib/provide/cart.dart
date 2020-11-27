import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier{
  String cartString = "[]";
  save(goodsId,goodsName,count,price,images)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null?[]:json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      if(item['goodsId'] == goodsId){
        tempList[ival]['count'] = item['count']+1;
        isHave = true;
      }
      ival++;
    });
    if(!isHave){
      tempList.add({
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images,
      });
    }

    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    print('清空完成----------------');
    notifyListeners();
  }
}