import 'package:fakeapiresponse/Helper/httpresponse.dart';
import 'package:flutter/cupertino.dart';

import '../service/fake_api_service.dart';

class UserProvider  extends ChangeNotifier{
  HTTPResponse httpResponse = HTTPResponse(false, [], "No Data", 5);
  void getResponse()async{
    httpResponse = await FakeApiResponse.getResponse();
    notifyListeners();
  }
}