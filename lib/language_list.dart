import 'package:flutter/material.dart';
import 'package:news_app/latest_news.dart';
import 'package:news_app/services/remote_services.dart';

class LanguageListScreen extends StatefulWidget {
  const LanguageListScreen({Key? key}) : super(key: key);

  @override
  _LanguageListScreenState createState() => _LanguageListScreenState();
}

class _LanguageListScreenState extends State<LanguageListScreen> {
  late Future<List<MapEntry<String, dynamic>>> _futureLanguages;

  @override
  void initState() {
    super.initState();
    _futureLanguages = LanguageService().fetchLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
      ),
      body: FutureBuilder<List<MapEntry<String, dynamic>>>(
        future: _futureLanguages,
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
                    _futureLanguages = LanguageService().fetchLanguages();
                    setState(() {});
                  },
                )
              ],
            ));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final List<MapEntry<String, dynamic>> languages = snapshot.data!;
            return ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    languages[index].key,
                    style: const TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsScreen(
                          fetchLatestNews: false,
                          language: languages[index].value,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            // Handle the case where no languages are available
            return const Center(child: Text('No languages available'));
          }
        },
      ),
    );
  }
}
