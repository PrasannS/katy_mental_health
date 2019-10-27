class Entry {
  int    id;
  int    sleep;
  int    mood;
  int    water;
  int    questionId;
  int activity;
  String answer;
  String note;

  Entry({this.id, this.sleep, this.mood, this.water, this.questionId,this.activity,
    this.answer, this.note});

  Map<String, dynamic> toMap() =>{
    "id": id,
    "sleep": sleep,
    "mood": mood,
    "water": water,
    "questionId": questionId,
    "answer": answer,
    "note": note,
    "activity":activity
  };

  factory Entry.fromMap(Map<String, dynamic> json) => new Entry(
    id: json["id"],
    sleep:json["sleep"],
    mood: json["mood"],
    water: json["water"],
    questionId:json["questionId"],
    activity:json["activity"],
    answer:json["answer"],
    note:json["note"],
  );


}