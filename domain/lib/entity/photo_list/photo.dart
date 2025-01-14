class Photo {
  final String name;
  final String path;

  Photo(this.path) : name = path.split('/').last;
}
