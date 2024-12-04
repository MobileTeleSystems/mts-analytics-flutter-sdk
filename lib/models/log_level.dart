enum LogLevel {
  off(4),
  error(3),
  warning(2),
  debug(1),
  verbose(0);

  const LogLevel(this.level);
  final int level;
}
