/// extensions on String
extension StringUtils on String? {
  static const _nameRegex = r'^[a-z A-Z]{2,30}$';

  ///an extension to validate a name
  bool get isValidName => this != null && (RegExp(_nameRegex).hasMatch(this!));
}
