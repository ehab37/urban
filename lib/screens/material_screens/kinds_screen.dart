import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/categories.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/providers/fireProvider.dart';

import 'companies_screen.dart';

class MaterialKindsScreen extends StatefulWidget {
  static const String route='MaterialKindsScreen/';
  final String category;
  final String section;

  const MaterialKindsScreen({Key? key, required this.category, required this.section}) : super(key: key);

  @override
  State<MaterialKindsScreen> createState() => _MaterialKindsScreenState();
}

class _MaterialKindsScreenState extends State<MaterialKindsScreen> {
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
          title:  Text('${getLang(context, widget.section)}'),
        ),

        body: Stack(
          children: [
            ListView.builder(
              itemCount: categories[widget.category]![widget.section]![kinds]!.length,

              itemBuilder:(context, index) =>
                  _kindsItem(

                      height: height,
                      kind: getLang(context, categories[widget.category]![widget.section]![kinds]![index]),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  MaterialCompaniesScreen(category: widget.category,section: widget.section,kind:categories[widget.category]![widget.section]![kinds]![index] ),));
                    }

                  ) ,




            ),
            Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
          ],
        )


    );
  }





  _kindsItem({required double height,required String kind,required VoidCallback onTap}){
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(

        onTap:onTap,
        hoverColor: Colors.green,
        splashColor: Colors.red,

        child: Material(
          color:  Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
          elevation: 1,

          child: Container(
            height: height*.07,

            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(height*.01),
            decoration: BoxDecoration(
             // color: Colors.teal,
              borderRadius: BorderRadius.circular(5),
              //border: Border.all(color: Colors.black.withOpacity(.2),width: 5),



            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      kind
                      ,
                     // textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.7),fontSize: height*.018,fontWeight: FontWeight.normal,

                         // shadows: const [BoxShadow(color: Colors.black,spreadRadius: 1,blurRadius: 1)]

                      ),

                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,color: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(.5),)
                ],
              ),
            ),


          ),
        ),
      ),
    );
  }

}

