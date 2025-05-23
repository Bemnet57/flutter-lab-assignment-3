import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'album_list_bloc.dart';
import 'album_list_state.dart';
import 'album_list_event.dart';

import 'package:go_router/go_router.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumListBloc, AlbumListState>(
        builder: (context, state) {
          if (state is AlbumListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumListLoaded) {
            final albums = state.albums;
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return ListTile(
                  title: Text(album.title),
                  onTap: () {
                    // TODO: Navigate to album detail using GoRouter
                    context.push('/album/${album.id}?title=${Uri.encodeComponent(album.title)}');
                  },
                );
              },
            );
          } else if (state is AlbumListError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumListBloc>().add(FetchAlbums());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
