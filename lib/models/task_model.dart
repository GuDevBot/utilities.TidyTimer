class Task {
  String id;          // Um ID único para cada tarefa
  String name;        // Ex: "Lavar o banheiro"
  String category;    // Ex: "Banheiro", "Cozinha" (para filtros futuros)
  int frequencyInDays; // Com que frequência precisa ser refeita (ex: 7, 30)
  DateTime lastDone;  // A última vez que foi concluída

  Task({
    required this.id,
    required this.name,
    required this.category,
    required this.frequencyInDays,
    required this.lastDone,
  });

  // Uma propriedade "calculada" para saber quando é a próxima vez
  DateTime get nextDueDate {
    return lastDone.add(Duration(days: frequencyInDays));
  }
}