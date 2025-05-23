import '../../domain/repository/album_repository.dart';
import '../models/album.dart';
import '../network/api_client.dart';
import 'package:dio/dio.dart';



// In main.dart or inside album_repository_impl.dart
// final dio = Dio();
// final apiClient = ApiClient(dio);
// final repository = AlbumRepositoryImpl(apiClient: apiClient);

// import '../../domain/repository/album_repository.dart';
// import '../models/album.dart';
// import '../network/api_client.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final ApiClient apiClient;

  AlbumRepositoryImpl({required this.apiClient});

  @override
  Future<List<Album>> getAlbums() async {
    try {
      return await apiClient.getAlbums();
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }
}
