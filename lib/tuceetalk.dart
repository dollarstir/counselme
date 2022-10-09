      // import 'package:cached_network_image/cached_network_image.dart';
      import 'package:flutter/material.dart';
      import 'package:icounselgh/models/channel_info.dart';
      import 'package:icounselgh/models/viideos_list.dart';
      import 'package:icounselgh/screens/video_player_screen.dart';
      import 'package:icounselgh/utils/services.dart';
      import 'package:google_fonts/google_fonts.dart';

      class Ttalk extends StatefulWidget {
        @override
        _HomeScreenState createState() => _HomeScreenState();
      }

      class _HomeScreenState extends State<Ttalk> {
        //
        ChannelInfo _channelInfo;
        VideosList _videosList;
        Item _item;
        bool _loading;
        String _playListId;
        String _nextPageToken;
        ScrollController _scrollController;

        @override
        void initState() {
          super.initState();
          _loading = true;
          _nextPageToken = '';
          _scrollController = ScrollController();
          _videosList = VideosList();
          _videosList.videos = List();
          _getChannelInfo();
        }

        _getChannelInfo() async {
          _channelInfo = await Services.getChannelInfo();
          _item = _channelInfo.items[0];
          _playListId = _item.contentDetails.relatedPlaylists.uploads;
          print('_playListId $_playListId');
          await _loadVideos();
          setState(() {
            _loading = false;
          });
        }

        _loadVideos() async {
          VideosList tempVideosList = await Services.getVideosList(
            playListId: _playListId,
            pageToken: _nextPageToken,
          );
          _nextPageToken = tempVideosList.nextPageToken;
          _videosList.videos.addAll(tempVideosList.videos);
          print('videos: ${_videosList.videos.length}');
          print('_nextPageToken $_nextPageToken');
          setState(() {});
        }

        @override
        Widget build(BuildContext context) {
          double screenwidth = MediaQuery.of(context).size.width;
          double screenheight = MediaQuery.of(context).size.height;
          return Scaffold(
            appBar:
                //  AppBar(
                //   title: Text(_loading ? 'Loading...' : 'YouTube'),
                // ),

                PreferredSize(
              preferredSize: Size.fromHeight(screenheight * 0.1),
              child: AppBar(
                // height: 80,
                elevation: 0,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.vertical(
                //     bottom: Radius.circular(30),
                //   ),
                // ),

                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'TUCEE',
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(
                      ' Talk',
                      style: GoogleFonts.montserrat(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffaab3b)),
                    ),
                    // Text(
                    //   'This service helps to have direct counselling sessions with our counsellors at any time either via direct call, chat or SMS. You can also book a session at your convenience..',
                    //   style: GoogleFonts.montserrat(
                    //       fontSize: 10,
                    //       fontWeight: FontWeight.w400,
                    //       color: Colors.white),
                    // ),
                  ],
                ),
                // bottom: PreferredSize(
                //   child: Container(
                //     // color: Colors.blue,
                //     padding: EdgeInsets.only(top:20, right: 20,left:20),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           'The iDiscover-me services use a well-designed,validated and reliable Personality Psychometric Test to help you idenetify your interest, ability and personality type. The result will help you to make informed decision about academic programme, relationship, marriage, career and more.',
                //           style: GoogleFonts.montserrat(
                //               fontSize: 12,
                //               fontWeight: FontWeight.w400,
                //               color: Colors.black),
                //         ),
                //         Text(
                //           'Discover your true self now',
                //           style: GoogleFonts.montserrat(
                //             fontSize: 12,
                //             fontWeight: FontWeight.bold,
                //             color: Color(0xfffaab3b),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                //   preferredSize: Size.fromHeight(10),
                // ),
                backgroundColor: Color(0xfffff),
                centerTitle: true,
              ),
            ),
            body: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // _buildInfoView(),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        //  color: Colors.blue,
                      ),
                      width: screenwidth,
                      height: screenheight * 0.41,
                      child: Container(
                        // color: Colors.blue,
                        padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                             Container(child:Image(image:  AssetImage('assets/images/ttalk.png'),width: screenwidth * 0.3,)),
                             SizedBox(height: 5),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                'TUCEE Talk services have put together influential videos from experts and seasoned speakers in the areas of counselling, education, health, psycho-spiritual content and more.',
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Text(
                                'This service inspires and empowers you .',
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.montserrat(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xfffaab3b),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                    image: AssetImage('assets/images/circles.png'),
                    fit: BoxFit.fill,
                  ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: Color(0xfffaab3b),
                      ),
                      child: NotificationListener<ScrollEndNotification>(
                        onNotification: (ScrollNotification notification) {
                          if (_videosList.videos.length >=
                              int.parse(_item.statistics.videoCount)) {
                            return true;
                          }
                          if (notification.metrics.pixels ==
                              notification.metrics.maxScrollExtent) {
                            _loadVideos();
                          }
                          return true;
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: _videosList.videos.length,
                          itemBuilder: (context, index) {
                            VideoItem videoItem = _videosList.videos[index];
                            return InkWell(
                              onTap: () async {
                                // print(videoItem);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return VideoPlayerScreen(
                                    videoItem: videoItem,
                                  );
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            videoItem.video.thumbnails
                                                .thumbnailsDefault.url,
                                          ),
                                        ),
                                        shape: BoxShape.rectangle,
                                        // shape:
                                      ),
                                      // child:
                                      // // CachedNetworkImage(
                                      // //   imageUrl: videoItem
                                      // //       .video.thumbnails.thumbnailsDefault.url,
                                      // // ),
                                      // Image.network(videoItem
                                      //       .video.thumbnails.thumbnailsDefault.url,),
                                    ),
                                    SizedBox(width: 15),
                                    Flexible(child: Text(videoItem.video.title,style:GoogleFonts.montserrat(
                                // fontSize: 13,
                                fontWeight: FontWeight.bold,
                                // color: Color(0xfffaab3b),
                              ),)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        _buildInfoView() {
          return _loading
              ? CircularProgressIndicator()
              : Container(
                  padding: EdgeInsets.all(20.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              _item.snippet.thumbnails.medium.url,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              _item.snippet.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(_item.statistics.videoCount),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ),
                );
        }
      }
