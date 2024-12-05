// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/bloc/movies_bloc.dart';
// import 'package:movie_app/models/constants.dart';
// import 'package:movie_app/models/movie_data_list.dart';
// import 'package:movie_app/pages/all_movies.dart';
// import 'package:movie_app/pages/favoutite_page.dart';
// import 'package:movie_app/pages/watch_later.dart';

// class MyHomePage extends StatefulWidget {
//   final Result result = Result();

//   MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
// //navigation bar

//   int _currentIndex = 0;

//   List<Widget> bodyIndex = [
//     MyHomePage(),
//     const FavouritePage(),
//     const WatchLaterPage(),
//   ];

//   final MoviesBloc moviesBloc = MoviesBloc();

//   @override
//   void initState() {
//     super.initState();
//     moviesBloc.add(MovieInitialEvent()); // Trigger the event here
//   }

//   @override
//   void dispose() {
//     moviesBloc.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => moviesBloc,
//       child: Scaffold(
//         appBar: AppBar(
//           // actions: [
//           //   Row(
//           //     children: [
//           //       IconButton(
//           //         onPressed: () {
//           //           Navigator.push(
//           //             context,
//           //             MaterialPageRoute(
//           //                 builder: (context) => const WatchLaterPage()),
//           //           );
//           //         },
//           //         icon: const Icon(Icons.watch_later_outlined),
//           //       ),
//           //       IconButton(
//           //         onPressed: () {
//           //           Navigator.push(
//           //             context,
//           //             MaterialPageRoute(
//           //                 builder: (context) => const FavouritePage()),
//           //           );
//           //         },
//           //         icon: const Icon(Icons.favorite),
//           //       ),
//           //     ],
//           //   )
//           // ],
//           centerTitle: true,
//           title: Text(
//             "MOVIEX",
//             style: TextStyle(color: Colors.red[300]),
//           ),
//         ),
//         body: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(left: 20),
//                 child: const Text(
//                   "Trending Movies",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 20),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               BlocConsumer<MoviesBloc, MoviesState>(
//                 listener: (context, state) {},
//                 builder: (context, state) {
//                   if (state is MovieLoadingState) {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else if (state is MovieFetchingSuccessState) {
//                     return SizedBox(
//                       height: 300,
//                       width: double.infinity,
//                       child: CarouselSlider.builder(
//                         itemCount: state.data.length,
//                         options: CarouselOptions(
//                             height: 300,
//                             viewportFraction: 0.55,
//                             autoPlay: true,
//                             scrollDirection: Axis.horizontal),
//                         itemBuilder: (context, index, realIndex) {
//                           final movie = state.data[index];
//                           final imageUrl =
//                               Constants.apiImage + (movie.posterPath ?? '');
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: SizedBox(
//                               width: 200,
//                               child: Image.network(
//                                 imageUrl,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }
//                   return const Text("failed Loading trending movies");
//                 },
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 margin: const EdgeInsets.only(left: 20),
//                 child: const Text(
//                   "All Movies",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 20),
//                 ),
//               ),
//               const AllMoviesPage(),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//             onTap: (newIndex) {
//               setState(() {
//                 _currentIndex =
//                     newIndex; //for the bottom to be selected accordingly
//               });
//             },
//             elevation: 0.0,
//             selectedItemColor: Colors.red[300],
//             currentIndex: _currentIndex,
//             items: const [
//               BottomNavigationBarItem(
//                 label: "Home",
//                 icon: Icon(Icons.home_rounded),
//               ),
//               BottomNavigationBarItem(
//                 label: "Favourites",
//                 icon: Icon(Icons.favorite_rounded),
//               ),
//               BottomNavigationBarItem(
//                 label: "Watch Later",
//                 icon: Icon(Icons.watch_later_rounded),
//               )
//             ]),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/models/constants.dart';
import 'package:movie_app/models/movie_data_list.dart';
import 'package:movie_app/pages/all_movies.dart';
import 'package:movie_app/pages/favoutite_page.dart';
import 'package:movie_app/pages/login/signup/signup.dart';
import 'package:movie_app/pages/searchpage.dart';
import 'package:movie_app/pages/top_rated.dart';
import 'package:movie_app/pages/tv.dart';
import 'package:movie_app/pages/watch_later.dart';

class MyHomePage extends StatefulWidget {
  final Result result = Result();

  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Navigation bar index
  int _currentIndex = 0;

  // List of pages to navigate
  final List<Widget> _pages = [
    const MyHomeContent(), // This is the home content that was originally in the build method
    const FavouritePage(),
    const WatchLaterPage(),
  ];

  final MoviesBloc moviesBloc = MoviesBloc();

  // final TopratedBloc topRatedBloc = TopratedBloc();

  @override
  void initState() {
    super.initState();
    moviesBloc.add(MovieInitialEvent());
    // Trigger the event here

    // topRatedBloc.add(TopRatedMovieIntialEvent());
  }

  @override
  void dispose() {
    moviesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => moviesBloc,
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text(
        //     "MOVIEX",
        //     style: TextStyle(color: Colors.red[300]),
        //   ),
        // ),
        body: _pages[
            _currentIndex], // Display the content based on the selected index
        bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex) {
            setState(() {
              _currentIndex = newIndex; // Update the current index
            });
          },
          elevation: 0.0,
          selectedItemColor: Colors.red[300],
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home_rounded),
            ),
            BottomNavigationBarItem(
              label: "Favourites",
              icon: Icon(Icons.favorite_rounded),
            ),
            BottomNavigationBarItem(
              label: "Watch Later",
              icon: Icon(Icons.watch_later_rounded),
            )
          ],
        ),
      ),
    );
  }
}

