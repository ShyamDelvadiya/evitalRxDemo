import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String city;

  @HiveField(3)
  String imageUrl;

  @HiveField(4)
  int rupee;

  UserModel({
    required this.name,
    required this.phone,
    required this.city,
    required this.imageUrl,
    required this.rupee,
  });
}
