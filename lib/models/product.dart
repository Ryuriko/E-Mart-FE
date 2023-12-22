class Product {
  final bool status;
  final String message;
  final List<Data> data;

  const Product(
      {required this.status, required this.message, required this.data});

  Product.fromJson(Map<String, dynamic> productJson)
      : status = productJson['status'],
        message = productJson['message'],
        data = List.from(productJson['data'])
            .map((data) => Data.fromJson(data))
            .toList();
}

class Data {
  final String id;
  final String userId;
  final String categoryId;
  final String name;
  final String price;
  final String stock;
  final String? picture;
  final String desc;
  final Category category;
  final User user;

  Data.fromJson(Map<dynamic, dynamic> dataJson)
      : id = dataJson['id'],
        categoryId = dataJson['category_id'],
        userId = dataJson['user_id'],
        name = dataJson['name'],
        price = dataJson['price'],
        stock = dataJson['stock'],
        picture = dataJson['picture'],
        desc = dataJson['desc'],
        category = Category.fromJson(dataJson['category']),
        user = User.fromJson(dataJson['user']);
}

class Category {
  final String id;
  final String name;

  Category.fromJson(Map<String, dynamic> categoryJson)
      : id = categoryJson['id'],
        name = categoryJson['name'];
}

class User {
  final String id;
  final String name;

  User.fromJson(Map<String, dynamic> categoryJson)
      : id = categoryJson['id'],
        name = categoryJson['name'];
}
