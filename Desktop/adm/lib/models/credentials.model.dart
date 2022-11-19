

import 'package:json_annotation/json_annotation.dart';

part 'credentials.model.g.dart';

@JsonSerializable()
class Credentials {
  String cpf;
  String password;

  Credentials({
    required this.cpf,
    required this.password,
  });
  factory Credentials.fromJson(Map<String, dynamic> json) => _$CredentialsFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);

  bool cpfIsValid() {
    return cpf.isNotEmpty;
  }
  bool passwordIsValid() {
    return password.isNotEmpty;
  }
}

