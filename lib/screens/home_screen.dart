import 'package:connectnity/models/opportunity.dart';
import 'package:connectnity/models/post_provider.dart';
import 'package:connectnity/models/user.dart';
import 'package:connectnity/models/user_provider.dart';
import 'package:connectnity/widgets/additional_info.dart';
import 'package:connectnity/widgets/opportunity_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOrg = false;
  late CurrentUser? user;
  bool showSecondRegistration = true;

  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      if (this.isOrg == false && user!.major == null) {
        showSecondRegistration = true;
      } else {
        showSecondRegistration = false;
      }
      Provider.of<PostProvider>(context, listen: false).fetchPosts(user!.id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => ZoomDrawer.of(context)!.toggle(),
        ),
        actions: [
          //add post after navigation
          isOrg
              ? IconButton(onPressed: () {}, icon: const Icon(Icons.add))
              : Container(),
        ],
      ),
      body: Center(
        child: showSecondRegistration
            ? AdditionalInfoForm(userId: user?.id ?? "")
            : Consumer<PostProvider>(builder: (context, value, child) {
                if (value.posts.isEmpty) {
                  return const Center(
                      child: Text("Organization hasn't posted anything"));
                } else {
                  return ListView.builder(
                    itemBuilder: (context, i) {
                      return OpportunityPost(opportunity: value.posts[i]);
                    },
                    itemCount: value.posts.length,
                  );
                }
              }),
      ),
    );
  }
}
