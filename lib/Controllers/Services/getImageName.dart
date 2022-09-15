String getImageName({required url}) {
  var removeStart = "%2F";
  var removeEnd = "?alt";
  final startIndex = url.indexOf(removeStart);
  final endIndex = url.indexOf(removeEnd, startIndex + removeStart.length);
  var fileName = url.substring(startIndex + removeStart.length, endIndex);
  return fileName.substring(0, fileName.indexOf("."));
}
