import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uiwithcomponent/src/common_widgets/comman_appbar.dart';

class AllInputField extends ConsumerStatefulWidget {
  const AllInputField({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllInputFieldState();
}

class _AllInputFieldState extends ConsumerState<AllInputField> {
  TextEditingController textController = TextEditingController();
  RegExp digitValidator = RegExp("[0-9]+");
  bool isNumber = true;

  void setValidator(valid) {
    setState(() {
      isNumber = valid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("All Text input field"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueAccent,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Gap(8.h),
                TextField(
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueAccent,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Gap(8.h),
                const TextField(
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      hintText: "Enter your name"),
                ),
                Gap(8.h),
                const TextField(
                  maxLines: 5,
                ),
                Gap(8.h),
                TextFormField(
                  initialValue: "Initial Text",
                ),
                Gap(8.h),
                const TextField(
                  keyboardType: TextInputType.number,
                ),
                Gap(8.h),
                const TextField(
                  obscureText: true,
                  obscuringCharacter: "*",
                ),
                Gap(8.h),
                const TextField(
                  maxLength: 2,
                ),
                Gap(8.h),
                TextField(
                  controller: textController,
                  onChanged: (inputValue) {
                    if (inputValue.isEmpty ||
                        digitValidator.hasMatch(inputValue)) {
                      setValidator(true);
                    } else {
                      setValidator(false);
                    }
                  },
                  decoration: InputDecoration(
                      errorText: isNumber ? null : "Please enter a number",
                      errorStyle: const TextStyle(color: Colors.red),
                      focusedErrorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                ),
                Gap(8.h),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FormKeyExample(),
                          ));
                    },
                    child: const Text("Form Key Example"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormKeyExample extends ConsumerStatefulWidget {
  const FormKeyExample({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FormKeyExampleState();
}

class _FormKeyExampleState extends ConsumerState<FormKeyExample> {
  final _numberForm = GlobalKey<FormState>();
  final RegExp _digitRegex = RegExp("[0-9]+");
  bool isValidForm = false;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Form key"),
        shadowColor: Colors.green,
        elevation: 10,
      ),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Form(
            key: _numberForm,
            child: Column(
              children: [
                TextFormField(
                  validator: (inputValue) {
                    if (inputValue!.isEmpty ||
                        !_digitRegex.hasMatch(inputValue)) {
                      return "Please enter number";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  validator: (inputValue) {
                    if (inputValue!.isEmpty) {
                      return "Please Fill before";
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_numberForm.currentState!.validate()) {
                        setState(() {
                          isValidForm = true;
                        });
                      } else {
                        setState(() {
                          isValidForm = false;
                        });
                      }
                    },
                    child: const Text("Check Number")),
                Text(isValidForm ? "Nice" : "Please Fix error and Submit ")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
