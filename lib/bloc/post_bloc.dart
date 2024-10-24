import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:post_app/models/postsModel.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostOneState> {
  int startIndex = 0;
  int limit = 20;
  PostBloc() : super(const PostOneState()) {
    on<GetAllPosts>((event, emit) async {
      if (state.hasReachedMax) return;
      // emit(state.copyWith(status: PostOneStatus.PoastLoading));
      try {
        if (state.status == PostOneStatus.PoastLoading) {
          var response = await get(
            Uri.parse(
              "https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit",
            ),
          );
          List<Posts> responsebody = json
              .decode(response.body)
              .map<Posts>((jsonPost) => Posts.fromJson(jsonPost))
              .toList();
          return responsebody.isEmpty
              ? emit(state.copyWith(
                  status: PostOneStatus.PostSuccess, hasReachedMax: true))
              : emit(state.copyWith(
                  status: PostOneStatus.PostSuccess,
                  post1: responsebody,
                  hasReachedMax: false));
        } else {
          var response = await get(
            Uri.parse(
              "https://jsonplaceholder.typicode.com/posts?_start=${state.post1.length}&_limit=$limit",
            ),
          );
          List<Posts> responsebody = json
              .decode(response.body)
              .map<Posts>((jsonPost) => Posts.fromJson(jsonPost))
              .toList();
          responsebody.isEmpty
              ? emit(state.copyWith(hasReachedMax: true))
              : emit(state.copyWith(
                  status: PostOneStatus.PostSuccess,
                  post1: List.of(state.post1)..addAll(responsebody),
                  hasReachedMax: false));
        }
        // var response = await get(
        //   Uri.parse(
        //     "https://jsonplaceholder.typicode.com/posts",
        //   ),
        // );
        // List<Posts> responsebody = json
        //     .decode(response.body)
        //     .map<Posts>((jsonPost) => Posts.fromJson(jsonPost))
        //     .toList();
        // for(Map<String, dynamic> post in responsebody){
        //   postList.add(Posts.fromJson(post));
        // }
        // final List<Posts> post = Posts.fromJson(responsebody);

        // emit(state.copyWith(
        //     status: PostOneStatus.PostSuccess, post1: responsebody));
        // debugPrint(state.post1.length.toString());
      } catch (e) {
        emit(state.copyWith(status: PostOneStatus.PostFailure));
        // ignore: avoid_print
        print(e);
      }
    }, transformer: droppable());
  }
}
