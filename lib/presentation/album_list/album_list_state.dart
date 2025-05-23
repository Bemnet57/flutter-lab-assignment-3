import '../../../data/models/album.dart';

abstract class AlbumListState {}

class AlbumListInitial extends AlbumListState {}

class AlbumListLoading extends AlbumListState {}

class AlbumListLoaded extends AlbumListState {
  final List<Album> albums;

  AlbumListLoaded(this.albums);
}

class AlbumListError extends AlbumListState {
  final String message;

  AlbumListError(this.message);
}
