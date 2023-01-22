class NotFoundException implements Exception {
  NotFoundException({this.cause = ''});
  String cause;

  @override
  String toString() {
    return cause.isNotEmpty ? cause : '이미 입력된 정보입니다';
  }
}
