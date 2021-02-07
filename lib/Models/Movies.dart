class Movies {
  String title ;
  String image ;
  var rating ;
  var releaseYear ;
  List<dynamic> genre ;

  Movies(this.title, this.image, this.rating, this.releaseYear, this.genre);
  factory Movies.fromJson(Map<String,dynamic> data) {
    return Movies(data["title"], data["image"], data["rating"], data["releaseYear"], data["genre"]);
  }

}