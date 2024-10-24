import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/bloc/post_bloc.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = PageController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<PostBloc>().add(GetAllPosts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostBloc, PostOneState>(
        builder: (context, state) {
          if (state.status == PostOneStatus.PostSuccess) {
            if (state.post1.isEmpty) {
              return const Center(
                child: Text("No Posts"),
              );
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.post1.length
                  : state.post1.length + 1,
              itemBuilder: (context, index) {
                return index >= state.post1.length
                    ? Container(
                      padding: const EdgeInsets.all(8),
                        child: const Center(child: CircularProgressIndicator(color: Colors.black)),
                      )
                    : Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          children: [
                            Card(
                              elevation: 3,
                              child: ListTile(
                                leading: Text(
                                  state.post1[index].id.toString(),
                                  style: const TextStyle(fontSize: 30),
                                ),
                                title: Text(
                                  state.post1[index].title,
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => Container(
                                    margin: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    child: Text(state.post1[index].body,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.yellow)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
              },
            );
          }
          if (state.status == PostOneStatus.PoastLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.grey),
            );
          }
          if (state.status == PostOneStatus.PostFailure) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.grey),
            );
          } else {
            return const Center(
              child: Text("Faild 2"),
            );
          }
        },
      ),
    );
  }
}
