// class User {
//   final bool status;
//   final String message;
//   final Data data;

//   const User({required this.status, required this.message, required this.data});

//   User.fromJson(Map<String, dynamic> userJson)
//       : status = userJson['status'],
//         message = userJson['message'],
//         data = Data.fromJson(
//           userJson['data'],
//         );
// }

class User {
  final String id;
  final String name;
  final String email;
  final String auth;
  final String picture;

  User.fromJson(Map<String, dynamic> dataJson)
      : id = dataJson['id'],
        name = dataJson['name'],
        email = dataJson['email'],
        auth = dataJson['auth'],
        picture = dataJson['picture'];
}
