import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_app_flutter/post_model.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  State<PostListPage> createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  int index = 0;

  bool isLoading = false;

  List<PostModel> posts = [];

  fetchPost() async {
    isLoading = true;
    setState(() {});

    http.Client client = http.Client();

    http.Response response = await client.get(
      Uri.parse('https://api.restful-api.dev/objects'),
    );

    var result = json.decode(response.body);

    posts = List<PostModel>.from(result.map((x) => PostModel.fromJson(x)));
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    fetchPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: List.generate(
              10,
              (index) => Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(children: [Text('Item $index')]),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(title: Text('Post')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          index == 0
              ? isLoading
                    ? CircularProgressIndicator()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (context, index) => Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 30,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? Colors.red : Colors.green,
                            ),
                            child: Text(posts[index].name),
                          ),
                        ),
                      )
              : index == 1
              ? Container(child: Text('Settings Page'))
              : Container(child: Text('Profile Page')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          this.index = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