// Home content widget extracted from the original build method
class MyHomeContent extends StatefulWidget {
  const MyHomeContent({super.key});

  @override
  State<MyHomeContent> createState() => _MyHomeContentState();
}

class _MyHomeContentState extends State<MyHomeContent> {
  //for search Controller

  final bool _isSearchVisible = false;

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,

        title: Text(
          "MOVIEX",
          style: TextStyle(color: Colors.red[300]),
        ),
        // title: _isSearchVisible
        //     ? TextField(
        //         controller: _searchController,
        //         autofocus: true,
        //         decoration: const InputDecoration(
        //           hintText: 'Search...',
        //           border: InputBorder.none,
        //         ))
        //     : Text(
        // "MOVIEX",
        // style: TextStyle(color: Colors.red[300]),
        //       ),
        actions: [
          Row(
            children: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => const MyTelevision(),
              //           ));
              //     },
              //     icon: const Icon(Icons.tv)),
              IconButton(
                icon: Icon(_isSearchVisible ? Icons.close : Icons.search),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ));
                  // setState(() {
                  //   _isSearchVisible = !_isSearchVisible;
                  //   if (!_isSearchVisible) {
                  //     _searchController
                  //         .clear(); // Clear search input when closing
                  //   }
                  // });
                },
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MySignup(),
                        ));
                  },
                  icon: const Icon(Icons.person_2_rounded))
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, top: 30),
              child: const Text(
                "Trending Movies",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocConsumer<MoviesBloc, MoviesState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is MovieLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieFetchingSuccessState) {
                  return SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: CarouselSlider.builder(
                      itemCount: state.data.length,
                      options: CarouselOptions(
                          height: 300,
                          viewportFraction: 0.55,
                          autoPlay: true,
                          scrollDirection: Axis.horizontal),
                      itemBuilder: (context, index, realIndex) {
                        final movie = state.data[index];
                        final posterPath = movie.posterPath;
                        final imageUrl = (movie.posterPath != null &&
                                movie.posterPath!.isNotEmpty)
                            ? Constants.apiImage + movie.posterPath!
                            : 'https://via.placeholder.com/500';
                        // Constants.apiImage + (movie.posterPath ?? '');
                        // print('Poster path: ${movie.posterPath}');
                        // print('Image URL: $imageUrl');
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: 200,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons
                                    .error); // Fallback icon in case the image fails to load
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const Text("failed Loading trending movies");
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "All Movies",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
            const AllMoviesPage(),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: const Text(
                "Top Rated",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
            const TopRatedPage(),
          ],
        ),
      ),
    );
  }
}
