import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CommentWidget();
  }
}

class _CommentWidget extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final titleController = new TextEditingController();
    final commentController = new TextEditingController();

    @override
    void dispose() {
      titleController.dispose();
      commentController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajout de commentaire"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
            key: formkey,
            child: ListView(
              children: [
                TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        labelText: "Titre",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " veuiller remplir  le champ";
                      }
                      return null;
                    }),
                const SizedBox(height: 8.0),
                TextFormField(
                    controller: commentController,
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 6,
                    decoration: const InputDecoration(
                        labelText: "Commentaire",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return " veuiller remplir  le champ";
                      }
                      return null;
                    }),
                const SizedBox(height: 8.0),
                Center(
                  child: ElevatedButton(
                    child: Text("Enregistrer"),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {}
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
