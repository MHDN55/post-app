// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

// ignore: constant_identifier_names
enum PostOneStatus { PoastLoading, PostFailure, PostSuccess , PoastLoadingScreen}

class PostOneState extends Equatable {
  final PostOneStatus status;
  final List<Posts> post1;
  final bool hasReachedMax;

  const PostOneState({
    this.status = PostOneStatus.PoastLoading,
    this.post1 = const [],
    this.hasReachedMax = false,
  });

  PostOneState copyWith({
    PostOneStatus? status,
    List<Posts>? post1,
    bool? hasReachedMax,
  }) {
    return PostOneState(
      status: status ?? this.status,
      post1: post1 ?? this.post1,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, post1,hasReachedMax];
}
