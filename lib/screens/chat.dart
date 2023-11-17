import 'package:chatapp/models/message.dart';
import 'package:chatapp/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> messages = FirebaseFirestore.instance
      .collection('messages')
      .orderBy("createdAt", descending: true)
      .snapshots();
  CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late var mail;
  void _scrollToLast() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 25),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    mail = email;
    setState(() {});

    return StreamBuilder<QuerySnapshot>(
      stream: messages,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(
              Message.fromJson(snapshot.data!.docs[i]),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    "https://thumbs.dreamstime.com/b/cute-robot-png-background-generative-ai-274006024.jpg",
                    width: 50,
                    height: 50,
                  ),
                  const Text("   My Chat"),
                ],
              ),
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromARGB(255, 4, 48, 83),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBuble(text: messageList[index].message)
                          : ChatBubleForAnother(
                              text: messageList[index].message);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) => _submitMessage(),
                    decoration: InputDecoration(
                      hintText: "Send Message",
                      suffixIcon: GestureDetector(
                        onTap: _submitMessage,
                        child: const Icon(
                          Icons.send,
                          color: Color.fromARGB(255, 4, 48, 83),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.blueGrey)),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(color: Colors.cyanAccent),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Text('Something went wrong');
        } else {
          return const Text('Loading.....');
        }
      },
    );
  }

  void _submitMessage() {
    final value = controller.text.trim();
    setState(() {});
    if (value.isNotEmpty) {
      messagesCollection.add({
        "message": value,
        "createdAt": DateTime.now(),
        "id": mail,
      });
      controller.clear();
      _scrollToLast();
    }
  }
}
