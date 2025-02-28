import 'package:flutter/material.dart';

import '../../components/custom_back_app_bar.dart';
import '../../theme/colors_theme.dart';
import '../../theme/config/AppStrings.dart';
import '../../theme/text_theme.dart';
import 'custom_categories_section.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _suggestions = [
    "iPhone 15 Pro",
    "Samsung Galaxy S24",
    "MacBook Air",
    "Sony Headphones",
  ];
  List<String> _filteredSuggestions = [];

  @override
  void initState() {
    super.initState();
    _filteredSuggestions = _suggestions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CustomBackAppBar(title: ''),
      ),
      body: Column(
        children: [
          _buildSearchField(),
          buildCategoriesSection(context: context),
          _filteredSuggestions.isEmpty
              ? _buildNoResultsFound()
              : Expanded(
                  child: ListView.builder(
                    itemCount: _suggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          _suggestions[index],
                          style: AppTextStyles.getSubtitleSize(),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchResultsScreen(
                                  query: _suggestions[index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _suggestions = _suggestions
                .where((product) =>
                    product.toLowerCase().contains(value.toLowerCase()))
                .toList();
          });
        },
        decoration: InputDecoration(
          hintText: AppStrings.homePage.search,
          hintStyle: AppTextStyles.getPlaceholderSize(),
          filled: true,
          fillColor: thirdColor,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/icon/icon_search.png',
              width: 16,
              height: 16,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildNoResultsFound() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icon/empty_order.png',
            width: 120,
          ),
          const SizedBox(height: 16),
          Text(
            textAlign: TextAlign.center,
            "Sorry, we couldn’t find any matching result for your Search.",
            style: AppTextStyles.getSubtitleSize(),
          ),
        ],
      ),
    );
  }
}

class SearchResultsScreen extends StatelessWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results for '$query'")),
      body: Center(
        child: Text("Showing results for '$query'"),
      ),
    );
  }
}
