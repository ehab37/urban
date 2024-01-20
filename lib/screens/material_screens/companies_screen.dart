import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/categories.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/providers/fireProvider.dart';

import '../../constants/images.dart';
import 'products_screen.dart';
class MaterialCompaniesScreen extends StatefulWidget {
  static const String route='MaterialCompaniesScreen/';
  final String category;
  final String section;
  final String kind;
  const MaterialCompaniesScreen({Key? key, required this.category, required this.section, required this.kind}) : super(key: key);

  @override
  State<MaterialCompaniesScreen> createState() => _MaterialCompaniesScreenState();
}

class _MaterialCompaniesScreenState extends State<MaterialCompaniesScreen> {
  @override
  Widget build(BuildContext context){
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

              itemCount: categories[widget.category]![widget.section]![companies]!.length,

              itemBuilder:(context, index) =>
                  _companyItem(
                    imageUrl: images[categories[widget.category]![widget.section]![companies]![index]]!,
                    height: height,
                      company:categories[widget.category]![widget.section]![companies]![index],
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ProductsScreen(category:widget.category,section: widget.section,company:categories[widget.category]![widget.section]![companies]![index] ,kind: widget.kind, ),));
                    }
                     ) ,




            ),
            Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
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


  _companyItem({required String imageUrl,required double height,required String company,required VoidCallback onTap}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  80.0,vertical: 10),
      child: InkWell(

        onTap:onTap,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          elevation: 5,
          child: Container(
            height: height*.12,

            alignment: Alignment.center,
            padding: EdgeInsets.all(height*.01),
            decoration: BoxDecoration(
            //  color: Colors.black,
                //borderRadius: BorderRadius.circular(20),
             // border: Border.all(color: Colors.black.withOpacity(.2),width: 5),

               image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.contain)

            ),
          /*  child: Text(company,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  color: Colors.white,fontSize: height*.03,fontWeight: FontWeight.w900,

                  shadows: const [BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 1)]

              ),

            ),*/


          ),
        ),
      ),
    );
  }

}
