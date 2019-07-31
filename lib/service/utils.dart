formatTime(int second) {
  String toDigit(int n) {
    if(n>=10) return '$n';
    return '0$n';
  }
  return '${toDigit(second~/60)}:${toDigit(second%60)}';
}