import 'package:flutter/material.dart';
import 'package:funkies_flutter/models/event.dart';
import 'package:funkies_flutter/widgets/map_snippet.dart';
import 'package:funkies_flutter/widgets/text.dart';
import 'package:funkies_flutter/utility/payment.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.event});

  final Event? event;

  @override
  State<EventPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      child: Scaffold(
        appBar: AppBar(actions: <Widget>[

          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 5),
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(widget.event!.posterUrl ?? ''),
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                    onError: (exception, stackTrace) {
                      AssetImage("assets/images/Dancers3.png");
                    },
                  ),
                ),
              ),
              TextWidget(text: widget.event!.name!, textVariant: "boldTitle"),

              TextWidget(
                text: "${widget.event!.startDate} - ${widget.event!.endDate}",
                textVariant: "light",
              ),
              SizedBox(height: 20),

              if (widget.event!.venue != null)
                Column(
                  children: <Widget>[
                    TextWidget(text: "Event Venue", textVariant: "boldTitle"),
                    TextWidget(
                      text: widget.event!.venue!,
                      textVariant: "normal",
                    ),
                    buildMapSnippet(widget.event!.venue!),
                  ],
                ),

              if (widget.event!.link != null)
                Column(
                  children: <Widget>[
                    TextWidget(text: "Event Link", textVariant: "boldTitle"),
                    TextWidget(
                      text: widget.event!.link!,
                      textVariant: "normal",
                    ),
                  ],
                ),

              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(255, 151, 109, 54),
                ),
                child: Column(
                  children: <Widget>[
                    TextWidget(
                      text: "Overview",
                      textVariant: "boldTitle",
                      textAlign: TextAlign.left,
                    ),
                    TextWidget(
                      text: widget.event!.description!,
                      textVariant: "normal",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  TextWidget(
                    text: widget.event!.registration_fee.toString(),
                    textVariant: "light",
                  ),
                  TextWidget(
                    text:
                        widget.event!.venue != null
                            ? widget.event!.venue!
                            : widget.event!.participation_mode!,
                    textVariant: "normal",
                  ),
                ],
              ),
              Expanded(child: Text(" ")),
              ElevatedButton(
                onPressed: () {
                  paymentDialog(
                    context,
                    widget.event!.id!,
                    "Payment of registration fee of ${widget.event!.currency} ${widget.event!.registration_fee} for the event ${widget.event!.name}",
                  );
                },
                
                child: TextWidget(text: "Register", textVariant: "normal"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
