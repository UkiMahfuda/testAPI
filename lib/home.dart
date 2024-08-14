import 'package:flutter/material.dart';
import 'package:myapp/model.dart';
import 'package:myapp/navbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: MyNavbar(),
        // body: ListView(
        //   children: [
        //     Row(
        //       children: [Text("Text View Data Ruang")],
        //     )
        //   ],
        // ),
        body: PostList(posts: fetchPosts()),
      ),
    );
  }
}

//Fungsi Ambil API
Future<List<Post>> fetchPosts() async {
  final response = await http
      .get(Uri.parse('https://webpinjamruang.vercel.app/api/api/daftarRuang'));

  if (response.statusCode == 200) {
    dynamic jsonResponse = json.decode(response.body);
    print('Data yang diterima: $jsonResponse');
    if (jsonResponse is Map && jsonResponse['data'] is List) {
      // Jika data dalam bentuk map dengan key 'data'
      List<dynamic> data = jsonResponse['data'];
      return data.map((post) => Post.fromJson(post)).toList();
    } else {
      // Handle kasus lain
      throw Exception('Struktur data API tidak sesuai');
    }
  } else {
    throw Exception('Yahh Gagal Ambil Data...');
  }
}

//Widget Ui
class PostList extends StatelessWidget {
  final Future<List<Post>> posts;

  PostList({required this.posts});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: posts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No posts found"));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data![index].name),
                    Text(snapshot.data![index].type),
                    Text(snapshot.data![index].description),
                  ],
                ),
              );
              // ListTile(
              //   title: Text(snapshot.data![index].name),
              //   subtitle: Text(snapshot.data![index].type),
              // );
            },
          );
        }
      },
    );
  }
}
