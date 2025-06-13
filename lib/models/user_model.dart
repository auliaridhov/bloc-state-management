import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String website;

  @HiveField(5)
  final Map<String, dynamic>? address;

  @HiveField(6)
  final Map<String, dynamic>? company;

  User({required this.id, required this.name, required this.email, this.phone = '', this.website = '', this.address, this.company});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'] ?? '',
    website: json['website'],
    address: json['address'],
    company: json['company'],
  );
}
