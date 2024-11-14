// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int age;

  User(this.age);

  User copyWith({
    int? age,
  }) {
    return User(
      age ?? this.age,
    );
  }
}
