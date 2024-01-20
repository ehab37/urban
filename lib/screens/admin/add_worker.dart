import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cart.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/worker.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/providers/lang_provider.dart';

class AddWorkerScreen extends StatefulWidget {
  static const String route = 'AddWorkerScreen/';

  const AddWorkerScreen({Key? key}) : super(key: key);

  @override
  State<AddWorkerScreen> createState() => _AddWorkerScreenState();
}

class _AddWorkerScreenState extends State<AddWorkerScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    width = width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('add worker'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _myKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: height * .01, horizontal: height * .03),
            child: Column(
              children: [
                SizedBox(height: height * .02),
                Center(child: bigImage(height: height)),
                SizedBox(height: height * .02),
                AddWorkerTextField(
                  label: 'Full-name',
                  vFuntion: (v) {
                    if (v!.isEmpty) {
                      return 'enter your name';
                    }
                    return null;
                  },
                  sFuntion: (s) {
                    setState(() {
                      name = s;
                    });
                    return null;
                  },
                  input: TextInputType.name,
                  icon: const Icon(Icons.person_sharp),
                ), //name
                SizedBox(
                  height: height * .01,
                ),

                SizedBox(height: height * .01),
                AddWorkerTextField(
                  label: 'phone number',
                  vFuntion: (v) {
                    if (v!.isEmpty) {
                      return 'enter your phone';
                    }
                    return null;
                  },
                  sFuntion: (s) {
                    setState(() {
                      phone = s;
                    });
                    return null;
                  },
                  input: TextInputType.phone,
                  icon: const Icon(Icons.phone),
                ), //phone
                SizedBox(height: height * .01),
                ChangeNotifierProvider(
                  create: (_) => LangProvider(),
                  child: Consumer<LangProvider>(
                      builder: (context, LangProvider lanNoty, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Material(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            alignment: Alignment.center,
                            underline: const SizedBox(),
                            dropdownColor:
                                Theme.of(context).appBarTheme.backgroundColor,
                            items: Governorate()
                                .getGovernorates()
                                .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        lanNoty.isEn ? e.en! : e.ar!,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ))
                                .toList(),
                            value: myGovernorateId,
                            onChanged: (Object? value) {
                              City myCity1 = City().getCity(
                                  key: cityGovernId, value: value.toString());

                              setState(() {
                                myGovernorateId = value.toString();
                                myCityId = myCity1.id!;
                              });
                            },
                          ),
                        ),
                        Material(
                          color: Theme.of(context).appBarTheme.backgroundColor,
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: DropdownButton(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            alignment: Alignment.center,
                            underline: const SizedBox(),
                            dropdownColor:
                                Theme.of(context).appBarTheme.backgroundColor,
                            items: City()
                                .getCities(
                                    key: cityGovernId, value: myGovernorateId)
                                .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        lanNoty.isEn ? e.en! : e.ar!,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ))
                                .toList(),
                            value: myCityId,
                            onChanged: (Object? value) {
                              setState(() {
                                myCityId = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                ),

                SizedBox(
                  height: height * .02,
                ),
                Material(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  elevation: 5,
                  borderRadius: BorderRadius.circular(10),
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    alignment: Alignment.center,
                    underline: const SizedBox(),
                    dropdownColor:
                        Theme.of(context).appBarTheme.backgroundColor,
                    items: workersCategories
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                '${getLang(context, e)}',
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ))
                        .toList(),
                    value: myWorkerCategory,
                    onChanged: (Object? value) {
                      setState(() {
                        myWorkerCategory = value.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                _saveButton(height: height, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? name;
  String? phone;
  String myGovernorateId = '1';
  String myCityId = '1';
  String? myWorkerCategory = workersCategories[0];
  File? imageFile;
  XFile? picked;
  final GlobalKey<FormState> _myKey = GlobalKey<FormState>();

  Widget bigImage({required double height}) {
    if (imageFile == null) {
      return Container(
          height: height * .2,
          width: height * .2,
          decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              //borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).canvasColor.withOpacity(.5),
                    blurRadius: 5,
                    spreadRadius: .1)
              ]),
          alignment: Alignment.center,
          child: EbottonI(
            icon: Icon(
              Icons.photo,
              color: Theme.of(context).iconTheme.color,
              size: height * .02,
            ),
            elevation: 3,
            shadowcolor: Theme.of(context).canvasColor.withOpacity(.5),
            backgroundcolor: Colors.white,
            alignmentt: Alignment.center,
            borderRadius: 10,
            padding: height * .015,
            onpressed: () async {
              var fire = Provider.of<FireProvider>(context, listen: false);

              var myCroppedImage = await fire.addImageAndCrop();
              setState(() {
                imageFile = myCroppedImage;
                picked = fire.pickedCrop;
              });
            },
            child: Text('إختر صوره',
                style: TextStyle(color: Colors.black, fontSize: height * .013)),
          )
          //Image(image: AssetImage('assets/images/cover.png'),width: 100,height: 100,),

          );
    } else {
      return InkWell(
        onTap: () async {
          var fire = Provider.of<FireProvider>(context, listen: false);

          var myCroppedImage = await fire.addImageAndCrop();
          setState(() {
            imageFile = myCroppedImage;
            picked = fire.pickedCrop;
          });
        },
        child: Stack(
          children: [
            Material(
              //  borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              type: MaterialType.circle,
              elevation: 10,
              child: Container(
                height: height * .2,
                width: height * .2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: FileImage(
                          imageFile!,
                        ),
                        fit: BoxFit.fill)),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: height * .08,
                height: height * .03,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      // topRight:  Radius.circular(10),
                    )),
                child: Text('تغيير الصوره',
                    style:
                        TextStyle(color: Colors.white, fontSize: height * .014),
                    textAlign: TextAlign.center),
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _saveButton({required BuildContext context, required double height}) {
    return InkWell(
        onTap: () async {
          _save(
            context: context,
          );
        },
        child: Container(
          width: height * .25,
          height: height * .08,
          decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: Theme.of(context).canvasColor, width: .3),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).canvasColor,
                    blurRadius: 5,
                    spreadRadius: .1)
              ]),
          alignment: Alignment.center,
          child: Text('${getLang(context, "addWorker")}',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: height * .018),
              textDirection: TextDirection.rtl),
        ));
  }

  _save({required BuildContext context}) async {
    var fire = Provider.of<FireProvider>(context, listen: false);

    if (_myKey.currentState!.validate()) {
      MyIndicator().loading(context);
      _myKey.currentState!.save();
      debugPrint('save done');

      if (picked == null) {
        Navigator.pop(context);
        MyFlush().showFlush(context: context, text: 'select image');
        return;
      } else {
        if (!await fire.uploadImageCrop(
            imageFileCrop: imageFile!, pickedCrop: picked!)) {
          if (context.mounted) {
            Navigator.pop(context);
            MyFlush().showFlush(context: context, text: 'wrong try again');
          }
          return;
        } else {
          String id = Random().nextInt(100000).toString();

          Worker worker = Worker(
            id: id,
            name: name,
            phone: phone,
            category: myWorkerCategory,
            cityId: myCityId,
            status: available,
            imageUrl: fire.imageUrlCrop,
            imageLoc: fire.photoLocCrop,
          );

          await Worker().addWorker(worker: worker);
          await fire.clearImages();
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.pop(context);
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsScreen(category: widget.category,section: widget.section,company: widget.company,kind: widget.kind),));
            MyFlush().showUploadingDoneFlush(context: context);
          }
        }
      }
    } else {
      return;
    }
  }
}

