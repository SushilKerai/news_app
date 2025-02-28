import 'package:flutter/material.dart';
import 'package:news_app/latest_news.dart';
import 'package:news_app/services/remote_services.dart';

class Region extends StatefulWidget {
  const Region({Key? key}) : super(key: key);

  @override
  _RegionState createState() => _RegionState();
}

class _RegionState extends State<Region> {
  late Future<List<MapEntry<String, dynamic>>> _futureRegions;

  @override
  void initState() {
    super.initState();
    _futureRegions = RegionService().fetchRegions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Regions'),
      ),
      body: FutureBuilder<List<MapEntry<String, dynamic>>>(
        future: _futureRegions,
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
                    _futureRegions = RegionService().fetchRegions();
                    setState(() {});
                  },
                )
              ],
            ));
          } else if (snapshot.hasData) {
            final regions = snapshot.data!;

            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 3, // Adjust the aspect ratio as needed
              ),
              itemCount: regions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsScreen(
                          fetchLatestNews: false,
                          region: regions[index].value,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      regions[index].key,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No regions available.'));
          }
        },
      ),
    );
  }
}
