import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import './provide/currentIndex.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentProvide = CurrentIndexProvide();
  var providers = Providers();

  providers
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentProvide))
    ..provide(Provider<ChildCategory>.value(childCategory));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    return ScreenUtilInit(
      designSize:Size(750, 1334),
      allowFontScaling: false,
      builder: () => MaterialApp(
          title: '百姓生活+',
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator,
          theme: ThemeData(
          primaryColor: Colors.pink
      ),
      home: IndexPage(),
    ),
    );
  }
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}