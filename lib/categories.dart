import 'package:flutter/material.dart';
import 'package:news_app/data/models/categoties.dart';
import 'package:news_app/latest_news.dart';
import 'package:news_app/services/remote_services.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<CategoryModel> _futureCategories;

  @override
  void initState() {
    super.initState();
    _futureCategories = CategoryService().fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: FutureBuilder<CategoryModel>(
        future: _futureCategories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${snapshot.error}',
                ),
                MaterialButton(
                  child: Text("Retry"),
                  onPressed: () {
                    _futureCategories = CategoryService().fetchCategory();
                    setState(() {});
                  },
                )
              ],
            ));
          } else if (snapshot.hasData) {
            final categories = snapshot.data!.categories;

            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsScreen(
                          category: categories[index],
                          fetchLatestNews: false,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No categories available'));
          }
        },
      ),
    );
  }
}
