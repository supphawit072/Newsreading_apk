import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/Screens/Login/components/login_form.dart';
import 'package:test/Screens/Login/components/login_screen_top_image.dart';
import 'package:test/Screens/Welcome/welcome_screen.dart';
// import 'package:test/Screens/Login/components/login_form.dart';
// import 'package:test/Screens/Login/components/login_screen_top_image.dart';
import 'package:test/Screens/app/like.dart';
import '../../components/background.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPage extends StatefulWidget {
  const _NewPage({Key? key}) : super(key: key);

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  var jsonData;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ThailandNewData> dataList = [];

  get likedNewsList => null;

  get index => null;

  Future<String> _GetNewAPI() async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=8e6db1277f384a4b940343d9cd3ac03a'),
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(utf8.decode(response.bodyBytes));
        for (var data in jsonData['articles']) {
          ThailandNewData news = ThailandNewData(
            data['title'],
            data['description'],
            data['urlToImage'],
          );
          dataList.add(news);
        }
        return 'ok';
      } else {
        throw Exception('Failed to load news data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load news data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent.shade700,
        title: Text(
          " News",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.purple),
                accountName: Text(
                  "tataey",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  "tataey@tt.com",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/1.jpg"),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.red,
              ),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.person,
                color: Colors.red,
              ),
              title: Text(
                "My Account",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                _logout(context);
              },
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.purple, // สีพื้นหลังที่ต้องการ
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _logout(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
      body: Background(
        child: FutureBuilder(
          future: _GetNewAPI(),
          builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
          ) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Image.network('${dataList[index].urlToImage}'),
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          margin: EdgeInsets.all(15),
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          child: Align(
                            child: Text(
                              '${dataList[index].title}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 2,
                          ),
                          child: Column(
                            children: [
                              ExpansionTile(
                                title: Text(
                                  'Read More',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                children: [
                                  Text(
                                    '${dataList[index].description}',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              LikeButton(
                                onLiked: () {
                                  setState(() {
                                    dataList[index].isLiked = true;
                                    likedNewsList.add(dataList[index]);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return Container(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

void _logout(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => WelcomeScreen()),
    (Route<dynamic> route) => false,
  );
}

void _good(BuildContext context, dynamic likedData) {
  // นำข้อมูลที่ได้ไลค์มาใช้งานต่อไป
  print('Liked data: $likedData');
}

class ThailandNewData {
  String title;
  String description;
  String urlToImage;
  bool isLiked;

  ThailandNewData(this.title, this.description, this.urlToImage,
      {this.isLiked = false});
}
