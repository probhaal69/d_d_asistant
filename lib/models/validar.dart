


bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  return emailRegex.hasMatch(email);
}
bool isFormularioRegistroCompleto(String usuario, String email, String password) {
  if (usuario == '' || email == '' || password == '') {
    return false;
  }
  return true;
}
bool isFormularioCompleto(String campo1, String campo2) {
  if (campo1 == '' || campo2 == '') {
    return false;
  }
  return true;
}
bool isValidPassword(String password) {
  final RegExp passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{5,}$');
  return passwordRegex.hasMatch(password);
}