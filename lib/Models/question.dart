class Question {
  int id;
  String answer;

  Question({this.id, this.answer});

  Map<String, dynamic> toMap() =>{
    "id": id,
    "answer": answer,
  };

  factory Question.fromMap(Map<String, dynamic> json) => new Question(
    id: json["id"],
    answer:json["answer"],
  );

}