import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/equipment.dart';
import 'package:urban/constants/images.dart';
import 'package:urban/providers/fireProvider.dart';

import 'equipments_companies.dart';
class EquipmentsKindScreen extends StatefulWidget {
  static const String route='EquipmentsKindScreen/';
  const EquipmentsKindScreen({Key? key}) : super(key: key);

  @override
  State<EquipmentsKindScreen> createState() => _EquipmentsKindScreenState();
}

class _EquipmentsKindScreenState extends State<EquipmentsKindScreen> {
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
          title: const Text('equipments'),
        ),
        body:Stack(
          children: [
            ListView.builder(

              itemCount: equipmentKinds.length,

              itemBuilder: (context, index) =>
                  _kindItem(
                      name: getLang(context, equipmentKinds[index]),
                      height: height,
                      imageUrl:images[equipmentKinds[index]]!,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  EquipmentsCompaniesScreen(kind: equipmentKinds[index] ),));

                      }),

            ),
            Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
          ],
        )



    );
  }




  _kindItem({required String name,required String imageUrl,required double height,required VoidCallback onTap}){
    return Padding(
      padding:   EdgeInsets.symmetric(vertical: height*.015,horizontal: height*.04),
      child: InkWell(

        onTap:onTap,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          elevation: 5,
          shadowColor: Colors.black,

          child: Container(
            height: height*.15,

            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(height*.01),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(.5),width: 01),
                 color: Colors.white.withOpacity(0),
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.contain)

            ),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Text(name,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    color: Colors.black,fontSize: height*.02,fontWeight: FontWeight.w900,

                    shadows: const [BoxShadow(color: Colors.white,spreadRadius: 50,blurRadius: 5)]

                ),

              ),
            ),

          ),
        ),
      ),
    );
  }

}
