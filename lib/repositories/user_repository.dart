import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class UserRepository {
  final Box<User> _box = Hive.box<User>('users');

  Future<List<User>> fetchUsers() async {
    try {
      // final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      //
      // if (response.statusCode == 200) {
      //   final List<dynamic> jsonList = json.decode(response.body);
      //   final users = jsonList.map((json) => User.fromJson(json)).toList();
      //
      //   // Cache to Hive
      //   await _box.clear();
      //   await _box.addAll(users);
      //
      //   return users;
      // } else {
      //   throw Exception('Network error');
      // }
      return [];
    } catch (_) {
      // Fallback to local cache
      return _box.values.toList();
    }
  }

  Future<User> fetchUserDetail(int id) async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return User.fromJson(jsonData);
      } else {
        throw Exception('Failed to fetch user detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
