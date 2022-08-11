class AddByStatusModel {
  int? yet;
  int? owned;
  int? beaten;
  int? toplay;
  int? dropped;
  int? playing;

  AddByStatusModel({
    this.yet,
    this.owned,
    this.beaten,
    this.toplay,
    this.dropped,
    this.playing,
  });

  factory AddByStatusModel.fromJson(Map<String, dynamic> json) => AddByStatusModel(
        yet: json['yet'],
        owned: json['owned'],
        beaten: json['beaten'],
        toplay: json['toplay'],
        dropped: json['dropped'],
        playing: json['playing'],
      );

  Map<String, dynamic> toJson() {
    return {
      'yet': yet,
      'owned': owned,
      'beaten': beaten,
      'toplay': toplay,
      'dropped': dropped,
      'playing': playing,
    };
  }
}
