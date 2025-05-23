import 'package:dio/dio.dart';
import '../../data/models/photo.dart';
import '../../domain/repository/photo_repository.dart';
import '../network/api_client.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  final ApiClient apiClient;

  PhotoRepositoryImpl({required this.apiClient});

//   @override
//   Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
//     try {
//       final response = await apiClient.get('/photos?albumId=$albumId');
//       return (response as List)
//           .map((json) => Photo.fromJson(json as Map<String, dynamic>))
//           .toList();
//
//
//     } catch (e) {
//       throw Exception('Failed to load photos: $e');
//     }
//   }
// }
  @override
  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    try {
      return await apiClient.getPhotosByAlbumId(albumId);
    } catch (e) {
      throw Exception('Failed to load photos: $e');
    }
  }
}