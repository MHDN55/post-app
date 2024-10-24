import 'package:flutter/material.dart';
import 'package:post_app/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/Home_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => PostBloc()..add(GetAllPosts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
