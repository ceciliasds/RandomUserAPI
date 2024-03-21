//homepage-frontend

import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? hoveredDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[200],
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 2, 27),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.yellow,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://th.bing.com/th/id/R.1a1f10b6714487c2ce8f56baf90f3c15?rik=YaLjGFUF5m5ZcQ&riu=http%3a%2f%2fupload.wikimedia.org%2fwikipedia%2fcommons%2f9%2f9b%2fPhoto_of_a_kitten.jpg&ehk=D%2bCxp6dPLSkHfYa8JvraOQ0MScRDCwP95fuL7yMpZ7E%3d&risl=&pid=ImgRaw&r=0',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'JOHN DOE'.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                  ),
                  SizedBox(height: 10),
                    
                 if (hoveredDetail != null) ...[
                    Center(
                      child: Text(
                        hoveredDetail!,
                      ),
                    ),
                  ],
                  Divider(color: Colors.grey),
                  SizedBox(height: 15),
                  _buildIconsRow(),
                  
                ],
              ),
            ),
          ],
        ),
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
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildIconWithDetail(Icons.pin_drop_outlined, 'I am from United States', 'Country', Colors.blue),
        _buildIconWithDetail(Icons.male_outlined, 'My gender is Male', 'Gender', Colors.green),
        _buildIconWithDetail(Icons.email, 'You can contact me at johndoe@example.com', 'Email', Colors.orange),
        _buildIconWithDetail(Icons.person, 'The username I use is johndoe123', 'Username', Colors.purple),
        _buildIconWithDetail(Icons.call, 'This is my number: +1234567890', 'Phone Number', Colors.red),
      ],
    );
  }

  Widget _buildIconWithDetail(IconData iconData, String detail, String tooltipMessage, Color color) {
    return Tooltip(
      message: tooltipMessage,
      preferBelow: false,
      child: MouseRegion(
        onEnter: (_) {
          if (hoveredDetail != detail) {
            setState(() {
              hoveredDetail = detail;
            });
          }
        },
        onExit: (_) {
         
        },
        child: Column(
          children: [
            Icon(iconData, color: color),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
  ));
}

