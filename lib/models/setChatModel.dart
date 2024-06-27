class SetChatModel{
  late String id;
  late String image;
  late String message;
  String? receiveId;
  String? receiveName;
  String? sendId;
  String? sendName;
  String? sendTime;
  bool ? isSend;

  SetChatModel(this.id,this.image,this.message,this.receiveId,this.receiveName,this.sendId,this.sendName,this.sendTime,this.isSend);
}