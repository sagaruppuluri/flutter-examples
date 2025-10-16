import 'package:flutter/material.dart';
import 'package:userapp/routes/app_routes.dart';
import '../services/api_service.dart';
import '../models/post.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Post> posts = [];
  bool loading = true;

  void fetchPosts() async {
    try {
      List<Post> fetched = await ApiService().fetchPosts();
      setState(() {
        posts = fetched;
        loading = false;
      });
    } catch (e) {
      // Unauthorized redirect handled in ApiService._handleUnauthorized()
      setState(() => loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  void deletePost(int postId) async {
    await ApiService().deletePost(postId);
    fetchPosts();
  }

  void logout() async {
    ApiService().logout();
    if (mounted) {
      // Navigator.pushReplacementNamed(context, AppRoutes.login);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Posts'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () => fetchPosts()),
          IconButton(icon: Icon(Icons.logout), onPressed: logout),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Dismissible(
                  key: Key(post.postId.toString()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    deletePost(post.postId);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Post deleted")));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.description),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.editPost,
                          arguments: post,
                        ).then((_) => fetchPosts());
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.createPost,
          ).then((_) => fetchPosts());
        },
      ),
    );
  }
}
