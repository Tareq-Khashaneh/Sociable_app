class InteractionsCountType{
  final int like;
  final int love;
  final int care;
  final int haha;
  final int wow;
  final int sad;
  final int angry;

  InteractionsCountType({required this.like, required this.love, required this.care, required this.haha, required this.wow, required this.sad, required this.angry});
  factory InteractionsCountType.fromJson(Map<String,dynamic> data)
  => InteractionsCountType(like: data['like'], love: data['love'], care: data['care'], haha: data['haha'], wow: data['wow'], sad: data['sad'], angry: data['angry']);
  Map<String ,int> toJSon()
  =>  {
       "like": like,
       "love": love,
       "care": care,
       "haha": haha,
       "wow": wow,
       "sad": sad,
       "angry": angry,
                  
    };
}