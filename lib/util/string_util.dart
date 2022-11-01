extension TitleCase on String {
  String get titleCase {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
