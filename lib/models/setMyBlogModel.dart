class SetMyBlogModel{
  late String userId;
  late String blogTime;
  late String blogId;
  String? title;
  String? desc;
  String? image;
  String? userName;
  String? profileImage;
  int totalLikes;
  int totalComments;
  var blogLikeId  = [];

  SetMyBlogModel(this.userId,this.blogTime,this.blogId,this.title,this.desc,this.image,this.userName,this.profileImage,this.totalLikes,this.totalComments,this.blogLikeId);
}