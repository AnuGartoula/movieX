import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/toprated_bloc.dart';
import 'package:movie_app/models/constants.dart';
import 'package:movie_app/pages/topratedoverview.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({super.key});

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
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
    return BlocConsumer<TopratedBloc, TopratedState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is TopRatedMovieLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TopRatedMovieSuccessState) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: state.data.map((movie) {
                final imageUrl = Constants.apiImage + (movie.posterPath ?? '');
                return GestureDetector(
                  onTap: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => Topratedoverview(
                    //     index: state.data.indexOf(movie),
                    //   ),
                    // );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Topratedoverview(
                            index: state.data.indexOf(movie),
                          ),
                        ));
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
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(58, 241, 64, 51)),
                          child: Row(
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
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }

        return Container();
      },
    );
  }
}
