class FormEntity {
  FormEntity({
    this.name,
    this.email,
    this.description
  });

  FormEntity.fromJson(Map<String, dynamic> dynamicData) {
    if (dynamicData != null) {
      name = dynamicData['name'];
      email = dynamicData['title'];
      description = dynamicData['description'];
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['description'] = description;
    return data;
  }

  String name;
  String email;
  String description;
}