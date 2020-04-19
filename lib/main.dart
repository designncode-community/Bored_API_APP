import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D&C DEMO',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Demo(),
    );
  }
}

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

String activity = "";
bool isLoading = true;

class _DemoState extends State<Demo> {
  void getdata() async {
    try {
      setState(() {
        isLoading = true;
      });
      Response response = await Dio()
          .get("http://www.boredapi.com/api/activity?participants=1");
      print(response.data['activity']);
      setState(() {
        isLoading = false;
        activity = response.data["activity"];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bored AF'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(child: Text(activity))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_download,
            color: isLoading ? Colors.red : Colors.indigo),
        onPressed: () {
          getdata();
        },
      ),
    );
  }
}
