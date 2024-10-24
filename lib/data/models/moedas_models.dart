class MoedaCot{
  final String code;
  final String codein;
  final String name;

  MoedaCot({
    required this.code,
    required this.codein,
    required this.name,
  });

factory MoedaCot.fromMap(Map<String, dynamic> map) {
  return MoedaCot(
    code: map['code'],
    codein: map['codein'],
    name: map['name'],
  );
 }
}
