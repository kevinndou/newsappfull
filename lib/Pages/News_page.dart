import 'package:flutter/material.dart';
import '../Services/News_api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> headlineNews = [];
  List<dynamic> healthNews = [];
  List<dynamic> sportsNews = [];
  List<dynamic> financialNews = [];
  List<dynamic> bitcoinNews = [];
  List<dynamic> teslaNews = [];
  bool isLoading = true;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void fetchNews() async {
    final headlines = await NewsService.fetchNews();
    final health = await NewsService.fetchHealthNews();
    final sports = await NewsService.fetchSportNews();
    final financial = await NewsService.fetchFinancialNews();
    final bitcoin = await NewsService.fetchBitcoinNews();
    final tesla = await NewsService.fetchTeslaNews();
    setState(() {
      headlineNews = headlines;
      healthNews = health;
      sportsNews = sports;
      financialNews = financial;
      bitcoinNews = bitcoin;
      teslaNews = tesla;
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'News',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else
            Expanded(
              child: DefaultTabController(
                length: 6, // Number of tabs/categories
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true,
                      tabs: [
                        Tab(text: 'Headlines'),
                        Tab(text: 'Health'),
                        Tab(text: 'Sports'),
                        Tab(text: 'Financial'),
                        Tab(text: 'Bitcoin'),
                        Tab(text: 'Tesla'),
                      ],
                      controller: _tabController,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          buildNewsList(headlineNews),
                          buildNewsList(healthNews),
                          buildNewsList(sportsNews),
                          buildNewsList(financialNews), // Financial News
                          buildNewsList(bitcoinNews), // Bitcoin News
                          buildNewsList(teslaNews), // Tesla News
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildNewsList(List<dynamic> articles) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: articles.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey,
      ),
      itemBuilder: (context, index) {
        final article = articles[index];
        final imageUrl = article['urlToImage'] ?? '';

        return ListTile(
          title: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                article['title'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                article['description'] ?? '',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
          onTap: () {
            // Handle article tap
           
          },
        );
      },
    );
  }
}
