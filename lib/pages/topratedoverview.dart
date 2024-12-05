import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movie_app/bloc/toprated_bloc.dart';
import 'package:movie_app/models/genreid.dart';

class Topratedoverview extends StatefulWidget {
  final int index;

  const Topratedoverview({super.key, required this.index});

  @override
  State<Topratedoverview> createState() => _TopratedoverviewState();
}

class _TopratedoverviewState extends State<Topratedoverview> {
  final TopratedBloc topRatedBloc = TopratedBloc();
  @override
  void initState() {
    context.read<TopratedBloc>().add(TopRatedMovieIntialEvent());
    super.initState();
  }

  @override
  void dispose() {
    topRatedBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<TopratedBloc, TopratedState>(
        listener: (context, state) {
          // Handle any side effects here
        },
        builder: (context, state) {
          if (state is TopRatedMovieLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedMovieSuccessState) {
            if (widget.index < 0 || widget.index >= state.data.length) {
              return const Center(child: Text("Invalid movie index"));
            }

            final movie = state.data[widget.index];
            final imageUrl = movie.posterPath != null
                ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                : '';
            final genreNames = movie.genreIds
                ?.map((id) => genreMap[id] ?? 'Unknown')
                .toList()
                .join(', ');

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                // backgroundColor: const Color.fromARGB(255, 72, 72, 72),
                color: const Color.fromARGB(255, 72, 72, 72),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (imageUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          height: 400,
                          width: double.infinity,
                        ),
                      )
                    else
                      const Text('No image available'),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        movie.title ?? 'No title',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        genreNames ?? 'No genre',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white54),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        movie.overview ?? 'No overview',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          // margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                              onPressed: () {
                                // BlocProvider.of<WatchlistBloc>(context).add(
                                //     AddToWatchlist(
                                //         clickedMovieId:
                                //             state.data[index].id ?? 0));

                                Fluttertoast.showToast(
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.blueGrey[900],
                                    msg: "Added to Watch Later");
                              },
                              child: const Text(
                                "Watch Later",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          // padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.red[800],
                              borderRadius: BorderRadius.circular(20)),
                          child: TextButton(
                              onPressed: () {
                                // BlocProvider.of<FavouriteBloc>(context).add(
                                //     AddFavouriteEvent(
                                //         favouritemovieID:
                                //             state.data[index].id ?? 0));
                                Fluttertoast.showToast(
                                    gravity: ToastGravity.CENTER,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.red[900],
                                    msg: "Added to Favourites");
                              },
                              child: const Text(
                                "Favourites",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("No details found"));
          }
        },
      ),
    );
  }
}
