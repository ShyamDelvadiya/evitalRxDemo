import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled/screen/home_screen/bloc/home_bloc.dart';
import 'package:untitled/screen/home_screen/models/user_model.dart';
import 'package:untitled/utils/color_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  int _currentPage = 0;
  final int _pageSize = 20;
  HomeBloc? bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = context.read<HomeBloc>();
    bloc?.add(LoadUsersEvent());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Search by name, phone, or city',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (query) {
              bloc?.add(FilterUsersEvent(query));
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, currentState) {
              if (currentState is UserLoadingState) {
                return Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColor.redColor, size: 100));
              } else if (currentState is UserLoadedState ||
                  currentState is UserFilteredState) {
                final users = currentState is UserLoadedState
                    ? currentState.users
                    : (currentState as UserFilteredState).filteredUsers;
                final paginatedUsers =
                    users.take((_currentPage + 1) * _pageSize).toList();
                if (users.isEmpty) {
                  return const Center(child: Text("No users found."));
                }
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: paginatedUsers.length,
                  itemBuilder: (context, index) {
                    final user = paginatedUsers[index];
                    return Card(
                      child: ListTile(
                        leading: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: user.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        title: Text(user.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Phone: ${user.phone}"),
                            Text("City: ${user.city}"),
                            Text(
                              "Rupee: ${user.rupee} (${user.rupee > 50 ? 'High' : 'Low'})",
                              style: TextStyle(
                                color:
                                    user.rupee > 50 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _showEditDialog(context, user),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text("No users found."));
              }
            },
          ),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context, UserModel user) {
    final TextEditingController rupeeController =
        TextEditingController(text: user.rupee.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Rupee"),
        content: TextField(
          controller: rupeeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Enter new Rupee value"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              final newRupee = int.tryParse(rupeeController.text) ?? user.rupee;
              bloc?.add(UpdateRupeeEvent(user, newRupee));
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
