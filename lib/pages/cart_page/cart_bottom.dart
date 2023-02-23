import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        width: ScreenUtil().setWidth(750),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            selectAllBtn(context),
            allPriceArea(context),
            goButton(context)
          ],
        )
    );
  }

  //全选按钮
  Widget selectAllBtn(context){
    return Container(
      child: Row(
        children: <Widget>[
          Consumer<CartProvide>(builder: (context, childCategory, child){
            return Checkbox(
              value: childCategory.isAllCheck,
              activeColor: Colors.pink,
              onChanged: (bool val) {
                childCategory.changeAllCheckBtnState(val);
              },
            );
          }),
          Text('全选')
        ],
      ),
    );
  }

  // 合计区域
  Widget allPriceArea(context){
    double allPrice = Provider.of<CartProvide>(context,listen: false).allPrice;
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
    int allGoodsCount = Provider.of<CartProvide>(context,listen: false).allGoodsCount;
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
            '结算($allGoodsCount)',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
