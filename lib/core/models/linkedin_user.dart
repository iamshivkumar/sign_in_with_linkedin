class LinkedinUser {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;
  LinkedinUser(
      {this.firstName, this.id, this.lastName, this.email, this.imageUrl});

  factory LinkedinUser.fromJson(
      Map<String, dynamic> json, Map<String, dynamic> jsonEmail) {
    return LinkedinUser(
      id: json["id"],
      firstName: json["localizedFirstName"],
      lastName: json["localizedLastName"],
      email: jsonEmail["elements"][0]["handle~"]["emailAddress"],
      imageUrl: json["profilePicture"]["displayImage~"]["elements"][3]
          ["identifiers"][0]["identifier"],
      
    );
  }
}
