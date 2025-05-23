import '../../data/models/album.dart';

abstract class AlbumRepository {
  Future<List<Album>> getAlbums();
}
