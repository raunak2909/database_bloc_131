import 'package:database_bloc_131/bloc/note_bloc.dart';
import 'package:database_bloc_131/screens/add_note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(FetchNoteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Notes'),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (_, state) {
          if (state is NoteLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NoteErrorState) {
            return Center(
              child: Text(state.errorMsg),
            );
          } else if (state is NoteLoadedState) {
            return state.arrNotes.isNotEmpty
                ? ListView.builder(
                    itemCount: state.arrNotes.length,
                    itemBuilder: (_, index) {
                      var thisNote = state.arrNotes[index];
                      return ListTile(
                        title: Text(thisNote.title),
                        subtitle: Text(thisNote.desc),
                      );
                    })
                : const Center(
                    child: Text('No Notes Yet!\nAdd your First Note today..'));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNotePage(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
