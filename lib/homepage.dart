import 'package:flutter/material.dart';
import 'dart:convert';
import 'variables.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? selectedDetail;
  String? name;
  String? country;
  String? gender;
  String? email;
  String? username;
  String? phoneNumber;
  String? image;

    @override
  void initState() {
    super.initState();
     getData();
  }

   Future<void> getData() async {
    selectedDetail = null;
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 6));
      print("connected");
      setState(() {
        data = [jsonDecode(response.body)];
        image = data[0]['results'][0]['picture']['large'];
        name = data[0]['results'][0]['name']['title'] + '. ' + data[0]['results'][0]['name']['first'] +' '+ data[0]['results'][0]['name']['last'];
        country = data[0]['results'][0]['location']['country'];
        gender = data[0]['results'][0]['gender'];
        email = data[0]['results'][0]['email'];
        username = data[0]['results'][0]['login']['username'];
        phoneNumber = data[0]['results'][0]['phone'];
      });
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
                child: Text('Retry'),
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 2, 2, 27),
        title: Text('RANDOM USER'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        child: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 75, 74, 74).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (name != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 4,
                        shape: CircleBorder(),
                        child: ClipOval(
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: Image.network(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      name!.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5),
                  if (selectedDetail != null) ...[
                    Center(
                      child: Column(
                        children: [
                          Text(
                            selectedDetail!,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 5),
                  Divider(color: Colors.grey),
                  SizedBox(height: 15),
                  _buildIconsRow(),
                ],
              ],
            ),
          ),
        ],
       ),
        onRefresh: getData,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 2, 2, 27),
        child: Container(
          height: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: () {
                  getData();
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildIconsRow() {
  IconData genderIcon = gender == 'male' ? Icons.male_outlined : Icons.female_outlined;

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildIconWithDetail(Icons.pin_drop_outlined, 'I am from ', country!,'Country', Colors.blue),
      _buildIconWithDetail(genderIcon, 'My gender is ', gender!,'Gender', Colors.green),
      _buildIconWithDetail(Icons.email, 'You can contact me at ', email!,'Email', Colors.orange),
      _buildIconWithDetail(Icons.person, 'The username I use is ', username!,'Username', Colors.purple),
      _buildIconWithDetail(Icons.call, 'This is my number: ', phoneNumber!,'Phone Number', Colors.red),
    ],
  );
}

    Widget _buildIconWithDetail(IconData iconData,String title,String detail,String tooltipMessage,Color color,) {
    return Tooltip(
      message: tooltipMessage,
      preferBelow: false,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedDetail = title + detail;
          });
        },
        child: Column(
          children: [
            Material(
              elevation: 4,
              shape: CircleBorder(),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: title + detail == selectedDetail
                      ? Color.fromARGB(255, 195, 191, 191)
                      : Colors.transparent,
                ),
                child: Icon(
                  iconData,
                  color: color,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
