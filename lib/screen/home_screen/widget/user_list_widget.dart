import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:untitled/screen/home_screen/models/user_model.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/size_constant.dart';
import 'package:untitled/utils/string_constants.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget(
      {super.key,
      required this.scrollController,
      required this.paginatedUsers,
      this.editRupeesCallBack});

  final ScrollController scrollController;
  final List<UserModel> paginatedUsers;
  final Function(UserModel user)? editRupeesCallBack;

  @override
  Widget build(BuildContext context) {
    void showZoomableImageDialog(BuildContext context, String imageUrl) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.all(PaddingConstant.widgetPadding),
          // Reduce padding for a full-screen effect
          child: Stack(
            children: [
              // Zoomable image using InteractiveViewer
              InteractiveViewer(
                maxScale: 4.0,
                minScale: 1.0,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error, color: Colors.white)),
                ),
              ),
              // Close button in the top-right corner
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return
      (paginatedUsers.isEmpty)?
       const Center(
          child: Text(
            StringConstant.noUsersFound,
            style: TextStyle(
              color: AppColor.whiteColor,
            ),
          )):

      Padding(
      padding: const EdgeInsets.all(12.0),
      child: AnimationLimiter(
        child: ListView.builder(
          controller: scrollController,
          itemCount: paginatedUsers.length,
          itemBuilder: (context, index) {
            final user = paginatedUsers[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Card(
                      color: AppColor.whiteColor.withOpacity(.1),
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            showZoomableImageDialog(context, user.imageUrl);
                          },
                          child: ClipOval(
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
                        ),
                        title: Text(user.name),
                        titleTextStyle: const TextStyle(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.bold),
                        subtitleTextStyle:
                            TextStyle(color: AppColor.whiteColor.withOpacity(.7)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Phone: ${user.phone}"),
                            Text("City: ${user.city}"),
                            Text(
                              "Rupee: ${user.rupee} (${user.rupee > 50 ? StringConstant.high : StringConstant.low})",
                              style: TextStyle(
                                color:
                                    user.rupee > 50 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: AppColor.whiteColor,
                          ),
                          onPressed: () => editRupeesCallBack?.call(user),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
