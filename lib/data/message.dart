class Message{
  String idTo;
  String idFrom;
  String content;
  String timestamp;
  String image;
  int type;


  Message({this.idTo, this.idFrom, this.content, this.timestamp, this.type, this.image});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      idTo: json['idTo'],
      idFrom: json['idFrom'],
      content: json['content'],
      timestamp: json['timestamp'],
      image: json['image'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTo'] = this.idTo;
    data['idFrom'] = this.idFrom;
    data['content'] = this.content;
    data['timestamp'] = this.timestamp;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}
