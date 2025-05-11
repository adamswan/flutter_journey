// 判断是否为空字符串
bool isEmpty(String? str) {
  if (str == null || str.isEmpty) {
    return true;
  }
  return false;
}

// 判断是否不为空字符串
bool isNotEmpty(String? str) {
  return !isEmpty(str);
}
