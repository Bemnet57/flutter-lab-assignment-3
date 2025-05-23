abstract class PhotoEvent {}

class LoadPhotosByAlbumId extends PhotoEvent {
  final int albumId;

  LoadPhotosByAlbumId(this.albumId);
}
