import 'package:flutter/material.dart';
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
    country = "United States";
    gender = "Male";
    email = "john.doe@example.com";
    username = "johndoe123";
    phoneNumber = "+1 123-456-7890";
    name = "JOHN DOE";
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
      body: ListView(
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
                              'https://th.bing.com/th/id/R.1a1f10b6714487c2ce8f56baf90f3c15?rik=YaLjGFUF5m5ZcQ&riu=http%3a%2f%2fupload.wikimedia.org%2fwikipedia%2fcommons%2f9%2f9b%2fPhoto_of_a_kitten.jpg&ehk=D%2bCxp6dPLSkHfYa8JvraOQ0MScRDCwP95fuL7yMpZ7E%3d&risl=&pid=ImgRaw&r=0',
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
                      name!,
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
