class Photo {
  final String name;
  final String path;

  Photo(this.path) : name = path.split('/').last;

  @override
  String toString() {
    return 'Photo{name: $name, path: $path}';
  }
}
