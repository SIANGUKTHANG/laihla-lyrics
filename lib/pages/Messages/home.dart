import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'chat_page.dart';
import 'models.dart';

class ConversationsPage extends StatefulWidget {
  final String userId;

  const ConversationsPage({super.key, required this.userId});

  @override
  ConversationsPageState createState() => ConversationsPageState();
}

class ConversationsPageState extends State<ConversationsPage> {
  List<Conversation> conversations = [];

  @override
  void initState() {
    super.initState();
    fetchConversations();
  }

  Future<void> fetchConversations() async {
    final url = Uri.parse(
        'https://itrungrul.xyz/messages/conversations/${widget.userId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        conversations = data.map((json) => Conversation.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Chats',style: TextStyle(color: Colors.white70),),

      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ListTile(
            onTap: (){
              Get.to(()=> ChatPage(userId: widget.userId,
                chatPartnerId: conversation.participantId,
                chatPartnerName: conversation.participantName,
                chatPartnerUrl: conversation.participantImageUrl,

              ));
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(conversation.participantImageUrl),
            ),
            title: Text(conversation.participantName,style: const TextStyle(color: Colors.white),),
            subtitle: Text(conversation.lastMessage),
            trailing: Text(
              "${conversation.createdAt.toLocal()}".split(' ')[0],
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          );
        },
      ),
    );
  }
}
