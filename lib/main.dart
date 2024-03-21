//main.dart-empty
import 'package:flutter/material.dart';
//insert1
import 'dart:convert';
import 'variables.dart';
import 'package:http/http.dart' as http;
import 'package:random_user/homepage.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    ));

//change the one that is here
class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
} //up to here

class _LoadingState extends State<Loading> {
  //insert2 Future void and overrride
  Future<void> getData() async {
    try {
      final response =
      await http.get(Uri.parse(url)).timeout(Duration(seconds: 6));
      print("connected");
      data = [jsonDecode(response.body)];
      print(data[0]['results'][0]['name']['first']);
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Message'),
              content: Text('No internet connection'),
              actions: [
                TextButton(
                    onPressed: () {
                      getData();
                      Navigator.pop(context);
                    },
                    child: Text('Retry'))
              ],
            );
          });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  } //up to here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Material(
                    elevation: 4,
                    shape: CircleBorder(),
                    child: ClipOval(
                      child: SizedBox(
                        width:130,
                        height: 130,
                        child: Image.network(
                          'https://cdn.dribbble.com/users/1210339/screenshots/2767019/avatar18.gif',
                          fit: BoxFit
                              .cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Random User API',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(color: Colors.green),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
