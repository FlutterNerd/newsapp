import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp_final/helper/data.dart';
import 'package:newsapp_final/helper/news.dart';
import 'package:newsapp_final/models/article.dart';
import 'package:newsapp_final/models/category.dart';
import 'package:newsapp_final/views/article_view.dart';
import 'package:newsapp_final/views/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = List<Category>();
  List<Article> articles = List<Article>();

  News news = News();

  getAndSetNews() async {
    await news.getNewsHeadlines("in");
    articles = news.articles;
    setState(() {});
  }

  @override
  void initState() {
    categories = getCategoryData();
    getAndSetNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsApp"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                        categories[index].imgUrl, categories[index].label);
                  },
                ),
              ),
              ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsTile(
                        title: articles[index].title,
                        description: articles[index].description,
                        imageUrl: articles[index].urlToImage,
                        url: articles[index].url);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl, label;
  CategoryTile(this.imgUrl, this.label);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CategoryScreen(label)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black26,
              ),
              height: 60,
              width: 120,
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl, title, description, url;
  NewsTile({this.imageUrl, this.title, this.description, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ArticleView(url)));
        print(url);
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 6),
              Text(description)
            ],
          )),
    );
  }
}
