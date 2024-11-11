import 'package:hive/hive.dart';
import 'package:untitled/screen/home_screen/models/user_model.dart';

class HiveService {
  static const String userBoxName = 'userBox';

  Box<UserModel> get userBox => Hive.box<UserModel>(userBoxName);
  final List<String> imageUrls = [
    'https://randomuser.me/api/portraits/men/1.jpg',
    'https://randomuser.me/api/portraits/women/2.jpg',
    'https://randomuser.me/api/portraits/men/3.jpg',
    'https://randomuser.me/api/portraits/women/4.jpg',
    'https://randomuser.me/api/portraits/men/5.jpg',
    'https://randomuser.me/api/portraits/women/6.jpg',
    'https://randomuser.me/api/portraits/men/7.jpg',
    'https://randomuser.me/api/portraits/women/8.jpg',
    'https://randomuser.me/api/portraits/men/9.jpg',
    'https://randomuser.me/api/portraits/women/10.jpg',
    'https://randomuser.me/api/portraits/men/11.jpg',
    'https://randomuser.me/api/portraits/women/12.jpg',
    'https://randomuser.me/api/portraits/men/13.jpg',
    'https://randomuser.me/api/portraits/women/14.jpg',
    'https://randomuser.me/api/portraits/men/15.jpg',
    'https://randomuser.me/api/portraits/women/16.jpg',
    'https://randomuser.me/api/portraits/men/17.jpg',
    'https://randomuser.me/api/portraits/women/18.jpg',
    'https://randomuser.me/api/portraits/men/19.jpg',
    'https://randomuser.me/api/portraits/women/20.jpg',
    'https://randomuser.me/api/portraits/men/21.jpg',
    'https://randomuser.me/api/portraits/women/22.jpg',
    'https://randomuser.me/api/portraits/men/23.jpg',
    'https://randomuser.me/api/portraits/women/24.jpg',
    'https://randomuser.me/api/portraits/men/25.jpg',
    'https://randomuser.me/api/portraits/women/26.jpg',
    'https://randomuser.me/api/portraits/men/27.jpg',
    'https://randomuser.me/api/portraits/women/28.jpg',
    'https://randomuser.me/api/portraits/men/29.jpg',
    'https://randomuser.me/api/portraits/women/30.jpg',
    'https://randomuser.me/api/portraits/men/31.jpg',
    'https://randomuser.me/api/portraits/women/32.jpg',
    'https://randomuser.me/api/portraits/men/33.jpg',
    'https://randomuser.me/api/portraits/women/34.jpg',
    'https://randomuser.me/api/portraits/men/35.jpg',
    'https://randomuser.me/api/portraits/women/36.jpg',
    'https://randomuser.me/api/portraits/men/37.jpg',
    'https://randomuser.me/api/portraits/women/38.jpg',
    'https://randomuser.me/api/portraits/men/39.jpg',
    'https://randomuser.me/api/portraits/women/40.jpg',
    'https://randomuser.me/api/portraits/men/41.jpg',
    'https://randomuser.me/api/portraits/women/42.jpg',
    'https://randomuser.me/api/portraits/men/43.jpg',
  ];

  Future<void> initHive() async {
    Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(userBoxName);
    if (userBox.isEmpty) {
      await _addDummyData();
    }
  }

  Future<void> _addDummyData() async {
    List<UserModel> dummyUsers = List.generate(43, (index) {
      final userNumber = index + 1;
      final rupee = userNumber % 101;

      return UserModel(
        name: 'User $userNumber',
        phone: '90330062${index.toString().padLeft(2, '0')}',
        city: index % 2 == 0 ? 'City A' : 'City B',
        imageUrl: imageUrls[index],
        rupee: rupee,
      );
    });

    await userBox.addAll(dummyUsers);
  }
}
