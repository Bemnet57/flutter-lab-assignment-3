import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'data/network/api_client.dart';
import 'routes/app_router.dart'; // Your router file
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'blocs/album/album_bloc.dart';
import 'presentation/album_list/album_list_bloc.dart';
import 'presentation/album_list/album_list_event.dart';

//import 'presentation/blocs/album_list/album_list_block' //added
import 'presentation/blocs/photo/photo_bloc.dart';
import 'data/repository/album_repository_impl.dart';
import 'data/repository/photo_repository_impl.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final dio = Dio();
  final apiClient = ApiClient(Dio());
  final albumRepository = AlbumRepositoryImpl(apiClient: ApiClient(Dio()));
  final photoRepository = PhotoRepositoryImpl(apiClient: ApiClient(Dio()));

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AlbumListBloc(repository: albumRepository)
            ..add(FetchAlbums()),

        ),
        BlocProvider(
          create: (_) => PhotoBloc(photoRepository),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Album App',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final albumRepository = AlbumRepositoryImpl();
//   final photoRepository = PhotoRepositoryImpl();
//
//   MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => AlbumListBloc(albumRepository)..add(LoadAlbums()),
//         ),
//         BlocProvider(
//           create: (_) => PhotoBloc(photoRepository),
//         ),
//       ],
//       child: MaterialApp.router(
//         title: 'Flutter Album App',
//         debugShowCheckedModeBanner: false,
//         routerConfig: router,
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final albumRepository = AlbumRepositoryImpl();
//   final photoRepository = PhotoRepositoryImpl();
//
//   MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => AlbumBloc(albumRepository)..add(LoadAlbums())),
//         BlocProvider(create: (_) => PhotoBloc(photoRepository)),
//       ],
//       child: MaterialApp.router(
//         title: 'Flutter Album App',
//         debugShowCheckedModeBanner: false,
//         routerConfig: router,
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:dio/dio.dart';
//
// import 'data/network/api_client.dart';
// import 'data/repository/album_repository_impl.dart';
// import 'domain/repository/album_repository.dart';
// import 'presentation/album_list/album_list_bloc.dart';
// import 'presentation/album_list/album_list_event.dart';
// import 'presentation/album_list/album_list_screen.dart'; // We'll create this soon
//
// void main() {
//   final dio = Dio();
//   final apiClient = ApiClient(dio);
//   final AlbumRepository repository = AlbumRepositoryImpl(apiClient: apiClient);
//
//   runApp(MyApp(repository: repository));
// }
//
// class MyApp extends StatelessWidget {
//   final AlbumRepository repository;
//
//   const MyApp({super.key, required this.repository});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Album App',
//       home: BlocProvider(
//         create: (_) => AlbumListBloc(repository: repository)..add(FetchAlbums()),
//         child: const AlbumListScreen(), // UI screen we'll build next
//       ),
//     );
//   }
// }
