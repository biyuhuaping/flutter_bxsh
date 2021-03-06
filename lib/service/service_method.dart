import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/servcie_url.dart';

//通用网络请求接口
// {formData}带上{}表示非必填
Future request(url,{formData})async{
  try{
    //print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();
    if(formData == null){
      response = await dio.post(servicePath[url]);
    }else{
      response = await dio.post(servicePath[url],data:formData);
    }
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }
}

//获取首页主题内容
Future getHomePageContent() async{
  try{
    print('开始请求首页数据……');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();

    var formData = {'lon':'116.4744873046875','lat':'39.99518966674805'};
    response = await dio.post(servicePath['homePageContext'],data: formData);
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }
}

//获得火爆专区商品的方法
Future getHomePageBeloConten() async{
  try{
    print('开始获取下拉列表数据.................');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();
    int page = 1;
    response = await dio.post(servicePath['homePageBelowConten'],data:page);
    if(response.statusCode == 200){
      return response.data;
    }else{
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  }catch(e){
    return print('ERROR:======>${e}');
  }
}









//钱研社接口对接成功
void _getHttp() async{
  try{
    //唯一标识符号uuid
    String uuid = '14e301150d1a4c56a35273325e2ac780';

    //授权码
    String authorization = '1c1317e81edf4c26a6ca10f44fbf44bd';

    //接口
    String url = 'http://app.mkwhat.com/program/queryShares';


    Dio dio = new Dio();
    dio.options.headers['Authorization'] = authorization;

    var data = {'uuid':uuid};
    Response response = await dio.get(
        url,
        queryParameters:data
    );
    return print(response);
  }catch(error){
    return print(error);
  }
}