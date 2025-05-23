import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_list_event.dart';
import 'album_list_state.dart';
import '../../../domain/repository/album_repository.dart';

class AlbumListBloc extends Bloc<AlbumListEvent, AlbumListState> {
  final AlbumRepository repository;

  AlbumListBloc({required this.repository}) : super(AlbumListInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumListLoading());
      try {
        final albums = await repository.getAlbums();
        emit(AlbumListLoaded(albums));
      } catch (e) {
        emit(AlbumListError('Failed to load albums'));
      }
    });
  }
}
