import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:yt_music/scoped-models/main.dart';
import 'package:yt_music/models/video.dart';
import 'package:yt_music/screens/player.dart';

class MainScreen extends StatefulWidget {
  final MainModel model;

  MainScreen(this.model);

  @override
  State<StatefulWidget> createState() {
    return _MainScreen();
  }
}

class _MainScreen extends State<MainScreen> {
  final String link = 'https://www.googleapis.com/youtube/v3/search?part=snippet&q=Alan+Walker+Alon&type=video&videoCaption=closedCaption&key=AIzaSyDC6OJjs_aWZmWli8f7_QBTL7F2VIYVR3E';

  Widget _appBarTitle = Text('yt music');
  Icon _appBarActionIcon = Icon(Icons.search);
  final TextEditingController _searchTextController = TextEditingController();
  bool _IsSearching = false;

  String id = "sSQDyg0GK3A";

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _searchTextController.addListener(_search);
  }

  // _search() {
  //   // print("Second text field: ${_searchTextController.text}");
  // }

  Widget _buildVideoCard(Video video, int index) {
    return Card(
      color: Colors.black,
      child: ListTile(
        leading: Image.network(video.defaultThumbnailUrl),
        title: Text(video.title),
        subtitle: Text(video.channelTitle),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlayerScreen(video),
            )
          );
        },
      ),
    );
  }

  Widget _buildVideoList(List<Video> video) {
    Widget content;
    if (video.length > 0) {
      content = ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) =>
          _buildVideoCard(video[index], index),
        itemCount: video.length,
      );
    } else {
      content = Container();
    }
    return content;
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: _appBarTitle,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: IconButton(
            icon: _appBarActionIcon,
            onPressed: () {
              setState(() {
                if (this._appBarActionIcon.icon == Icons.search) {
                  this._appBarActionIcon = Icon(Icons.close);
                  this._appBarTitle = TextField(
                    controller: _searchTextController,
                    decoration: InputDecoration(
                      prefixIcon: new Icon(Icons.search),
                      hintText: 'Search...',
                    ),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          )
        )
      ],
    );
  }

  Widget _buildSearchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        OutlineButton(
          onPressed: () {
            widget.model.getData(_searchTextController.text);
          },
          child: Text('Search'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          ),
          borderSide: BorderSide(color: Colors.white),
        )
      ],
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this._appBarActionIcon = Icon(Icons.search);
      this._appBarTitle = Text("Search Sample");
      _IsSearching = false;
      // _searchQuery.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildSearchButton(),
            Flexible(
              child: ScopedModelDescendant<MainModel>(
                builder: (BuildContext context, Widget child, MainModel model) {
                  return _buildVideoList(model.allVideos);
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
