import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/favourite_bloc.dart';
import 'package:movie_app/models/constants.dart';
import 'package:movie_app/pages/favourite_overview.dart';

final FavouriteBloc favouritebloc = FavouriteBloc();

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    FavouritePageFetching();
  }

  void FavouritePageFetching() {
    context.read<FavouriteBloc>().add(FavouriteMoviesInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "MOVIEX",
          style: TextStyle(color: Colors.red[300]),
        ),
      ),
      body: BlocConsumer<FavouriteBloc, FavouriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FavouritePageLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouriteSuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: state.favouritedata.map((movie) {
                  final imageUrl =
                      Constants.apiImage + (movie.posterPath ?? '');
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => FavouriteOverview(
                          index: state.favouritedata.indexOf(movie),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 10), // Add some spacing
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title ?? 'NO TITLE',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),

                                // ),
                                const SizedBox(
                                  height: 5,
                                ),

                                // Container(
                                //   padding: const EdgeInsets.all(6),
                                //   decoration: const BoxDecoration(
                                //       color: Color.fromARGB(58, 241, 64, 51)),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow[500],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(movie.voteCount.toString())
                                  ],
                                ),
                                // ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  movie.overview ?? 'No details available',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color:
                                          Color.fromARGB(129, 255, 255, 255)),
                                )
                                // Additional text or widgets can go here
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
          return const Text("Failed to load FavouritePage");
        },
      ),
    );
  }
}
