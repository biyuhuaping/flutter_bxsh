import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class IndexPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('百姓生活+'),),
//       body: Center(
//         child: Text('百姓生活+'),
//       ),
//     );
//   }
// }

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home),
        // ignore: deprecated_member_use
        title: Text('首页')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search),
        // ignore: deprecated_member_use
        title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart),
        // ignore: deprecated_member_use
        title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        // ignore: deprecated_member_use
        title: Text('会员中心')),
  ];

  final List<Widget> tabbarViews = [
    HomePage(),
    CateGoryPage(),
    CartPage(),
    MemberPage()
  ];

  int currentIndex = 0;
  var currentPage;


  @override
  void initState() {
    currentPage = tabbarViews[currentIndex];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.init(context,designSize: Size(750, 1334), allowFontScaling: false);

    print('设备像素密度：${ScreenUtil().pixelRatio}');
    print('设备的宽：${ScreenUtil().screenWidth}');
    print('设备的高：${ScreenUtil().screenWidth}');

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index){
          setState(() {
            currentIndex = index;
            currentPage = tabbarViews[currentIndex];
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabbarViews,
      )
    );
  }
}
