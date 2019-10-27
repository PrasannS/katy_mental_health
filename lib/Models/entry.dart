class Entry {
  int    id;
  int    sleep;
  int    mood;
  int    water;
  int    question_id;
  int activity;
  String answer;
  String note;

  Entry({this.id, this.sleep, this.mood, this.water, this.question_id,this.activity,
    this.answer, this.note});

  Map<String, dynamic> toMap() =>{
    "id": id,
    "sleep": sleep,
    "mood": mood,
    "water": water,
    "question_id": question_id,
    "answer": answer,
    "note": note,
    "activity":activity
  };

  factory Entry.fromMap(Map<String, dynamic> json) => new Entry(
    id: json["id"],
    sleep:json["sleep"],
    mood: json["mood"],
    water: json["water"],
    question_id:json["question_id"],
    activity:int.parse(json["activity"]),
    answer:json["answer"],
    note:json["note"],
  );

  @override
  String toString() {
    return 'Entry{id: $id, sleep: $sleep, mood: $mood, water: $water, question_id: $question_id, activity: $activity, answer: $answer, note: $note}';
  }


}