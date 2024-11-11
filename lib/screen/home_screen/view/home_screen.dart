import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled/common_widgets/common_bottom_background.dart';
import 'package:untitled/common_widgets/common_home_background.dart';
import 'package:untitled/common_widgets/common_textfield.dart';
import 'package:untitled/screen/home_screen/bloc/home_bloc.dart';
import 'package:untitled/screen/home_screen/models/user_model.dart';
import 'package:untitled/screen/home_screen/widget/build_search_bar.dart';
import 'package:untitled/screen/home_screen/widget/user_list_widget.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/string_constants.dart';

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
  List<UserModel> paginatedUsers = [];
  bool isLoading = false;

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
    return _mainView(context);
  }

  Widget _mainView(BuildContext context) {
    return Scaffold(
      body: _body(context),
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.blackColor,
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        const CommonHomeBackground(),
        const CommonBottomBackground(),
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, currentState) {
                    if (currentState is UserLoadingState) {
                      isLoading = true;
                    } else if (currentState is UserLoadedState ||
                        currentState is UserFilteredState) {
                      isLoading = false;
                      final users = currentState is UserLoadedState
                          ? currentState.users
                          : (currentState as UserFilteredState).filteredUsers;
                      paginatedUsers =
                          users.take((_currentPage + 1) * _pageSize).toList();
                    }
                    return Column(
                      children: [
                        BuildSearchBar(
                          searchController: searchController,
                          filterUsersListCallBack: (query) {
                            bloc?.add(FilterUsersEvent(query));
                          },
                        ),
                        isLoading
                            ? Expanded(
                                child: Center(
                                    child: LoadingAnimationWidget.hexagonDots(
                                        color: AppColor.whiteColor, size: 50)),
                              )
                            : Expanded(
                                child: UserListWidget(
                                  scrollController: _scrollController,
                                  paginatedUsers: paginatedUsers,
                                  editRupeesCallBack: (user) {
                                    _showEditDialog(context, user);
                                  },
                                ),
                              ),
                      ],
                    );
                  },
                ),
              ),
            ],
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
        title: const Text(StringConstant.editRupee),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
          // height: 200, // Set a fixed
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                controller: rupeeController,
                hintText: StringConstant.enterNewRupeeTitle,
                textInputType: TextInputType.number,
                outlineInputBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 1,),
                  borderRadius: BorderRadius.circular(10),
                ),
                isRupee: true,
                textStyle: const TextStyle(color: AppColor.blackColor),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(StringConstant.cancel),
          ),
          TextButton(
            onPressed: () {
              final newRupee =
                  int.tryParse(rupeeController.text) ?? user.rupee.toInt();

              // Validate the rupee value (1 to 100)
              if (newRupee < 1 || newRupee > 100) {
              } else {
                bloc?.add(UpdateRupeeEvent(user, newRupee));
                Navigator.pop(context);
              }
            },
            child: const Text(StringConstant.save),
          ),
        ],
      ),
    );
  }
}
