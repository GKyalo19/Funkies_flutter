import 'package:flutter/material.dart';
import 'package:funkies_flutter/controllers/EventController.dart';
import 'package:funkies_flutter/controllers/LikesController.dart';
import 'package:funkies_flutter/models/event.dart';
import 'package:funkies_flutter/pages/event_page.dart';
import 'package:funkies_flutter/widgets/extras_menu.dart';
import 'package:funkies_flutter/widgets/search_bar.dart';
import 'package:share_plus/share_plus.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late Future<List<Event>> _events;

  @override
  void initState() {
    super.initState();
    _events = getEvents();
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
                  ExtrasMenu(
                    // anotherWidget: Tooltip(
                    //   margin: EdgeInsets.all(0),
                    //   padding: EdgeInsets.all(0),
                    //   message: "Switch birghtness mode",
                    //   child: IconButton(
                    //     isSelected: isDark,
                    //     onPressed: () {
                    //       setState(() {
                    //         isDark = !isDark;
                    //       });
                    //     },
                    //     icon: Icon(Icons.wb_sunny_outlined),
                    //     selectedIcon: Icon(Icons.brightness_2),
                    //   ),
                    // ),
                  ),
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
          future: _events,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No events found"));
            } else {
              final events = snapshot.data;
              return SizedBox(
                child: ListView.builder(
                  itemCount: events!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EventPage(event: events[index])));
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
                                  events[index].name!,
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
                                        final wasLiked = events[index].isLiked ?? false;
                                        setState(() {
                                          events[index].isLiked =
                                              !wasLiked;
                                        });
                      
                                        try {
                                          if (!wasLiked) {
                                            await likeEvent(events[index]);
                      
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text("Event liked"),
                                              ),
                                            );
                                          } else {
                                            await unLikeEvent(events[index]);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text("Unliked event"),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          setState(() {
                                            events[index].isLiked =
                                                wasLiked;
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(content: Text("Error: $e")),
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        events[index].isLiked!
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
                                    events[index].venue!,
                                    textAlign: TextAlign.left,
                                  ),
                                  Expanded(child: Text("")),
                                  Text(
                                    events[index].startDate.toString(),
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