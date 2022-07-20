import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/stories.dart';
import 'package:chat_app/utils/theme.dart';
import 'package:chat_app/widgets/avatar.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(child: _Stories()),
        SliverList(
          delegate: SliverChildBuilderDelegate(_delegates)
        )
      ],
    );
  }

  Widget _delegates(BuildContext context, int index) {
    final faker = Faker();
    return _MessageTile(messageModel: MessageModel(message: faker.lorem.sentence(), profilePicture: 'https://cdn.britannica.com/61/103761-050-0174C1D5/Angelina-Jolie-Hollywood.jpg?w=400&h=300&c=crop', senderName: faker.person.name(), dateMessage: 'date', messageData: '03:30PM'));
  }
}


class _Stories extends StatelessWidget {
  const _Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124,
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text('Stories', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: AppColors.textFaded)),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final faker = Faker();
                return SizedBox(
                  width: 60,
                  child: _StoryCard(storyModel: StoryModel(name: faker.person.name(), url: ''))
                );
              }

            ),
          )
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({Key? key, required this.storyModel}) : super(key: key);
  final StoryModel storyModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(url: 'https://cdn.britannica.com/61/103761-050-0174C1D5/Angelina-Jolie-Hollywood.jpg?w=400&h=300&c=crop'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(storyModel.name, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: .3),),
          )
        )
      ],
    );
  }
}


class _MessageTile extends StatelessWidget {
  const _MessageTile({Key? key, required this.messageModel}) : super(key: key);

  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(messageModel: messageModel)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Avatar.medium(url: messageModel.profilePicture),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(messageModel.senderName, overflow: TextOverflow.ellipsis, style: TextStyle(letterSpacing: .3, wordSpacing: 1.5, fontWeight: FontWeight.w900),),
                  Text(messageModel.message, overflow: TextOverflow.ellipsis)
                ],
              )
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('time', style: TextStyle(fontSize: 11, letterSpacing: -.2, fontWeight: FontWeight.w600, color: AppColors.textFaded)),
                Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle
                  ),
                  child: Text('1', style: TextStyle(fontSize: 10, color: AppColors.textLight)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
