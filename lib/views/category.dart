import 'package:flutter/material.dart';
import 'package:newsapp_final/helper/news.dart';
import 'package:newsapp_final/models/article.dart';
import 'package:newsapp_final/views/home.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  CategoryScreen(this.category);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Article> articles = List<Article>();

  News news = News();

  getAndSetNews() async {
    await news.getNewsByCategory("in", widget.category.toLowerCase());
    articles = news.articles;
    setState(() {});
  }

  @override
  void initState() {
    getAndSetNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category} News"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: articles.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return NewsTile(
                  title: articles[index].title,
                  description: articles[index].description,
                  imageUrl: articles[index].urlToImage,
                  url: articles[index].url);
            }),
      ),
    );
  }
}
