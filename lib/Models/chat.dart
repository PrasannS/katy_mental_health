
class Chat {
  int id;
  String chatterid;

  Chat({this.id, this.chatterid});

  Map<String, dynamic> toMap() =>{
    "id": id,
    "chatterid": chatterid,
  };

  factory Chat.fromMap(Map<String, dynamic> json) => new Chat(
    id: json["id"],
    chatterid:json["chatterid"],

  );

  @override
  String toString() {
    return 'Entry{id: $id, chatterid: $chatterid}';
  }


}