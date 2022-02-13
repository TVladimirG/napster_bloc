import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:napster_bloc/src/global/common_params.dart';
import 'package:napster_bloc/src/models/tracks_model.dart';
import 'package:napster_bloc/src/widgets/player/player.dart';

class MyCollection extends StatefulWidget {
  static const routeName = '/MyCollection';
  const MyCollection({
    Key? key,
  }) : super(key: key);

  @override
  _MyCollectionState createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {
  bool reverseSort = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Моя коллекция'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  reverseSort = !reverseSort;
                });
              },
              icon: const Icon(Icons.sort)),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Track>('favorit_tracks').listenable(),
        builder: (context, Box<Track> box, child) {
          if (box.isEmpty) {
            return const Center(child: Text('Ваша коллекция пока еще пуста'));
          }

          final myCollList = box.values.toList();

          fixNullDate(myCollList, box);

          sortMyCollection(myCollList);

          return ListView.builder(
            key: CommonParams.pageCollectStorageKey,
            itemCount: myCollList.length,
            itemBuilder: (context, index) {
              final Track? currentTrack = myCollList[index];

              if (currentTrack is Track) {
                return GestureDetector(
                  onTap: () {
                    tapOnTrack(context, currentTrack);
                  },
                  child: Dismissible(
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.black54,
                        ),
                      ),
                      color: Colors.pink[100],
                    ),
                    //  confirmDismiss: (direction) {
                    //
                    //  },
                    confirmDismiss: (direction) async {
                      bool result = false;
                      if (direction == DismissDirection.endToStart) {
                        result =
                            await confirmDismiss(context, box, currentTrack);
                      }
                      return result;
                    },
                    key: Key(currentTrack.id),
                    child: CollectionItem(currentTrack: currentTrack),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  void fixNullDate(List<Track> myCollList, Box<Track> box) {
    final nullCol =
        myCollList.where((element) => element.addedCollection == null).toList();
    if (nullCol.isNotEmpty) {
      for (var item in nullCol) {
        item.addedCollection = DateTime.now();
      }
      box.addAll(myCollList);
    }
  }

  void sortMyCollection(List<Track> myCollList) {
    if (reverseSort) {
      myCollList
          .sort((a, b) => b.addedCollection!.compareTo(a.addedCollection!));
    } else {
      myCollList
          .sort((a, b) => a.addedCollection!.compareTo(b.addedCollection!));
    }
  }

  Future<dynamic> confirmDismiss(
      BuildContext context, Box<Track> box, Track currentTrack) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('Удалить трек из коллекции?'),
          actions: [
            OutlinedButton(
                onPressed: () {
                  box.delete(currentTrack.id);
                  Navigator.of(context).pop(true);
                },
                child: const Text('Да')),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Нет'))
          ],
        );
      },
    );
  }

  Future<dynamic> tapOnTrack(BuildContext context, Track currentTrack) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Player(
          currentTrack,
          showBtnLike: false,
          autoPlay: true,
        );
      },
    );
  }
}

class CollectionItem extends StatelessWidget {
  const CollectionItem({
    Key? key,
    required this.currentTrack,
  }) : super(key: key);

  final Track currentTrack;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: currentTrack.imagePreview,
        title: Text(
          currentTrack.name,
          overflow: TextOverflow.fade,
          style: const TextStyle(
              //  color: Colors.black,
              fontSize: 14.0),
        ),
        subtitle: Text(
          'Album: ${currentTrack.albumName}',
          overflow: TextOverflow.fade,
          style: const TextStyle(
              //  color: Colors.black,
              fontSize: 11.0),
        ),
        trailing: Text(
          currentTrack.artistName,
          overflow: TextOverflow.fade,
          style: const TextStyle(
              // color: Colors.black,
              fontSize: 12.0),
        ),
        // trailing: const Icon(Icons.play_circle_outline),
      ),
    );
  }
}
