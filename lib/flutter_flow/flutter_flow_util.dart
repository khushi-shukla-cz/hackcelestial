extension ListDivide<T> on List<T> {
  List<T> divide(T divider) {
    if (isEmpty) return [];
    final result = <T>[];
    for (var i = 0; i < length; i++) {
      result.add(this[i]);
      if (i < length - 1) result.add(divider);
    }
    return result;
  }

  List<T> addToStart(T value) {
    return [value, ...this];
  }

  List<T> addToEnd(T value) {
    return [...this, value];
  }
}
