import 'package:hive/hive.dart';

// Parte gerada automaticamente pelo build_runner
part '../tarefa.g.dart';

@HiveType(typeId: 0) // typeId deve ser único no projeto
class Tarefa {
  @HiveField(0)
  String titulo;

  @HiveField(1)
  String descricao;

  @HiveField(2)
  DateTime data;

  @HiveField(3)
  bool concluida;

  Tarefa({
    required this.titulo,
    required this.descricao,
    required this.data,
    this.concluida = false,
  });
}
