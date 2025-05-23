import 'package:flutter_bloc/flutter_bloc.dart';
import 'photo_event.dart';
import 'photo_state.dart';
import '../../../domain/repository/photo_repository.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository photoRepository;

  PhotoBloc(this.photoRepository) : super(PhotoInitial()) {
    on<LoadPhotosByAlbumId>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await photoRepository.getPhotosByAlbumId(event.albumId);
        emit(PhotoLoaded(photos));
      } catch (e) {
        emit(PhotoError(e.toString()));
      }
    });
  }
}
