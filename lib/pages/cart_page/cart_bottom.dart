import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5.0),
        color: Colors.white,
        width: ScreenUtil().setWidth(750),
        child: Provide<CartProvide>(
          builder: (context,child,childCategory){
            return  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                selectAllBtn(context),
                allPriceArea(context),
                goButton(context)
              ],
            );
          },
        )
    );
  }

  //全选按钮
  Widget selectAllBtn(context){
    bool isAllcheck = Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllcheck,
            activeColor: Colors.pink,
            onChanged: (bool val){
              Provide.value<CartProvide>(context).changeAllCheckBtnState(val);
            },
          ),
          Text('全选')
        ],
      ),
    );
  }

  // 合计区域
  Widget allPriceArea(context){
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '合计：',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(36)
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  // width: ScreenUtil().setWidth(150),
                  child: Text(
                    '¥${allPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(36),
                        color: Colors.red
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // width: ScreenUtil().setWidth(430),
              alignment: Alignment.centerRight,
              child: Text(
                '满10元免配送费，预购免配送费',
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: ScreenUtil().setSp(22)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //结算按钮
  Widget goButton(context){
    int allGoodsCount = Provide.value<CartProvide>(context).allGoodsCount;
    return Container(
      // width: ScreenUtil().setWidth(160),
      margin: EdgeInsets.only(left: 10,right: 10),
      child: InkWell(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0)
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
