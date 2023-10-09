// Login Exceptions
class UserNotFoundAuthException implements Exception {
}
class WrongPasswordAuthException implements Exception {
}

// Register Exceptions
class WeakPasswordException implements Exception {
}
class EmailAlreadyInUseException implements Exception {
}
class InvalidEmailException implements Exception {
}
// Generic Exceptions
class GenericAuthException implements Exception {
}