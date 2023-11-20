import 'package:body_gym/widget/Bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class VideoList extends StatefulWidget {
  const VideoList({super.key});

  @override
  State<VideoList> createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final List _elements = [
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'chest'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'chest'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'chest'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'chest'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'biceps'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'biceps'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'biceps'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'biceps'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'biceps'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'biceps'
    },
    {
      'url': 'https://www.youtube.com/watch?v=1U0nRj6JvM4',
      'thumbnail': 'https://i.ytimg.com/vi/1U0nRj6JvM4/maxresdefault.jpg',
      'title': 'train chest',
      'group': 'biceps'
    },
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomBar(displayWidth: displayWidth),
      appBar: AppBar(
        title: const Text("Video List"),
      ),
      body: GroupedListView(
        elements: _elements,
        groupBy: (element) => element['group'],
        groupSeparatorBuilder: (groupValue) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            groupValue,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1['title'].compareTo(item2['title']),
        order: GroupedListOrder.ASC,
        useStickyGroupSeparators: true,
        itemBuilder: (c, element) {
          return Card(
            elevation: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: Image.network(element['thumbnail']),
                title: Text(element['title']),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
          );
        },
      ),
    );
  }
}
