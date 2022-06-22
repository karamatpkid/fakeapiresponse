import 'package:fakeapiresponse/service/fake_api_service.dart';
import 'package:fakeapiresponse/view_model/userprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Helper/httpresponse.dart';
import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>UserProvider(),
      child: MaterialApp(
        title: 'Fake Api hit response',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
               primarySwatch: Colors.green,
        ),
        home: const MyHomePage(title: 'Fake Api hit response'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Consumer<UserProvider>(
        builder: (context,provider,child){
                if (provider.httpResponse.isSuccessfull) {
              List<User> userList=provider.httpResponse.data;
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(

                        trailing: Text(
                          userList[index].id!.toString(),
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(userList[index].name.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("${userList[index].address!.street} ${userList[index].address!.city}"),
                                ),

                              ],
                            ),
                          ],
                        ));
                  },



              );
            } else {


              return Text(provider.httpResponse.message.toString());
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  () async {

          userProvider.getResponse();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
