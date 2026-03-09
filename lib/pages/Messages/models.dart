class Message {
  final String id;
  final String message;
  final String senderName;
  final String senderId;
  final String senderImageUrl;
  final String receiverName;
  final String receiverId;
  final String receiverImageUrl;
  final DateTime createdAt;



  Message({
    required this.id,
    required this.message,
    required this.senderName,
    required this.senderId,
    required this.senderImageUrl,
    required this.receiverName,
    required this.receiverId,
    required this.receiverImageUrl,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      message: json['message'],
      senderName: json['sender']['username'],
      senderId: json['sender']['_id'],
      senderImageUrl: json['sender']['imageUrl']??'',
      receiverName: json['receiver']['username'],
      receiverId: json['receiver']['_id'],
      receiverImageUrl: json['receiver']['imageUrl']??'',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}


class Conversation {
  final String lastMessage;
  final DateTime createdAt;
  final String participantName;
  final String participantId;
  final String participantImageUrl;

  Conversation({
    required this.lastMessage,
    required this.createdAt,
    required this.participantName,
    required this.participantId,
    required this.participantImageUrl,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      lastMessage: json['lastMessage'],
      createdAt: DateTime.parse(json['createdAt']),
      participantName: json['participantInfo']['username'],
      participantId: json['_id']['participant'],
      participantImageUrl: json['participantInfo']['imageUrl']??'',
    );
  }
}

class User {
  final String id;
  final String username;
  final String phone;
  final String email;
  final String imageUrl;

  int songCount; // <-- Add this line

  User({
    required this.id,
    required this.username,
    required this.phone,
    required this.email,
    required this.imageUrl,
    this.songCount = 0, // <-- Default to 0
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      phone: json['phone'],
      email: json['email'],
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'phone': phone,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}

