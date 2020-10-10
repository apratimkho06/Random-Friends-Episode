class Episode {
  final String airDate;
  final int episodeNumber;
  final String name;
  final String overview;
  final int id;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;

  Episode({
    this.airDate,
    this.episodeNumber,
    this.name,
    this.overview,
    this.id,
    this.seasonNumber,
    this.stillPath,
    this.voteAverage,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] as int,
      name: json['name'] as String,
      stillPath: json['still_path'] as String,
      voteAverage: json['vote_average'] is int
          ? (json['vote_average'] as int).toDouble()
          : json['vote_average'],
      overview: json['overview'] as String,
      airDate: json['air_date'] as String,
      episodeNumber: json['episode_number'] as int,
      seasonNumber: json['season_number'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['still_path'] = this.stillPath;
    data['name'] = this.name;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['air_date'] = this.airDate;
    data['episode_number'] = this.episodeNumber;
    data['season_number'] = this.seasonNumber;
    return data;
  }
}
