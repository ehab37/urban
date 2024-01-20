// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/data/main_info.dart';
import 'package:urban/constants/images.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/providers/fireProvider.dart';

import 'kinds_screen.dart';
class MaterialSectionsScreen extends StatefulWidget {
  static const String route='MaterialSectionsScreen/';

  final String category;
  const MaterialSectionsScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<MaterialSectionsScreen> createState() => _MaterialSectionsScreenState();
}

class _MaterialSectionsScreenState extends State<MaterialSectionsScreen> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    return Scaffold(


      appBar: AppBar(
        title: Text('${getLang(context, widget.category)}'),
      ),
      body:widget.category==''?myShimmer(context):
      Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1
            ),
            padding: const EdgeInsets.all(16),


            itemCount: materialCategories[widget.category]!.length,

            itemBuilder: (context, index) =>
                _sectionItem(
                    name:getLang(context,  materialCategories[widget.category]![index]),
                    height: height,
                    imageUrl:images[materialCategories[widget.category]![index]]!,
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  MaterialKindsScreen(category: widget.category,section:materialCategories[widget.category]![index] ),));

                    }),

          ),
          Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
        ],
      )



    );
  }


  _sectionItem({required String name,required String imageUrl,required double height,required VoidCallback onTap}){
    return Padding(
      padding:   EdgeInsets.all(height*.01),
      child: InkWell(

        onTap:onTap,
        child: Material(
         // color: Colors.green,
          borderRadius: BorderRadius.circular(10),
          elevation: 5,
          shadowColor: Colors.black,

          child: Container(
            height: height*.2,

            alignment: Alignment.center,
            padding: EdgeInsets.all(height*.01),
            decoration: BoxDecoration(
             // border: Border.all(color: Colors.black.withOpacity(.5),width: 01),
              color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.cover)

            ),
            child: Text(name,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: Colors.white,fontSize: height*.025,fontWeight: FontWeight.w900,

                  shadows: const [BoxShadow(color: Colors.black,spreadRadius: 10,blurRadius: 20)]

              ),

            ),

          ),
        ),
      ),
    );
  }

}
