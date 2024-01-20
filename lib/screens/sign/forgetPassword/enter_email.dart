import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/screens/sign/signing_screen.dart';

class EnterEmailScreen extends StatefulWidget {
  static const String route='EnterEmailScreen/';
  const EnterEmailScreen({Key? key}) : super(key: key);

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final GlobalKey<FormState> _myKey=GlobalKey<FormState>();
  String?email;
  bool codeSent=false;
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Material(
          color: Colors.white,
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Material(
              color: Colors.white,
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: height*.3,
                width: width*.7,
                child: Column(
                  children: [
                    Text('${getLang(context, "enter")} ${getLang(context, "email")}'),
                    Form(
                      key: _myKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height*.01,horizontal:height*.03 ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: height*.05,),
                              SigningTextField(
                                label: '${getLang(context, "email")}',
                                vFuntion: (v){if(v!.isEmpty){return'${getLang(context, "enter")} ${getLang(context, "email")}';}return null;},
                                sFuntion: (s){setState(() {
                                  email=s;
                                });
return null;},
                                input: TextInputType.emailAddress,
                                icon: const Icon(Icons.email_outlined),

                              ),//email
                              SizedBox(height: height*.025),



                            ],


                          ),
                        ),
                      ),

                    ),
                    InkWell(
                      onTap: ()async{
                        if(codeSent){
                          MyFlush().showDoneFlush(context: context, text:getLang(context, "code sent message"));
                          return;}

                        if(_myKey.currentState!.validate()){
                          _myKey.currentState!.save();
                          try{

                            await FirebaseAuth.instance.sendPasswordResetEmail(email: email!,);

                            setState(() {codeSent=true;});
                          }on FirebaseAuthException catch(e){
                            print(e.message);
                          }


                          MyFlush().showDoneFlush(context: context, text:getLang(context, "code sent message"));



                        }
                        else{

                          return;}




                      },
                      child: Material(
                        color: Colors.white,
                        elevation: 3,


                        type: MaterialType.circle,
                        child: Container(
                          height: height*.08,width: height*.08,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,

                          ),
                          child: Icon(codeSent?Icons.done:Icons.arrow_forward_ios,size: height*.04,color:codeSent?Colors.green: Theme.of(context).appBarTheme.backgroundColor),
                        ),
                      ),
                    )
                  ],
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
