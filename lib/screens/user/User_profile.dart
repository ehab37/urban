
// ignore_for_file: file_names, avoid_debugPrint



import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/MyUser.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/providers/authProvider.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/providers/lang_provider.dart';
import 'package:urban/screens/sign/signing_screen.dart';
import 'package:urban/screens/user/settings_screen.dart';

import '../../constants/constants.dart';
import 'User_Orders_screen.dart';
import 'carts_screen.dart';



class UserProfileScreen extends StatefulWidget {
  static const  String route='UserProfileScreen/';

  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {




  MyUser? userInfo;


  @override
  void initState() {
    super.initState();
    getUserInfo();


  }

  getUserInfo()async{
   await Provider.of<FireProvider>(context,listen: false).getMyUserInfo(context: context);

    setState(() {
      userInfo=Provider.of<FireProvider>(context,listen: false).myUserInfo;
    });

  }




  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return SafeArea(
      child: Scaffold(


        primary: true,
        appBar: AppBar(
          title: Text('${getLang(context, 'profile')}'),
            ),

        body:userInfo==null?myShimmer(context):Stack(
          children:
          [





            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: height*.05,),


                      Material(
                        type: MaterialType.circle,
                        color:  Colors.white,
                        elevation: 5,

                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child:userInfo!.photo!=null? Container(

                            height: height*.2,
                            width: height*.2,
                            decoration: BoxDecoration(
                               // border: Border.all(color: Theme.of(context).canvasColor,width: 2),
                                shape: BoxShape.circle,
                                image:  DecorationImage(image: CachedNetworkImageProvider(userInfo!.photo!),fit: BoxFit.fill)
                            ),
                          ):

                          Container(

                            height: height*.2,
                            width: height*.2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).appBarTheme.backgroundColor,
                                shape: BoxShape.circle,
                            ),
                            child: Text(
                              userInfo!.name![0].toUpperCase()

                              ,style: TextStyle(color: Colors.white,fontSize: height*.1),),
                          ),
                        ),
                      ),//photo
                      SizedBox(height: height*.025,),
                    Material(
                      elevation: 5,
                      color: Theme.of(context).primaryColor,
                      shadowColor: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Material(
                          elevation: 5,
                          color: Theme.of(context).primaryColor,
                          shadowColor: Colors.black,
                          borderRadius: BorderRadius.circular(20),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(height: height*.025,),
                                Text(

                                  '${userInfo!.name}'
                                  ,
                                  style:  TextStyle(
                                      fontSize:  height*.025,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).textTheme.titleMedium!.color),),//name
                                 SizedBox(height:  height*.015,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.phone,color: Theme.of(context).iconTheme.color,size:  height*.025),
                                    Text('${userInfo!.phone}  ',
                                      style:  TextStyle(
                                          color: Theme.of(context).textTheme.bodySmall!.color,
                                          fontSize:  height*.015),
                                    ),

                                  ],
                                ),//phone
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.alternate_email,color: Theme.of(context).iconTheme.color,size:  height*.025),
                                    Text('${userInfo!.email}  ',
                                      style:  TextStyle(
                                          color: Theme.of(context).textTheme.bodySmall!.color,
                                          fontSize:  height*.015),
                                    ),

                                  ],
                                ),//email
                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on_outlined,color: Theme.of(context).iconTheme.color,size:  height*.025),
                                    ChangeNotifierProvider(
                                      create: (_) =>LangProvider() ,
                                      child:  Consumer<LangProvider>(
                                          builder: (context,LangProvider lanNoty,child) {

                                            var city=  City().getCity(key: cityId, value: userInfo!.cityId!);
                                            return  Text('${
                                                lanNoty.isEn?city.en!:city.ar!




                                            }  ',
                                              style:  TextStyle(
                                                  color: Theme.of(context).textTheme.bodySmall!.color,
                                                  fontSize:  height*.015),
                                            ) ;
                                          }
                                      ),
                                    ),


                                  ],
                                ),//city
                              ],
                            ),
                          ),
                        ),
                      ),
                    )


                    ],
                  ),

                  SizedBox(height:  height*.02,),
                  Consumer<LangProvider>(
                    builder: (context,LangProvider lanNoty,child) {
                      return Material(
                        shadowColor: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              profileItem(
                                height: height,
                                text: getLang(context, "orders"),
                                icon: Icons.delivery_dining,
                                onTap: (){
                                  Navigator.pushNamed(context, UserOrdersScreen.route,);
                                }
                              ),

                              profileItem(
                                  height: height,
                                  text: getLang(context, "cart"),
                                  icon: Icons.shopping_cart,
                                  onTap: (){
                                    Navigator.pushNamed(context, CartsScreen.route,);
                                  }
                              ),



                              profileItem(
                                  height: height,
                                  text: getLang(context, "language"),
                                  icon: Icons.flag_sharp,
                                  onTap: ()async{
                                    showDialog(context: context, builder: (BuildContext context)=>
                                    Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child:
                                      Container(

                                        height: height*.2,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Theme.of(context).appBarTheme.backgroundColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              const Center(child: Text('Select Language',style: TextStyle(color: Colors.white)),),
                                              const Divider(color: Colors.white,height: 25,thickness: .3),

                                              InkWell(
                                                onTap: ()async{
                                                  lanNoty.isEn=true;
                                                  Navigator.pop(context);
                                                },
                                                child: Material(
                                                  color:lanNoty.isEn? Theme.of(context).appBarTheme.backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
                                                  borderRadius: BorderRadius.circular(10),
                                                  elevation: 3,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(lanNoty.isEn?Icons.radio_button_checked:Icons.radio_button_off,color: lanNoty.isEn?Colors.white:Colors.black),
                                                        const SizedBox(width: 10),
                                                        const Text('English',style: TextStyle(color: Colors.white))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: height*.01),
                                              InkWell(
                                                onTap: ()async{
                                                  lanNoty.isEn=false;
                                                  Navigator.pop(context);
                                                },
                                                child: Material(
                                                  color: lanNoty.isEn?Theme.of(context).appBarTheme.backgroundColor:Theme.of(context).appBarTheme.backgroundColor,
                                                  borderRadius: BorderRadius.circular(10),
                                                  elevation: 3,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(lanNoty.isEn?Icons.radio_button_off:Icons.radio_button_checked,color: lanNoty.isEn?Colors.black:Colors.white),
                                                        const SizedBox(width: 10),
                                                        const Text('اللغه العربيه',style: TextStyle(color: Colors.white))
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],

                                          ),
                                        ),
                                      )

                                    )
                                    );

                                  }
                              ),



                              profileItem(
                                  height: height,
                                  text: getLang(context, "settings"),
                                  icon: Icons.settings,
                                  onTap: ()async{

                                    await Navigator.pushNamed(context, SettingScreen.route).then((value) => getUserInfo());

                                  }
                              ),


                              profileItem(
                                  height: height,
                                  text: getLang(context, "log out"),
                                  icon: Icons.logout,
                                  onTap: ()async{
                                    var auth=Provider.of<AuthProvider>(context,listen: false);
                                    var fire=Provider.of<FireProvider>(context,listen: false);
                                    await auth.logout();
                                    fire.myUserInfo=null;
                                    fire.myUser=null;
                                    fire.myId=null;
                                    Navigator.pushNamedAndRemoveUntil(context, SigningScreen.route, (route) => false);

                                  }
                              ),





                            ],
                          ),
                        ),
                      );
                    }
                  ),






                ],
              ),
            ),
            Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()










          ],
        )





      ),
    );
  }

  TextStyle   nameStyle=const TextStyle(fontSize: 16,fontWeight: FontWeight.w300,color: Colors.white);




 profileItem({required double height,required dynamic icon,required String text,required VoidCallback onTap}){
  return
    Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        elevation: 5,
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap:onTap,
          child: SizedBox(
            height: height*.06,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Text(text,style:TextStyle(fontSize: height*.02,fontWeight: FontWeight.w300,color: Colors.black),),
                Padding(
                    padding: const EdgeInsets.only(left:  20,right: 8),
                    child:
                    //CircleAvatar(backgroundImage: AssetImage('assets/images/trend.png'), radius: 18,backgroundColor: Colors.blue[900],),
                    Icon(icon,color: Colors.black,size: height*.03,)
                ),

              ],
            ),
          ),
        ),
      ),
    )
    ;
}








}
