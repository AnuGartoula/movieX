// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/bloc/movies_bloc.dart';
// import 'package:movie_app/models/constants.dart';
// import 'package:movie_app/pages/overview.dart';

// class AllMoviesPage extends StatelessWidget {
//   const AllMoviesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<MoviesBloc, MoviesState>(
//       listener: (context, state) {
//         // Handle listener
//       },
//       builder: (context, state) {
//         if (state is MovieLoadingState) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is MovieFetchingSuccessState) {
//           return ListView.builder(
//             scrollDirection: Axis.horizontal,
//             shrinkWrap: true,
//             itemCount: state.data.length,
//             itemBuilder: (context, index) {
//               final movie = state.data[index];
//               final imageUrl = Constants.apiImage + (movie.posterPath ?? '');
//               return GestureDetector(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => Overview(
//                       index: index,
//                     ),
//                   );
//                 },
//                 child: ListTile(
//                   title: SizedBox(
//                     height: 100,
//                     width: 100,
//                     child: Image.network(
//                       imageUrl,
//                       fit: BoxFit.contain,
//                     ),
//                   ),

//                   // Text(
//                   //   state.data[index].title ?? 'No Title',
//                   //   style: const TextStyle(color: Colors.white),
//                   // ),
//                   // subtitle: Text(
//                   //   'Genre: ${state.data[index].genreIds?.join(', ') ?? 'No Genre'}',
//                   // ),
//                   subtitle: Text(
//                     state.data[index].title ?? 'No Title',
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   // trailing: Row(
//                   //   mainAxisSize: MainAxisSize.min,
//                   //   children: [
//                   //     IconButton(
//                   //       onPressed: () {
//                   //         BlocProvider.of<WatchlistBloc>(context).add(
//                   //             AddToWatchlist(
//                   //                 clickedMovieId: state.data[index].id ?? 0));
//                   //         ScaffoldMessenger.of(context)
//                   //             .showSnackBar(const SnackBar(
//                   //           content: Text(
//                   //             "Added to the WatchList",
//                   //             style: TextStyle(color: Colors.white),
//                   //           ),
//                   //           duration: Duration(seconds: 3),
//                   //           backgroundColor: Color.fromARGB(255, 66, 64, 160),
//                   //         ));
//                   //       },
//                   //       icon: const Icon(Icons.watch_later_outlined),
//                   //     ),
//                   //     IconButton(
//                   //       onPressed: () {
//                   //         BlocProvider.of<FavouriteBloc>(context).add(
//                   //             AddFavouriteEvent(
//                   //                 favouritemovieID: state.data[index].id ?? 0));
//                   //         ScaffoldMessenger.of(context).showSnackBar(
//                   //           const SnackBar(
//                   //             content: Text(
//                   //               "Added to the Favourites",
//                   //               style: TextStyle(color: Colors.white),
//                   //             ),
//                   //             duration: Duration(seconds: 3),
//                   //             backgroundColor:
//                   //                 Color.fromARGB(255, 163, 75, 117),
//                   //           ),
//                   //         );
//                   //       },
//                   //       icon: const Icon(Icons.favorite_border_outlined),
//                   //     ),
//                   //   ],
//                   // ),
//                 ),
//               );
//             },
//           );
//         }
//         return const Center(
//           child: Text(
//             "Failed loading movies...",
//             style: TextStyle(fontSize: 40),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/movies_bloc.dart';
import 'package:movie_app/models/constants.dart';
import 'package:movie_app/pages/overview.dart';

class AllMoviesPage extends StatelessWidget {
  const AllMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesBloc, MoviesState>(
      listener: (context, state) {
        // Handle listener
      },
      builder: (context, state) {
        if (state is MovieLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieFetchingSuccessState) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: state.data.map((movie) {
                final imageUrl = Constants.apiImage + (movie.posterPath ?? '');
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Overview(
                        index: state.data.indexOf(movie),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 150,
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          movie.title ?? 'No Title',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()
            ),
          );
        }
        return const Center(
          child: Text(
            "Failed loading movies...",
            style: TextStyle(fontSize: 40),
          ),
        );
      },
    );
  }
}
