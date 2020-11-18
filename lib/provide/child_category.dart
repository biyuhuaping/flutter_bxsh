import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];//商品列表
  int childIndex = 0; //子类索引值
  int categoryIndex = 0; //大类索引
  String categoryId = '4'; //大类ID，默认4
  String subId =''; //小类ID

  //点击大类时更换
  getChildCategory(List<BxMallSubDto> list, String id){
    childIndex = 0;
    categoryId = id;

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = 'null';
    all.mallSubName = '全部';

    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引 ,
  changeChildIndex(int index,String id){
    // isNewCategory = true;
    // //传递两个参数，使用新传递的参数给状态赋值
    childIndex = index;
    subId = id;
    // page = 1;
    // noMoreText = '';
    notifyListeners();
  }
}