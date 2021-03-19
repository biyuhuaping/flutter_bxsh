import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provide/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provider.of<DetailsInfoProvide>(context).goodsInfo.data.goodInfo.goodsDetail;
    return Consumer<DetailsInfoProvide>(
        builder: (context, child, val){
          var isLeft = Provider.of<DetailsInfoProvide>(context).isLeft;
          if(isLeft){
            return Container(
              child: Html(
                data: goodsDetails,
              ),
            );
          }else{
            return Container(
              width: ScreenUtil().setWidth(750),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text('暂无数据'),
            );
          }
        });
  }
}
