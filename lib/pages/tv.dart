// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_app/bloc/tv_bloc.dart';
// import 'package:movie_app/models/constants.dart';

// class MyTelevision extends StatefulWidget {
//   const MyTelevision({super.key});

//   @override
//   State<MyTelevision> createState() => _MyTelevisionState();
// }

// class _MyTelevisionState extends State<MyTelevision> {
//   final TvBloc tvBloc = TvBloc();
//   @override
//   void initState() {
//     super.initState();
//     TvPageFetching();
//   }

//   void TvPageFetching() {
//     context.read<TvBloc>().add(TvInitialEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<TvBloc, TvState>(
//       listener: (context, state) {
//         // You can handle events like showing a toast on success or error here.
//       },
//       builder: (context, state) {
//         if (state is TvLoadingSate) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is TvSuccessState) {
//           return Scaffold(
//             appBar: AppBar(title: const Text("TV Shows")),
//             body: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const Text(
//                     "TV SHOWS",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: state.tvdata.length,
//                     itemBuilder: (context, index) {
//                       final tvShow = state.tvdata[index];
//                       return Card(
//                         margin: const EdgeInsets.symmetric(
//                             vertical: 10, horizontal: 15),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Image.network(
//                               '${Constants.apiImage}${tvShow.posterPath}',
//                               fit: BoxFit.cover,
//                               // errorBuilder: (context, error, stackTrace) =>
//                               //     const Icon(Icons.broken_image),
//                               // loadingBuilder: (context, child, progress) {
//                               //   if (progress == null) return child;
//                               //   return const Center(
//                               //       child: CircularProgressIndicator());
//                               // },
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 tvShow.title ?? "No Title",
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//         return const Center(child: Text("Failed to load TV shows."));
//       },
//     );
//   }
// }
