import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/equipment.dart';
import 'package:urban/constants/images.dart';
import 'package:urban/providers/fireProvider.dart';

import '../../constants/constants.dart';
import 'equipments_view.dart';
class EquipmentsCompaniesScreen extends StatefulWidget {
  static const String route='EquipmentsCompaniesScreen/';
  final String kind;
  const EquipmentsCompaniesScreen({Key? key, required this.kind}) : super(key: key);

  @override
  State<EquipmentsCompaniesScreen> createState() => _EquipmentsCompaniesScreenState();
}

class _EquipmentsCompaniesScreenState extends State<EquipmentsCompaniesScreen> {
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
          title:  Text('${getLang(context, widget.kind)}'),
        ),

        body: Stack(
          children: [
            ListView.builder(

              itemCount:equipmentsCompanies.length,

              itemBuilder:(context, index) =>
                  _CompanyItem(
                      imageUrl: images[equipmentsCompanies[index]]!,
                      height: height,
                      company:equipmentsCompanies[index],
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  EquipmentsViewScreen(kind: widget.kind,company: equipmentsCompanies[index],  ),));
                      }
                  ) ,




            ),
            Provider.of<FireProvider>(context,listen: false).isAdmin!? const NewFloatingAdmin(): const NewFloatingUser()
          ],
        )
      /*   SingleChildScrollView(
        child: Column(
          children: [

            _PaintsItem(imageUrl: '',height: height,company: jotun),//JOTUN
            _PaintsItem(imageUrl: '',height: height,company: glc),////GLC
            _PaintsItem(imageUrl: '',height: height,company: scib),//SCIB
            _PaintsItem(imageUrl: '',height: height,company: sipes),//SIPES

          ],
        ),
      ),*/

    );
  }




  _CompanyItem({required String imageUrl,required double height,required String company,required VoidCallback onTap}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(

        onTap:onTap,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          elevation: 5,
          child: Container(
            height: height*.15,

            alignment: Alignment.center,
            padding: EdgeInsets.all(height*.01),
            decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black.withOpacity(.2),width: 5),

               image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.fill)

            ),
            // child: Text(company,
            //   textDirection: TextDirection.ltr,
            //   style: TextStyle(
            //       color: Colors.white,fontSize: height*.03,fontWeight: FontWeight.w900,
            //
            //       shadows: const [BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 1)]
            //
            //   ),
            //
            // ),


          ),
        ),
      ),
    );
  }

}
