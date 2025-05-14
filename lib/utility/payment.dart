import 'package:flutter/material.dart';
import 'package:funkies_flutter/controllers/MPesaController.dart';
import 'package:funkies_flutter/models/mpesa.dart';
import 'package:funkies_flutter/widgets/input.dart';
import 'package:funkies_flutter/widgets/text.dart';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumber = TextEditingController();
  bool isProcessing = false;

Future<void> paymentDialog(
  BuildContext context,
  int event_id,
  String transaction_desc,
) {


  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const TextWidget(
          text: "Lipa na MPesa",
          textVariant: "boldTitle",
        ),
        content: Center(
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                TextWidget(
                  text:
                      "Please enter your MPesa number in the format 254*********",
                  textVariant: "normal",
                ),
                TextFormFieldWidget(
                  keyboardType: TextInputType.phone,
                  textController: _phoneNumber,
                  obscureText: false,
                  hintText: "254*********",
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "* required";
                    }
                    final regex = RegExp(r'^(2547|2541)[0-9]{8}$');
                    if (!regex.hasMatch(value)) {
                      return "* number must be 12 digits and start with 254";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(child: Text(" ")),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Pay'),
            onPressed: () async {
              //Form validation
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              } else {
                return;
              }

              //New mpesa instance
              final mpesa = MPesa(
                phone: _phoneNumber.text,
                event_id: event_id,
                transaction_desc: transaction_desc,
              );

              //Snackbar to distract user from loading process
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.amber[900],
                  content: Text("Processing payment"),
                ),
              );

              //Run create event logic
              try {
                print("====>>>> Starting stk push ");
                final response = await initiateSTKPush(mpesa);

                print("====>>>>> Event data: $response");

                Navigator.of(context).pop();

                if (response['success']) {
                  if (response['alreadpaid'] == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.amber[900],
                        content: Text("Transcation completed successfully"),
                      ),
                    );
                  }
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.amber[900],
                    content: Text("Transcation completed successfully"),
                  ),
                );
              } catch (e) {
                print("=====>>>>>Failed to push stk because of this error: $e");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.amber[900],
                    content: Text("Failed to complete transaction"),
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
