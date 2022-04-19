import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newzzapp/db/notes_database.dart';
import 'package:newzzapp/model/note.dart';
import 'package:newzzapp/page/edit_note_page.dart';
import 'dart:convert';
import 'package:newzzapp/NewsView.dart';
import 'package:newzzapp/model.dart';
import 'package:http/http.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = true;
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  getNewsByQuery(String titlename, String countryname, String languagename, String arrange, String timeranges) async {
    String url = "";
    final today = DateTime.now();
    var dateval = today.subtract(const Duration(days: 29));
    if(timeranges == "Last30days"){ dateval = today.subtract(const Duration(days: 29)); }else
    if(timeranges == "Last15days"){ dateval = today.subtract(const Duration(days: 15)); }else
    if(timeranges == "Last10days"){ dateval = today.subtract(const Duration(days: 10)); }else
    if(timeranges == "Last1Week"){ dateval = today.subtract(const Duration(days: 7)); }else
    if(timeranges == "Yesterday"){ dateval = today.subtract(const Duration(days: 1)); }else {//do nothing default
    }

    if(countryname != '')
    {
      url  ="https://newsapi.org/v2/top-headlines?q=$titlename&from=$dateval&to=$today&language=$languagename&country=$countryname&sortBy=$arrange&apiKey=91f0251d914547858c9341508e6c019f";
    }else{
      url ="https://newsapi.org/v2/everything?q=$titlename&from=$dateval&to=$today&language=$languagename&sortBy=$arrange&apiKey=91f0251d914547858c9341508e6c019f";
    }

    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelList.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });

      });
    });

  }
  @override
  void initState() {
    super.initState();
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await NotesDatabase.instance.readNote(widget.noteId);

    getNewsByQuery(note.title, note.country, note.language, note.arrange, note.timeranges);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("NEWZZAPP"),
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),))
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 8),
                    Divider(),
                    Container(
                      margin : EdgeInsets.fromLTRB(15, 15, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 12,),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            //child: Text(note.title, style: TextStyle( fontSize: 39),),
                          ),
                        ],
                      ),
                    ),
                    isLoading ? Container( height: MediaQuery.of(context).size.height -500 , child: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),),),) :
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newsModelList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: InkWell(
                              onTap: () {Navigator.push(context , MaterialPageRoute(builder: (context)=>NewsView(newsModelList[index].newsUrl)));},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 1.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(newsModelList[index].newsImg ,fit: BoxFit.fitHeight, height: 230,width: double.infinity, )),

                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(

                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black12.withOpacity(0),
                                                      Colors.black
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter
                                                )
                                            ),
                                            padding: EdgeInsets.fromLTRB(15, 15, 10, 8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newsModelList[index].newsHead,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                Text(newsModelList[index].newsDes.length > 50 ? "${newsModelList[index].newsDes.substring(0,55)}...." : newsModelList[index].newsDes , style: TextStyle(color: Colors.white , fontSize: 12)
                                                  ,)
                                              ],
                                            )))
                                  ],
                                )),
                          ),
                          );
                        }),
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
