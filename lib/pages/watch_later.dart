import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/watchlist_bloc.dart';
import 'package:movie_app/models/constants.dart';
import 'package:movie_app/pages/watchlater_overview.dart';

final WatchlistBloc watchListBloc = WatchlistBloc();

class WatchLaterPage extends StatefulWidget {
  const WatchLaterPage({super.key});

  @override
  State<WatchLaterPage> createState() => _WatchLaterPageState();
}

class _WatchLaterPageState extends State<WatchLaterPage> {
  @override
  void initState() {
    // watchListBloc.add(WatchListInitialEvent());
    fetching();
    super.initState();
  }

  fetching() {
    context.read<WatchlistBloc>().add(WatchListInitialEvent());
  }

  @override
  void dispose() {
    watchListBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(
              "MOVIEX",
              style: TextStyle(color: Colors.red[300]),
            )),
        body: BlocConsumer<WatchlistBloc, WatchlistState>(
          listener: (context, state) {
            if (state is WatchlistLoading) {}
          },
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WatchlistSuccessState) {
              // print(state.watchlater.toString());
              // return ListView.builder(
              //   itemCount: state.watchlater.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Text(
              //         state.watchlater[index].title ?? 'No Title',
              //         style: const TextStyle(color: Colors.white),
              //       ),
              //       subtitle: Text(
              //           'Genre: ${state.watchlater[index].genreIds?.join(', ') ?? 'No Genre'}'),
              //     );
              //   },
              // );
              return SingleChildScrollView(
                child: Column(
                  children: state.watchlater.map((movie) {
                    final imageUrl =
                        Constants.apiImage + (movie.posterPath ?? '');
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => WatchlaterOverview(
                            index: state.watchlater.indexOf(movie),
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
            } else {
              return const Text('Error Fetching');
            }
            // return const Text('Error Fetching');
          },
        ));
  }
}
