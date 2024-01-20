import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/cities.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/data/main_info.dart';
import 'package:urban/constants/images.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/providers/lang_provider.dart';

class CompanyDetailsScreen extends StatefulWidget {
  static const String route='CompanyDetailsScreen/';
  final String company;
  const CompanyDetailsScreen({Key? key, required this.company}) : super(key: key);

  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
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
        elevation: 0,

      ),

      body:

      Stack(
        children: [
          CustomScrollView(
            slivers: [

            SliverList(

             delegate: SliverChildListDelegate([

               Container(
                 height: height*.2,
                 width: width,
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                     color: Colors.red,
                     borderRadius: BorderRadius.circular(20),
                     image: DecorationImage(
                         image: AssetImage(images[widget.company]!),fit:BoxFit.fill
                     )
                 ),






               )
             ]),

            ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context,index) {
                    return
                      supItem(
                        supplier:  suppliers[widget.company]![index]
                          ,height: height,width: width);


                  },
                  childCount:
                  suppliers[widget.company]!.length
                  ,




                ),





              ),
            ],

          ),
          Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
        ],
      )



      ,
    );
  }

  supItem({required double height,required Map supplier,required double width}){

    City city=City().getCity(key: cityId, value: supplier[supplierCityId]);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        elevation: 3,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text('${getLang(context, "name")} : '),
                  Text(supplier[supplierName]),
                ],
              ),
              Row(
                children: [
                  Text('${getLang(context, "phone")} : '),
                  Text(supplier[supplierPhone]),
                ],
              ),


              Row(
                children: [
                  Text('${getLang(context, "city")} : '),

                  ChangeNotifierProvider(
                    create: (_) =>LangProvider() ,
                    child:  Consumer<LangProvider>(
                        builder: (context,LangProvider lanNoty,child) {
                          return  Text(lanNoty.isEn?city.en!:city.ar!) ;
                        }
                    ),
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
