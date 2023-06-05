import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Api Detail/api_Configration_file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Search'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
          child: Text('Open Search'),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6eyJpZCI6IkFnZW50XzE2ODQ4NDk3OTA1MzZfbGkwYzJhbWciLCJyaWdodHMiOjB9LCJpYXQiOjE2ODU1MjM5OTYsImV4cCI6MTY4ODExNTk5Nn0.BEpkThJLX7M6SuYEGcGZeJnPGKmEtpMO99DkB9lgl4Y';
  final String apiUrl =
      'http://$api_id/mobileApprouter/getBookList'; // Replace with your API endpoint

  List<String> searchResults = [];
  bool isLoading = false;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        var result = searchResults[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        var result = searchResults[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  void showResults(BuildContext context) {
    searchFruits(query);
    super.showResults(context);
  }

  @override
  void showSuggestions(BuildContext context) {
    searchFruits(query);
    super.showSuggestions(context);
  }

  Future<void> searchFruits(String query) async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(
      Uri.parse('http://$api_id/mobileApprouter/getBookList'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['vehicleRegistrationNumber'];
      print(data);
      List<String> fruits = List<String>.from(data);

      searchResults = fruits
          .where((fruit) => fruit.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      searchResults = [];
    }

    setState(() {
      isLoading = false;
    });
  }

  void setState(VoidCallback callback) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      callback();
    });
  }
}
