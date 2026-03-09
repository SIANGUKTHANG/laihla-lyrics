import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'chat_page.dart';
import 'models.dart';

class ChatHome extends StatefulWidget {
  final String userId;
  final List songs;

  const ChatHome({super.key, required this.userId, required this.songs});

  @override
  ChatHomeState createState() => ChatHomeState();
}

class ChatHomeState extends State<ChatHome> {
  List<Conversation> conversations = [];
  List<User> allUsers = [];
  List<dynamic> songs = [];
  bool isPeopleVisible = false;

  @override
  void initState() {
    super.initState();
    fetchConversations();
    readSong().then((e){
      user();
    });


  }

  Future<void> fetchConversations() async {
    final user = Uri.parse(
        'https://laihlalyrics.itrungrul.com/messages/conversations/${widget.userId}');
    final response = await http.get(user);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      setState(() {
        conversations =
            data.map((json) => Conversation.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  Future<void> user() async {
    final user = Uri.parse('https://laihlalyrics.itrungrul.com/users/all');
    final response = await http.get(user);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      final users = data.map((json) => User.fromJson(json)).toList();

      for (var user in users) {
        user.songCount = songs.where((song) => song['userId'] == user.id).length;
      }

      users.sort((a, b) => b.songCount.compareTo(a.songCount));

      setState(() {
        allUsers = users;
      });
    } else {
      throw Exception('Failed to load conversations');
    }
  }


  Future<void> readSong() async {
    const fileName = 'hla';
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName';
    final file = File(filePath);


      // 1. Load from local file immediately
      if (await file.exists()) {
        final localData = json.decode(await file.readAsString()) as List;

        localData.sort((a, b) =>
            a["title"].toLowerCase().compareTo(b["title"].toLowerCase()));

        setState(() {
          songs = localData;

        });
      }
    }

      void showBottomPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'People',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),    Text(
                    allUsers.length.toString(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: allUsers.length,
                  itemBuilder: (context, index) {
                    final users = allUsers[index];
                    return widget.userId == users.id
                        ? const SizedBox(
                            height: 1,
                          )
                        : ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Get.to(() => ChatPage(
                                songs: widget.songs,
                                    userId: widget.userId,
                                    chatPartnerId: users.id,
                                    chatPartnerName: users.username,
                                    chatPartnerUrl: users.imageUrl,
                                  ));
                            },
                            leading: users.imageUrl == ''
                                ? const CircleAvatar(
                                    child: Icon(Icons.person),
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(users.imageUrl),
                                  ),
                            title: Text(
                              users.username,
                              style: const TextStyle(color: Colors.white),
                            ),
                      //i want to add here each users posted songs
                      trailing: Text(
                        '${users.songCount} songs',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),

                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Chats',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          IconButton(
            onPressed: showBottomPopup,
            icon: const Icon(
              Icons.people,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ListTile(
            onTap: () {
              Get.to(() => ChatPage(
                songs: widget.songs,
                    userId: widget.userId,
                    chatPartnerId: conversation.participantId,
                    chatPartnerName: conversation.participantName,
                    chatPartnerUrl: conversation.participantImageUrl,
                  ));
            },
            leading: conversation.participantImageUrl == ''
                ? const CircleAvatar(
                    child: Icon(Icons.person),
                  )
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage(conversation.participantImageUrl),
                  ),
            title: Text(
              conversation.participantName,
              style: const TextStyle(color: Colors.white),
            ),
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
