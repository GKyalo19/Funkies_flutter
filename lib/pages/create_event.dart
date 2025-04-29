import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funkies_flutter/widgets/input.dart';
import 'package:funkies_flutter/widgets/text.dart';
import '../utility/drop_down_options.dart' as drop_down;
import 'package:intl/intl.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventVenueController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();
  final TextEditingController _eventCapacityController =
      TextEditingController();
  final TextEditingController _eventTeamSizeController =
      TextEditingController();
  final TextEditingController _eventSponsorsController =
      TextEditingController();
  final TextEditingController _eventFeeController = TextEditingController();

  String? _selectedPlatform;
  String? _selectedEventClass;
  String? _selectedLevel;
  String? _selectedNationalCategory;
  String? _selectedInternationalCategory;
  String? _selectedAcademicSubject;
  String? _selectedMode;
  String? _selectedCurrency;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Dancers3.png"),
          fit: BoxFit.cover,
          repeat: ImageRepeat.noRepeat,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextWidget(text: "Create Event", textVariant: "boldTitle"),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(122, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    ClipOval(
                      child: Image.network(
                        'https://i.pinimg.com/236x/53/ac/c8/53acc87fe128b75a2a87027f1b01da58.jpg',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    TextWidget(
                      text: "Event Host : Chris Brown",
                      textVariant: "normal",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormFieldWidget(
                      textController: _eventNameController,
                      hintText: "Name of event",
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 10),

                    TextFormFieldWidget(
                      textController: _eventVenueController,
                      hintText: "Event Venue",
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 10),

                    TextFormFieldWidget(
                      // maxLength: 100,
                      textController: _eventDescriptionController,
                      keyboardType: TextInputType.multiline,
                      hintText: "Description of event",
                    ),
                    SizedBox(height: 10),

                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: CupertinoButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder:
                                (BuildContext context) => Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 250,
                                    child: CupertinoDatePicker(
                                      backgroundColor: Colors.white,
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() {
                                          _selectedStartDate = newTime;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                          );
                        },
                        child: TextWidget(
                          text:
                              _selectedStartDate == null
                                  ? "Start date"
                                  : DateFormat(
                                    'EEEE, MMMM d, yyyy - h:mm a',
                                  ).format(_selectedStartDate!),
                          textVariant: "normal",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: CupertinoButton(
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder:
                                (BuildContext context) => Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 250,
                                    child: CupertinoDatePicker(
                                      backgroundColor: Colors.white,
                                      onDateTimeChanged: (DateTime newTime) {
                                        setState(() {
                                          _selectedEndDate = newTime;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                          );
                        },
                        child: TextWidget(
                          text:
                              _selectedEndDate == null
                                  ? "End date"
                                  : DateFormat(
                                    'EEEE, MMMM d, yyyy - h:mm a',
                                  ).format(_selectedEndDate!),
                          textVariant: "normal",
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    DropdownButtonFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Event platform",
                      ),
                      value: _selectedPlatform,
                      items:
                          drop_down.platform.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedPlatform = value.toString();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.toString().isEmpty) {
                          return "Please select the event platform";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    DropdownButtonFormFieldWidget(
                      hintText: "Event class",
                      value: _selectedEventClass,
                      items:
                          drop_down.eventClass.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedEventClass = value.toString();
                        });
                      },
                      validationText: "Please select the event class",
                    ),
                    SizedBox(height: 10),

                    DropdownButtonFormFieldWidget(
                      hintText: "Event level",
                      value: _selectedLevel,
                      items:
                          drop_down.level.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel = value.toString();
                        });
                      },
                      validationText: "Please select the event level",
                    ),
                    SizedBox(height: 10),

                    Column(
                      children: <Widget>[
                        _selectedLevel == "National"
                            ? DropdownButtonFormFieldWidget(
                              hintText: "Event category",
                              value: _selectedNationalCategory,
                              items:
                                  drop_down.nationalCategories.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedNationalCategory = value.toString();
                                });
                              },
                              validationText:
                                  "Please select the event category",
                            )
                            : DropdownButtonFormFieldWidget(
                              hintText: "Event category",
                              value: _selectedInternationalCategory,
                              items:
                                  drop_down.internationalCategories.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedInternationalCategory =
                                      value.toString();
                                });
                              },
                              validationText:
                                  "Please select the event category",
                            ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Column(
                      children: <Widget>[
                        if (_selectedNationalCategory == "Academic" && _selectedLevel == "National")
                          DropdownButtonFormFieldWidget(
                            hintText: "Event subject",
                            value: _selectedAcademicSubject,
                            items:
                                drop_down.academicSubjects.map((item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedAcademicSubject = value.toString();
                              });
                            },
                            validationText: "Please select the event subject",
                          ),
                      ],
                    ),
                    SizedBox(height: 10),

                    TextFormFieldWidget(
                      keyboardType: TextInputType.number,
                      textController: _eventCapacityController,
                      hintText: "Event Capacity",
                      inputFormat: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(height: 10),

                    DropdownButtonFormFieldWidget(
                      hintText: "Mode of Participation",
                      value: _selectedMode,
                      items:
                          drop_down.mode.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedMode = value.toString();
                        });
                      },
                      validationText: "required",
                    ),
                    SizedBox(height: 10),

                    TextFormFieldWidget(
                      keyboardType: TextInputType.number,
                      textController: _eventTeamSizeController,
                      hintText: "Members per team",
                      inputFormat: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(height: 10),

                    TextFormFieldWidget(
                      textController: _eventSponsorsController,
                      hintText:
                          "Event Sponsors (separate using commas if multiple)",
                      keyboardType: TextInputType.name,
                    ),
                    SizedBox(height: 10),

                    TextFormFieldWidget(
                      keyboardType: TextInputType.number,
                      textController: _eventFeeController,
                      hintText: "Registration Fee",
                      inputFormat: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    SizedBox(height: 10),

                    DropdownButtonFormFieldWidget(
                      hintText: "Currency",
                      value: _selectedCurrency,
                      items:
                          drop_down.currency.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCurrency = value.toString();
                        });
                      },
                      validationText: "*required",
                    ),
                    SizedBox(height: 30),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          maximumSize: Size(250, 50),
                          minimumSize: Size(150, 50),
                        ),
                        child: TextWidget(
                          text: "Create Event",
                          textVariant: "normalTitle",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
