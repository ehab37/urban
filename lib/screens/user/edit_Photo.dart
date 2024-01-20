import 'dart:io';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/MyUser.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/providers/fireProvider.dart';



class EditUserPhoto extends StatefulWidget {
  static const  route='/EditUserPhoto';
  const EditUserPhoto({Key? key}) : super(key: key);

  @override
  _EditUserPhotoState createState() => _EditUserPhotoState();
}

class _EditUserPhotoState extends State<EditUserPhoto> {
  File? imageFile;
  XFile? picked;
  MyUser? userInfoo;





  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var fire= Provider.of<FireProvider>(context,listen: false);
    var myUserInfo= Provider.of<FireProvider>(context,listen: false).myUserInfo;
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('تغيير الصوره الشخصيه',),
        centerTitle: false,
        elevation: 0,
      ),

      body: Center(
        child: ListView(

          children: [
            _fileTest(height:height,myUserInfo:myUserInfo! ),
            //SizedBox(height: height*.05),
            UnconstrainedBox(
              constrainedAxis: Axis.vertical,
              child: Ebotton(
                onpressed: ()async{
                  var myCroppedImage= await Provider.of<FireProvider>(context,listen: false).addImageAndCrop();
                  setState(() {
                    imageFile=myCroppedImage;
                    picked=Provider.of<FireProvider>(context,listen: false).pickedCrop;


                  });

                },
                borderRadius: 10,
                backgroundcolor: color_b.withOpacity(.8),
                borderColor: Colors.white.withOpacity(0),
                padding: 15,
                elevation: 3,
                shadowcolor: Theme.of(context).canvasColor,
                child: Text('إختر صوره',style: TextStyle(color: Colors.white,fontSize: height*.018),),



              ),
            ),
            SizedBox(height: height*.05),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MySaveButton(onpressed: ()async{


                  if (picked==null){ debugPrint('error image');
                  MyFlush().showFlush(context: context, text: '${getLang(context, "select image")}');   return;}
                  else{
                    MyIndicator().loading(context);

                    if(! await Provider.of<FireProvider>(context,listen: false).uploadImageCrop(imageFileCrop:  imageFile!,pickedCrop:  picked!))
                    {debugPrint('error');
                    Navigator.pop(context);
                    return;}

                    else{
                      if(myUserInfo.photoLoc!=null){ fire.removeImageFromStorage(photoLoc:myUserInfo.photoLoc!);}





                      if(

                      await MyUser().editUser(userId:  myUserInfo.id!, key: userPhotoLoc,newValue:  fire.photoLocCrop)
                          &&
                          await MyUser().editUser(userId: myUserInfo.id!, key: userPhoto,newValue: fire.imageUrlCrop)
                      ){

                        if( await Provider.of<FireProvider>(context,listen: false).getMyUserInfo(context: context)){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      }
                      else{
                        snack(context: context, message: 'error please try again');}

                    }

                  }
                }),
                MyCloseButton(onpressed: (){Navigator.pop(context);})
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _fileTest({required double height,required MyUser myUserInfo}){

if(imageFile==null){return UnconstrainedBox(
  constrainedAxis: Axis.vertical,
  child:myUserInfo.photo!=null? Container(
    height: height*.2,width: height*.2,
    foregroundDecoration: BoxDecoration(


        shape: BoxShape.circle,
        border:Border.all(color: Theme.of(context).canvasColor),
        image: DecorationImage(image: CachedNetworkImageProvider(myUserInfo.photo!,), fit: BoxFit. fill)

    )

  ):

  Container(
    height: height*.2,width: height*.2,
    decoration:  BoxDecoration(


        shape: BoxShape.circle,
        border:Border.all(color: Theme.of(context).canvasColor),
        color: Colors.black

    ),
    alignment: Alignment.center,
    child: Text(
      Provider.of<FireProvider>(context,listen: false).myUserInfo!.name![0].toUpperCase()

      ,style: TextStyle(color: Colors.white,fontSize: height*.1),),
  ),
);}
else{
  return UnconstrainedBox(
    constrainedAxis: Axis.vertical,
    child:Container(
      height: height*.2,width: height*.2,
      foregroundDecoration:
      BoxDecoration(


          shape: BoxShape.circle,
          border:Border.all(color: Theme.of(context).canvasColor),
          image: DecorationImage(image: FileImage(imageFile!), fit: BoxFit. fill)
      ),
    )


  );
}

  }

}
snack({required BuildContext context,required String message}){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}