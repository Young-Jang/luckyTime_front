class GetLuckyNumber{
  const GetLuckyNumber({required this.luckyNumber});

  final String luckyNumber;

  factory GetLuckyNumber.fromJson(Map<String, dynamic> json) {
    return GetLuckyNumber(luckyNumber: json['luckyNumber']);
  }
}