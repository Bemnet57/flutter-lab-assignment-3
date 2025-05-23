import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/album_list/album_list_screen.dart';
import '../presentation/album_detail/album_detail_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListScreen(),
    ),
    GoRoute(
      path: '/album/:id',
      builder: (context, state) {
        final albumId = int.parse(state.pathParameters['id']!);
        final albumTitle = state.uri.queryParameters['title'] ?? 'Unknown';
        return AlbumDetailScreen(albumId: albumId, albumTitle: albumTitle);
      },
    ),
  ],
);




// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../presentation/album_list/album_list_screen.dart';
// import '../presentation/album_detail/album_detail_screen.dart';
//
// final GoRouter router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const AlbumListScreen(),
//     ),
//     GoRoute(
//       path: '/album/:id',
//       builder: (context, state) {
//         final albumId = int.parse(state.params['id']!);
//         final albumTitle = state.queryParams['title'] ?? 'Unknown';
//         return AlbumDetailScreen(albumId: albumId, albumTitle: albumTitle);
//       },
//     ),
//   ],
// );
