import 'package:flutter/material.dart';
import 'package:kfc/view/search/widgets/search_widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SearchWidgets(
        controller: _searchController,
      ),
    );
  }
}
