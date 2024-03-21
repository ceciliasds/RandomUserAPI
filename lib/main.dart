import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    ));

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.teal[200],
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
