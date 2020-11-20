import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];//商品列表
  int childIndex = 0; //子类索引值
  int categoryIndex = 0; //大类索引
  String categoryId = '4'; //大类ID，默认4
  String subId =''; //小类ID
  int page = 1;  //列表页数，当改变大类或者小类时进行改变
  String noMoreText = ''; //显示更多的表示
  bool isNewCategory = true;


  //点击大类时更换
  getChildCategory(List<BxMallSubDto> list, String id){
    isNewCategory = true;
    categoryId = id;
    childIndex = 0;
    page = 1;
    subId = ''; //点击大类时，把子类ID清空
    noMoreText = '';

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
    isNewCategory = true;
    //传递两个参数，使用新传递的参数给状态赋值
    childIndex = index;
    subId = id;
    page = 1;
    noMoreText = '';
    notifyListeners();
  }

  //增加Page的方法f
  addPage(){
    page++;
  }
  //改变noMoreText数据
  changeNoMore(String text){
    noMoreText = text;
    notifyListeners();
  }
  //改变为flase
  changeFalse(){
    isNewCategory = false;
  }
}