class AddWorkerTextField extends StatefulWidget {
  final TextEditingController? myController;

  final String label;
  final Icon icon;
  final bool obsecure;
  final TextInputType input;

  final String? Function(String?) vFuntion;
  final String? Function(String?) sFuntion;

  //Function ontapFunction;

  const AddWorkerTextField({
    Key? key,
    required this.label,
    this.obsecure = false,
    required this.icon,
    required this.vFuntion,
    required this.sFuntion,
    this.myController,
    required this.input,
  }) : super(key: key);

  @override
  State<AddWorkerTextField> createState() => _AddWorkerTextFieldState();
}

class _AddWorkerTextFieldState extends State<AddWorkerTextField> {
  double borderWidth = 1;

  Color borderColor = Colors.black.withOpacity(.3);

  Color fillColor = Colors.white.withOpacity(.1);

  double borderRadus = 50;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadus),
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width;
      width = MediaQuery.of(context).size.height;
    }
    width = width;

    return TextFormField(
      style: TextStyle(color: Colors.black, fontSize: height * .019),
      decoration: InputDecoration(
          //fillColor: Theme.of(context).primaryColor,
          // counterStyle: TextStyle(color: Theme.of(context).canvasColor,fontSize: height*.015),
          //filled: true,
          isCollapsed: true,
          enabled: true,
          contentPadding: EdgeInsets.all(height * .015),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.label,
          labelStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: height * .015),
          prefixIcon: widget.icon,
          enabledBorder: outlineInputBorder,
          disabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          errorBorder: outlineInputBorder,
          focusedErrorBorder: outlineInputBorder),

      obscureText: widget.obsecure,
      textInputAction: TextInputAction.done,
      keyboardType: widget.input,
      enabled: true,
      minLines: 1,
      maxLines: 1,
      // maxLength: 20,
      // initialValue: 'bota',

      validator: widget.vFuntion,
      onSaved: widget.sFuntion,

      controller: widget.myController,
    );
  }
}
