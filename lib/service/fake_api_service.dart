import 'dart:convert';
import 'dart:io';


import 'package:fakeapiresponse/model/user.dart';
import 'package:http/http.dart';

import '../Helper/httpresponse.dart';


class FakeApiResponse{
static Future<HTTPResponse<List<User>>> getResponse()async{

  String url="https://jsonplaceholder.typicode.com/users";
  try{
    var response = await get(Uri.parse(url));
    if(response.statusCode == 200){
      var body=jsonDecode(response.body);
      List<User> userList=[];
      body.forEach((e){

        User user=User.fromJson(e);
        userList.add(user);
      });

      return HTTPResponse(true, userList, "Successful", 200);
    }else {

      return HTTPResponse(false, [], "unSuccessful", response.statusCode);

    }



  } on SocketException{

    return HTTPResponse(false, [], "can not connect Internet Connection",0);
  } on FormatException{

    return HTTPResponse(false, [], "can not connect Internet Connection",1);
  } catch(e){

    return HTTPResponse(false, [], "can not connect Internet Connection",0);
  }

}

}