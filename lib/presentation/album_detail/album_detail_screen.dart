import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/photo/photo_bloc.dart';
import '../blocs/photo/photo_event.dart';
import '../blocs/photo/photo_state.dart';
import '../../core/error/error_widget.dart';

class AlbumDetailScreen extends StatefulWidget {
  final int albumId;
  final String albumTitle;

  const AlbumDetailScreen({
    super.key,
    required this.albumId,
    required this.albumTitle,
  });

  // Use this when constructing from GoRouter's `extra`
  static AlbumDetailScreen fromExtra(BuildContext context, Object? extra) {
    final map = extra as Map<String, dynamic>;
    return AlbumDetailScreen(
      albumId: map['albumId'] as int,
      albumTitle: map['albumTitle'] as String,
    );
  }

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PhotoBloc>().add(LoadPhotosByAlbumId(widget.albumId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Album: ${widget.albumTitle}')),
      body: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          if (state is PhotoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PhotoError) {
            return ErrorDisplay(
              message: state.message,
              onRetry: () => context
                  .read<PhotoBloc>()
                  .add(LoadPhotosByAlbumId(widget.albumId)),
            );
          } else if (state is PhotoLoaded) {
            final photos = state.photos;

            if (photos.isEmpty) {
              return const Center(child: Text('No photos found.'));
            }

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final photo = photos[index];
                return GridTile(
                  footer: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      photo.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  child: Image.network(photo.thumbnailUrl, fit: BoxFit.cover),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../blocs/photo/photo_bloc.dart';
// import '../blocs/photo/photo_event.dart';
// import '../blocs/photo/photo_state.dart';
// import '../../core/error/error_widget.dart'; // Custom error widget
//
// class AlbumDetailScreen extends StatefulWidget {
//   final int albumId;
//   final String albumTitle;
//
//   const AlbumDetailScreen({
//     super.key,
//     required this.albumId,
//     required this.albumTitle,
//   });
//
//   @override
//   State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
// }
//
// class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<PhotoBloc>().add(LoadPhotosByAlbumId(widget.albumId));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Album: ${widget.albumTitle}')),
//       body: BlocBuilder<PhotoBloc, PhotoState>(
//         builder: (context, state) {
//           if (state is PhotoLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is PhotoError) {
//             return ErrorDisplay(
//               message: state.message,
//               onRetry: () {
//                 context.read<PhotoBloc>().add(LoadPhotosByAlbumId(widget.albumId));
//               },
//             );
//           } else if (state is PhotoLoaded) {
//             final photos = state.photos;
//
//             if (photos.isEmpty) {
//               return const Center(child: Text('No photos found.'));
//             }
//
//             return GridView.builder(
//               padding: const EdgeInsets.all(10),
//               itemCount: photos.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemBuilder: (context, index) {
//                 final photo = photos[index];
//                 return GridTile(
//                   footer: Container(
//                     color: Colors.black54,
//                     padding: const EdgeInsets.all(4),
//                     child: Text(
//                       photo.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ),
//                   child: Image.network(photo.thumbnailUrl, fit: BoxFit.cover),
//                 );
//               },
//             );
//           }
//
//           return const SizedBox(); // Default case
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../blocs/photo/photo_bloc.dart';
// import '../blocs/photo/photo_event.dart';
// import '../blocs/photo/photo_state.dart';
// import '../../core/error/error_widget.dart';
//
// class AlbumDetailScreen extends StatefulWidget {
//   final int albumId;
//   final String albumTitle;
//
//   const AlbumDetailScreen({
//     super.key,
//     required this.albumId,
//     required this.albumTitle,
//   });
//
//   @override
//   State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
// }
//
// class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Dispatch the event only once
//     context.read<PhotoBloc>().add(LoadPhotosByAlbumId(widget.albumId));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Album: ${widget.albumTitle}')),
//       body: BlocBuilder<PhotoBloc, PhotoState>(
//         builder: (context, state) {
//           if (state is PhotoLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is PhotoError) {
//     return ErrorDisplayWidget(
//     message: state.message,
//     onRetry: () {
//     context.read<PhotoBloc>().add(LoadPhotosByAlbumId(
//     widget.albumId));
//     }
//     );
//     }
//                 ))
//               }
//             );
//           } else if (state is PhotoLoaded) {
//             final photos = state.photos;
//
//             if (photos.isEmpty) {
//               return const Center(child: Text('No photos found.'));
//             }
//
//             return GridView.builder(
//               padding: const EdgeInsets.all(10),
//               itemCount: photos.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemBuilder: (context, index) {
//                 final photo = photos[index];
//                 return GridTile(
//                   footer: Container(
//                     color: Colors.black54,
//                     padding: const EdgeInsets.all(4),
//                     child: Text(
//                       photo.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style:
//                       const TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ),
//                   child: Image.network(photo.thumbnailUrl, fit: BoxFit.cover),
//                 );
//               },
//             );
//           }
//
//           return const SizedBox(); // Default case
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../blocs/photo/photo_bloc.dart';
// import '../blocs/photo/photo_event.dart';
// import '../blocs/photo/photo_state.dart';
// import '../../data/models/photo.dart';
//
// class AlbumDetailScreen extends StatelessWidget {
//   final int albumId;
//   final String albumTitle;
//
//   const AlbumDetailScreen({
//     super.key,
//     required this.albumId,
//     required this.albumTitle,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     context.read<PhotoBloc>().add(LoadPhotosByAlbumId(albumId));
//
//     return Scaffold(
//       appBar: AppBar(title: Text('Album: $albumTitle')),
//       body: BlocBuilder<PhotoBloc, PhotoState>(
//         builder: (context, state) {
//           if (state is PhotoLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is PhotoError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(state.message),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       context.read<PhotoBloc>().add(LoadPhotosByAlbumId(albumId));
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state is PhotoLoaded) {
//             final photos = state.photos;
//
//             if (photos.isEmpty) {
//               return const Center(child: Text('No photos found.'));
//             }
//
//             return GridView.builder(
//               padding: const EdgeInsets.all(10),
//               itemCount: photos.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//               ),
//               itemBuilder: (context, index) {
//                 final photo = photos[index];
//                 return GridTile(
//                   footer: Container(
//                     color: Colors.black54,
//                     padding: const EdgeInsets.all(4),
//                     child: Text(
//                       photo.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ),
//                   child: Image.network(photo.thumbnailUrl, fit: BoxFit.cover),
//                 );
//               },
//             );
//           }
//
//           return const SizedBox(); // Default case
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '../../data/models/photo.dart';
//
// class AlbumDetailScreen extends StatelessWidget {
//   final int albumId;
//   final String albumTitle;
//   final List<Photo> photos;
//
//   const AlbumDetailScreen({
//     super.key,
//     required this.albumId,
//     required this.albumTitle,
//     required this.photos,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Album: $albumTitle')),
//       body: photos.isEmpty
//           ? const Center(child: Text('No photos found.'))
//           : GridView.builder(
//         padding: const EdgeInsets.all(10),
//         itemCount: photos.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemBuilder: (context, index) {
//           final photo = photos[index];
//           return GridTile(
//             footer: Container(
//               color: Colors.black54,
//               padding: const EdgeInsets.all(4),
//               child: Text(
//                 photo.title,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(color: Colors.white, fontSize: 12),
//               ),
//             ),
//             child: Image.network(photo.thumbnailUrl, fit: BoxFit.cover),
//           );
//         },
//       ),
//     );
//   }
// }

