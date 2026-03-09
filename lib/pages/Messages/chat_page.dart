import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../user/profile.dart';
import '../web_socket/socket_service.dart';
import 'models.dart';

class ChatPage extends StatefulWidget {

  final List songs; // Thsongse logged-in user's ID
  final String userId; // Thsongse logged-in user's ID
  final String chatPartnerId; // The ID of the user they are chatting with
  final String chatPartnerName; // Display name of the chat partner
  final String chatPartnerUrl; // Display name of the chat partner

  const ChatPage({
    super.key,
    required this.userId,
    required this.chatPartnerId,
    required this.chatPartnerName,
    required this.chatPartnerUrl, required this.songs,
  });

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late WebSocketService webSocketService;
  List<Message> messages = []; // List to store chat messages
  TextEditingController messageController = TextEditingController();

  int page = 1;
  bool isLoading = false;
  bool hasMore = true;
  final int limit = 10;
  late io.Socket socket;

  @override
  void initState() {
    super.initState();
    webSocketService = WebSocketService();
    webSocketService.initializeSocket(widget.userId);
    fetchChatMessages();
    // Listen for incoming messages and add them to the messages list
    webSocketService.socket.on('new_message', (data) {

      final newMessage = Message.fromJson(data);

      if (newMessage.senderId == widget.chatPartnerId || newMessage.receiverId == widget.chatPartnerId) {
        setState(() {
          messages.insert(0,newMessage); // Add the incoming message to the list
        });
      }
    });
  }



  Future<void> fetchChatMessages() async {
    if (isLoading || !hasMore) return;

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'https://laihlalyrics.itrungrul.com/messages/${widget.userId}/${widget.chatPartnerId}?page=$page&limit=$limit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List<Message> fetchedMessages = (data['messages'] as List)
          .map((json) => Message.fromJson(json))
          .toList();

      final int totalMessages = data['totalMessages'];

      setState(() {
        page++;
        messages.insertAll(0, fetchedMessages); // Add new messages at the beginning
        hasMore = messages.length < totalMessages; // Check if more messages are available
      });
    } else {
      throw Exception('Failed to load chat messages');
    }

    setState(() {
      isLoading = false;
    });
  }


  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) return;

    final newMessage = messageController.text;
    final url = Uri.parse('https://laihlalyrics.itrungrul.com/messages/create');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "message": newMessage,
        "sender": widget.userId,
        "receiver": widget.chatPartnerId,
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        messages.insert(0,Message.fromJson(json.decode(response.body)));
      });
      messageController.clear();
    } else {
      throw Exception('Failed to send message');
    }
  }

  @override
  void dispose() {
    // Dispose of the WebSocketService when the chat page is closed
    webSocketService.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(   onTap: (){
          Get.to(() => ProfileScreen(
            songs: widget.songs,
            username: widget.chatPartnerName,
            id: widget.chatPartnerId,
            imageUrl: widget.chatPartnerUrl,
          ));
        },child: widget.chatPartnerUrl== ''?

        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Image.asset('assets/account.png'),
        )
            :Padding(
          padding: const EdgeInsets.all(6.0),
          child: CircleAvatar(backgroundImage: NetworkImage(widget.chatPartnerUrl),),
        ),),
        title: Text(widget.chatPartnerName,style: const TextStyle(color: Colors.white70),),
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.minScrollExtent) {

                  fetchChatMessages(); // Load more messages when scrolled to the top
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () async{
                  fetchChatMessages();
                },
                child: ListView.builder(
                  reverse: true, // To start from the most recent message
                  itemCount: messages.length + (hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final message = messages[index];

                    final isMe = message.senderId == widget.userId ;

                    DateTime localDate = message.createdAt.toLocal();

                          // Convert to 12-hour format and add AM/PM
                    int hour = localDate.hour > 12 ? localDate.hour - 12 : localDate.hour;
                    hour = hour == 0 ? 12 : hour; // Adjust for 12 AM and 12 PM
                    String period = localDate.hour >= 12 ? 'PM' : 'AM';

                          // Format the date and time up to the minute without milliseconds in 12-hour format
                    String formattedDate = '${localDate.year}/${localDate.month.toString().padLeft(2, )}/${localDate.day.toString().padLeft(2, '0')} '
                        '${hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, )} $period';

                    return ListTile(


                      leading: isMe?const SizedBox(width: 0,):
                      widget.chatPartnerUrl==''?const CircleAvatar(child: Icon(Icons.person),)
                      :CircleAvatar(backgroundImage: NetworkImage(widget.chatPartnerUrl),),

                      title: Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blueAccent : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Container(

                                padding: const EdgeInsets.all(8.0),

                                child: Text(
                                  message.message,
                                  style: TextStyle(
                                      color: isMe ? Colors.white : Colors.black),
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: isMe ? Colors.white70 : Colors.black54,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    minLines: 1,
                    maxLines: null,
                    controller: messageController,
                    cursorColor: Colors.white70,
                    style: const TextStyle(color: Colors.white70),
                    decoration: InputDecoration(

                      hintText: 'Type a message..',
                      hintStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white70,
                  ),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
