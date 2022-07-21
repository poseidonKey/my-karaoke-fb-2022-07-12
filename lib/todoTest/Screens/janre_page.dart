import 'package:flutter/material.dart';
import 'package:my_karaoke_firebase/sql/add_edit_screen.dart';
import 'package:my_karaoke_firebase/sql/db_helper.dart';
import 'package:my_karaoke_firebase/sql/song_item.dart';

class JanrePage extends StatefulWidget {
  const JanrePage({Key? key, required this.searchJanre}) : super(key: key);
  final String searchJanre;

  @override
  _JanrePageState createState() => _JanrePageState();
}

class _JanrePageState extends State<JanrePage> {
  Future<List<SongItem>>? _notes;

  @override
  void initState() {
    super.initState();
    searchData();
  }

  void searchData() {
    String searchTerm = widget.searchJanre;
    DbHelper helper = DbHelper();
    helper.openDb();
    if (searchTerm.isNotEmpty) {
      setState(() {
        _notes = helper.searchList(searchTerm);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Janre"),
      ),
      body: _notes == null
          ? const Center(
              child: Text(
                'Search for Notes',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : FutureBuilder(
              future: _notes,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                print(snapshot.data.length);

                List<SongItem> foundNotes = [];

                for (int i = 0; i < snapshot.data.length; i++) {
                  foundNotes.add(snapshot.data[i]);
                }
                // 중복 된 것을 제거하는 방법.
                foundNotes = [
                  ...{...foundNotes}
                ];

                if (foundNotes.isEmpty) {
                  return const Center(
                    child: Text(
                      'No note found, please try again',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: foundNotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    final SongItem note = foundNotes[index];

                    return Card(
                      child: ListTile(
                        onTap: () async {
                          final modified = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AddEditPage(
                                  isNew: false,
                                  songItem: foundNotes[index],
                                );
                              },
                            ),
                          );
                          if (modified == true) {
                            setState(() {
                              // _notes = context
                              //     .read<DataList>()
                              //     .searchNotes(widget.userId!, searchTerm!);
                            });
                          }
                        },
                        title: Text(
                          note.songName,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          note.songCreateTime,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
