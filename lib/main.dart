import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicplayer_fita/presentation/screen/player_screen.dart';
import 'package:musicplayer_fita/presentation/state/music/music_cubit.dart';
import 'package:musicplayer_fita/presentation/state/player/player_cubit.dart';
import 'package:musicplayer_fita/presentation/widget/player_action.dart';

import 'injection.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<PlayerCubit>()),
        BlocProvider(create: (_)=> di.locator<MusicCubit>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SafeArea(
          child: Scaffold(
            body: PlayerScreen(),
            bottomNavigationBar: PlayerAction(),
        )),
      ),
    );
  }
}
