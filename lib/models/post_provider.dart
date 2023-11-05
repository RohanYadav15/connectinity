import 'package:flutter/material.dart';
import 'opportunity.dart';

class PostProvider extends ChangeNotifier {
  List<Opportunity> posts = [];

  fetchPosts(String userId) async {
    posts = [];
    notifyListeners();
  }
}
