import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_response.dart';
import 'package:news_app/services/remote_services.dart';

class NewsScreen extends StatefulWidget {
  final bool fetchLatestNews;
  final String? category;
  final String? region;
  final String? language;

  const NewsScreen({
    super.key,
    required this.fetchLatestNews,
    this.category,
    this.region,
    this.language,
  });

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsItem> _newsList = []; // Holds all fetched news items
  bool _isLoading = false; // Indicates if data is being loaded
  bool _hasMore = true; // Indicates if there are more items to load
  int _currentPage = 0;
  bool loadingMoreError = false; // Current page being fetched
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchNews();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchNews() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      _currentPage++;
      NewsResponse response;
      if (widget.fetchLatestNews) {
        response = await NewsService().fetchNews(Page: _currentPage);
      } else {
        response = await NewsSearch().fetchNews(
          category: widget.category,
          region: widget.region,
          page: _currentPage,
          language: widget.language,
        );
      }

      setState(() {
        if (response.news.isNotEmpty) {
          _newsList.addAll(response.news);
          _currentPage++;

          if (response.news.length < 10) {
            _hasMore = false;
          }
        } else {
          _hasMore = false;
        }
      });
    } catch (e) {
      loadingMoreError = true;
      print('Error fetching news: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _fetchNews();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
      ),
      body: _newsList.isEmpty && _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              controller: _scrollController,
              itemCount: _newsList.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _newsList.length) {
                  return _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : loadingMoreError
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      _fetchNews();
                                    },
                                    child: Text("Retry")),
                              ),
                            )
                          : SizedBox
                              .shrink(); // Show loader while fetching data
                }
                final newsItem = _newsList[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailScreen(newsItem: newsItem),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (newsItem.image != "None") ...[
                          Image.network(
                            newsItem.image!,
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ] else ...[
                          Image.asset(
                            "assets/logo_image.png",
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ],
                        Text(
                          newsItem.title,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          newsItem.description,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(child: Text("Author: ${newsItem.author}")),
                            Expanded(
                              child:
                                  Text("Published: ${newsItem.formatedDate}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _getTitle() {
    if (widget.category != null) {
      return 'News for ${widget.category}';
    } else if (widget.region != null) {
      return 'News for ${widget.region}';
    } else if (widget.language != null) {
      return 'News for ${widget.language}';
    } else {
      return 'Latest News';
    }
  }
}

class NewsDetailScreen extends StatelessWidget {
  final NewsItem newsItem;

  const NewsDetailScreen({super.key, required this.newsItem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsItem.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            newsItem.image != "None"
                ? Image.network(
                    newsItem.image!,
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/logo_image.png",
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
            SizedBox(height: 10),
            Text(
              newsItem.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            InkWell(
              child: Text(
                newsItem.description,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(height: 10),
            Text('Author: ${newsItem.author}', style: TextStyle(fontSize: 16)),
            Text('Published:  ${newsItem.formatedDate}',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
