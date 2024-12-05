// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/bloc/search_bloc.dart';
// import 'package:movie_app/models/constants.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({super.key});

//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   void UpdateList(String value) {
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   void pageFetching(String query) {
//     context.read<SearchBloc>().add(SearchQueryChange(query));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         toolbarHeight: 80.0,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(
//                   context); //goes back to the homepage without creating back button on homepage
//             },
//             icon: const Icon(Icons.arrow_back_ios_new_rounded)),
//         title: Container(
//           margin: const EdgeInsets.only(top: 20, bottom: 20),
//           child: TextField(
//             onSubmitted: (value) {
//               pageFetching(value);
//             },
//             decoration: const InputDecoration(
//                 hintText: "Enter a Movie",
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)))),
//           ),
//         ),
//       ),
//       body: BlocConsumer<SearchBloc, SearchState>(
//         listener: (context, state) {
//           // TODO: implement listener
//         },
//         builder: (context, state) {
//           return Container(
//             margin: const EdgeInsets.only(top: 30, left: 20),
//             child: ListView.builder(
//               itemCount: state is SearchSuccessState ? state.data.length : 0,
//               itemBuilder: (context, index) {
//                 if (state is SearchLoadingState) {
//                   return const Center();
//                 } else if (state is SearchSuccessState) {
//                   // final movie = state.data[index];
//                   // final imageUrl = movie.posterPath != null
//                   //     ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
//                   //     : '';

//                   // return ListTile(
//                   //   // title: Image.network(
//                   //   //   imageUrl,
//                   //   //   fit: BoxFit.contain,
//                   //   // ),

//                   //   subtitle: Text(state.data[index].title ?? 'No Title'),
//                   //   title: Text(state.data[index].id.toString()),

//                   //   // title: Text(state.data[index].title ?? 'No Title'),
//                   // );

//                   if (state.data.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         "No Result Found",
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.grey),
//                       ),
//                     );
//                   } else {
//                     return Column(
//                       children: state.data.map((movie) {
//                         final imageUrl = Constants.apiImage +
//                             (movie.posterPath ?? 'No poster');
//                         return GestureDetector(
//                           // onTap: () {
//                           //   showDialog(
//                           //     context: context,
//                           //     builder: (context) => Overview(
//                           //       index: state.data.indexOf(movie),
//                           //     ),
//                           //   );
//                           // },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   height: 80,
//                                   width: 80,
//                                   child: Image.network(
//                                     imageUrl,
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10), // Add some spacing
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         movie.title ?? 'NO TITLE',
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 1,
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 20,
//                                         ),
//                                       ),

//                                       // ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(state.data[index].genreIds
//                                           .toString())

//                                       // Container(
//                                       //   padding: const EdgeInsets.all(6),
//                                       //   decoration: const BoxDecoration(
//                                       //       color: Color.fromARGB(58, 241, 64, 51)),
//                                       // Row(
//                                       //   children: [
//                                       //     Icon(
//                                       //       Icons.star,
//                                       //       color: Colors.yellow[500],
//                                       //     ),
//                                       //     const SizedBox(
//                                       //       width: 10,
//                                       //     ),
//                                       //     Text(movie.voteCount.toString())
//                                       //   ],
//                                       // ),
//                                       // ),
//                                       // const SizedBox(
//                                       //   height: 5,
//                                       // ),
//                                       // Text(
//                                       //   movie.overview ?? 'No details available',
//                                       //   overflow: TextOverflow.ellipsis,
//                                       //   maxLines: 4,
//                                       //   style: const TextStyle(
//                                       //       fontWeight: FontWeight.w500,
//                                       //       fontSize: 12,
//                                       //       color:
//                                       //           Color.fromARGB(129, 255, 255, 255)),
//                                       // )
//                                       // Additional text or widgets can go here
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }).toList(),
//                     );
//                   }
//                 }
//                 return null;
//               },
//             ),
//           );
//         },
//       ),
//     );

//     // return Container(
//     //   margin: const EdgeInsets.only(top: 40),
//     //   child: Row(
//     //     crossAxisAlignment: CrossAxisAlignment.start,
//     //     mainAxisAlignment: MainAxisAlignment.start,
//     //     children: [
//     //       IconButton(
//     //           onPressed: () {},
//     //           icon: const Icon(Icons.arrow_back_ios_new_rounded)),
//     //       const Text(
//     //         "helloooo",
//     //         style: TextStyle(color: Colors.white),
//     //       ),
//     //       TextField(
//     //         decoration: InputDecoration(
//     //           border: OutlineInputBorder(
//     //             borderRadius: BorderRadius.circular(6),
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/bloc/search_bloc.dart';
import 'package:movie_app/models/constants.dart';
import 'package:movie_app/models/genreid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void updateList(String value) {
    setState(() {});
  }

  void pageFetching(String query) {
    context.read<SearchBloc>().add(SearchQueryChange(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        toolbarHeight: 80.0,
        leading: IconButton(
          onPressed: () {

            // clear the screen when it goes back to the homepage 
             context.read<SearchBloc>().add(SearchClear()); 
            Navigator.pop(context); // Go back to the homepage
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: TextField(
            onSubmitted: (value) {
              pageFetching(value);
            },
            decoration: const InputDecoration(
              hintText: "Enter a Movie",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          // Handle any side effects, if necessary
        },
        builder: (context, state) {
          if (state is SearchLoadingState) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          } else if (state is SearchSuccessState) {
            if (state.data.isEmpty) {
              return const Center(
                child: Text(
                  "No Result Found",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final movie = state.data[index];
                  final imageUrl =
                      Constants.apiImage + (movie.posterPath ?? '');
                  final genreNames = movie.genreIds
                      ?.map((id) => genreMap[id] ?? 'Unknown')
                      .toList()
                      .join(', ');

                  return GestureDetector(
                    onTap: () {
                      // Handle tap if needed, e.g., navigate to details page
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              //to handle cases where the image fails to load.
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 10), // Add spacing
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title ?? 'No Title',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  genreNames ?? 'No genre ',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                // Additional details or widgets can go here
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is SearchErrorState) {
            return const Center(child: Text('Error fetching results'));
          }
          return const Center(child: Text('Start searching for movies!'));
        },
      ),
    );
  }
}
