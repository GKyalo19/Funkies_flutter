import 'package:flutter/material.dart';
import 'package:funkies_flutter/controllers/LikesController.dart';
import 'package:funkies_flutter/models/event.dart';
import 'package:funkies_flutter/pages/event_page.dart';
import 'package:funkies_flutter/widgets/extras_menu.dart';
import 'package:funkies_flutter/widgets/search_bar.dart';
import 'package:share_plus/share_plus.dart';

class LikedEvents extends StatefulWidget {
  const LikedEvents({super.key});

  @override
  State<LikedEvents> createState() => _LikedEventsState();
}

class _LikedEventsState extends State<LikedEvents> {
  late Future<List<Event>> _likedEvents;

  @override
  void initState() {
    super.initState();
    _likedEvents = getLikedEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        shadowColor: const Color.fromARGB(176, 0, 0, 0),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExtrasMenu(),
              SizedBox(width: 270, child: SearchBarWidget()),
              Icon(Icons.notifications),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/app_background.png"),
              fit: BoxFit.cover,
              repeat: ImageRepeat.noRepeat
            )
          ),
        child: FutureBuilder(
          future: _likedEvents,
          builder: (context, snapshot) {
            print("=====>>>>> Snapshot --- ${snapshot.data}");
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No events found"));
            } else {
              final likedEvents = snapshot.data;
              print("=====>>>>> Liked Events - ${snapshot.data}");
              return SizedBox(
                child: ListView.builder(
                  itemCount: likedEvents!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EventPage(event: likedEvents[index])));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 5),
                              width: 350,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/Dancers3.png"),
                                  fit: BoxFit.cover,
                                  repeat: ImageRepeat.noRepeat,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  likedEvents[index].name!,
                                  textAlign: TextAlign.left,
                                ),
                                Expanded(child: Text(" ")),
                                Row(
                                  children: <Widget>[
                                    Builder(
                                      builder: (context) {
                                        return IconButton(
                                          onPressed: () async {
                                            final box =
                                                context.findRenderObject()
                                                    as RenderBox?;
                      
                                            if (box != null) {
                                              final result = await SharePlus
                                                  .instance
                                                  .share(
                                                    ShareParams(
                                                      text:
                                                          snapshot
                                                              .data![index]
                                                              .name,
                                                      subject:
                                                          snapshot
                                                              .data![index]
                                                              .description,
                                                      sharePositionOrigin:
                                                          box.localToGlobal(
                                                            Offset.zero,
                                                          ) &
                                                          box.size,
                                                    ),
                                                  );
                                              if (result.status ==
                                                  ShareResultStatus.success) {
                                                print(
                                                  "=====>>>>> Content Shared successfully!",
                                                );
                                              } else if (result.status ==
                                                  ShareResultStatus.dismissed) {
                                                print(
                                                  " =======>>>> Share action was dismissed",
                                                );
                                              } else {
                                                print(
                                                  "======>>>>> Sharing failed or is unavailable",
                                                );
                                              }
                                            } else {
                                              print(
                                                "=====>>>>> Unable to retrieve render box for positioning",
                                              );
                                            }
                                          },
                                          icon: Icon(Icons.share),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        final wasLiked =
                                            likedEvents[index].isLiked ?? false;
                      
                                        setState(() {
                                          likedEvents[index].isLiked = !wasLiked;
                                        });
                      
                                        try {
                                          if (wasLiked) {
                                            await unLikeEvent(likedEvents[index]);
                                            setState(() {
                                              likedEvents.removeAt(index);
                                            });
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text("Unliked event"),
                                              ),
                                            );
                                          } else {
                                            await likeEvent(likedEvents[index]);
                      
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text("Event liked"),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          setState(() {
                                            likedEvents[index].isLiked = wasLiked;
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(content: Text("Error: $e")),
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        likedEvents[index].isLiked == true
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                      
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    likedEvents[index].venue!,
                                    textAlign: TextAlign.left,
                                  ),
                                  Expanded(child: Text("")),
                                  Text(
                                    likedEvents[index].startDate.toString(),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
