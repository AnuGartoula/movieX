// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/bloc/favourite_bloc.dart';
// import 'package:movie_app/bloc/login_bloc.dart';
// import 'package:movie_app/bloc/movies_bloc.dart';
// import 'package:movie_app/bloc/search_bloc.dart';
// import 'package:movie_app/bloc/toprated_bloc.dart';
// import 'package:movie_app/bloc/tv_bloc.dart';
// import 'package:movie_app/bloc/watchlist_bloc.dart';
// import 'package:movie_app/pages/splash_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp();
//   } catch (e) {
//     print(e);
//   }
//   runApp(const MyApp());
// }
// jiofewhf
// class MyApp extends StatelessWidget {
//   const MyApp(super.key);

// // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => WatchlistBloc(),
//         ),
//         BlocProvider(
//           create: (context) => MoviesBloc()..add(MovieInitialEvent()),
//         ),
//         BlocProvider(
//           create: (context) => FavouriteBloc(),
//         ),
//         BlocProvider(
//           create: (context) => TopratedBloc(),
//         ),
//         BlocProvider(
//           create: (context) => SearchBloc(),
//         ),
//         BlocProvider(
//           create: (context) => LoginBloc(),
//         ),
//         BlocProvider(
//           create: (context) => TvBloc(),
//         ),
//       ],
//       child: MaterialApp(
//         theme: ThemeData.dark().copyWith(
//             scaffoldBackgroundColor: const Color.fromARGB(109, 62, 61, 61),
//             appBarTheme: const AppBarTheme(
//               color: Color.fromARGB(109, 62, 61, 61),
//             )),
//         debugShowCheckedModeBanner: false,
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/favourite_bloc.dart';
import 'package:movie_app/bloc/login_bloc.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/bloc/search_bloc.dart';
import 'package:movie_app/bloc/toprated_bloc.dart';
import 'package:movie_app/bloc/tv_bloc.dart';
import 'package:movie_app/bloc/watchlist_bloc.dart';
import 'package:movie_app/pages/splash_screen.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WatchlistBloc()),
        BlocProvider(
            create: (context) => MoviesBloc()..add(MovieInitialEvent())),
        BlocProvider(create: (context) => FavouriteBloc()),
        BlocProvider(create: (context) => TopratedBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => TvBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(109, 62, 61, 61),
          appBarTheme: const AppBarTheme(
            color: Color.fromARGB(109, 62, 61, 61),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
