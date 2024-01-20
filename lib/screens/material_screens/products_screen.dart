
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban/components/app_local.dart';
import 'package:urban/constants/constants.dart';
import 'package:urban/constants/images.dart';
import 'package:urban/constants/my_flush.dart';
import 'package:urban/constants/my_indicators.dart';
import 'package:urban/constants/product.dart';
import 'package:urban/providers/fireProvider.dart';
import 'package:urban/screens/material_screens/add_product.dart';

import 'Company_Details_Screen.dart';
import 'product_details.dart';


class ProductsScreen extends StatefulWidget {
  static const String route='ProductsScreen/';
  final String kind;
  final String company;
  final String category;
  final String section;
  const ProductsScreen({Key? key, required this.kind, required this.company, required this.category, required this.section}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  List<Product>?products;

  getProducts()async{
    var products0=await Product().getProducts(category: widget.category, company: widget.company, section: widget.section,kind:widget.kind);
    setState(() {
      products=products0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    if(MediaQuery.of(context).orientation==Orientation.landscape){
      height=MediaQuery.of(context).size.width;
      width=MediaQuery.of(context).size.height;
    }
    bool isAdmin=Provider.of<FireProvider>(context).isAdmin!;


    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        title: Text('paints/${widget.company}/${widget.kind}'),
        actions: [
          isAdmin? Padding(
            padding: const EdgeInsets.symmetric(horizontal:  8.0,vertical: 3),
            child: InkWell(


              onTap: ()async{
                await  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    AddProductScreen(category: widget.category,section: widget.section,company: widget.company,kind: widget.kind),)).then((value) =>getProducts() );


              },
              child: Material(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  elevation: 3,
                  child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Icon(Icons.add,color: Colors.black),
              )),
            ),
          ):const SizedBox()
        ],

      ),

      body: products==null?myShimmer(context):


      Stack(
        children: [
          CustomScrollView(
            slivers: [

              SliverAppBar(
                backgroundColor: Colors.white.withOpacity(0),
                floating: true,
                 elevation: 10,
                toolbarHeight: height*.1,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Material(
                      elevation: 5,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyDetailsScreen(company: widget.company),));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height*.1,
                            width: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(images[widget.company]!),fit:BoxFit.fill
                                )
                            ),






                          ),
                        )
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
                leading: const SizedBox(),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                        (context,index) {
                      return
                        productItem(
                            product: products![index],height: height,width: width,isAdmin: isAdmin);


                    },
                    childCount:
                    products!.length

                  ,



                ),





              ),
            ],

          ),

          Provider.of<FireProvider>(context,listen: false).isAdmin!?const NewFloatingAdmin(): const NewFloatingUser()
        ],
      ),






    );
  }

  productItem({required Product product,required double height,required double width,required bool isAdmin}){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 20,
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(

          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(product: product),));},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: height*.15,

              // color: Colors.yellow,
              child: Stack(
                children: [

                  Positioned(
                      left: 0,top: 0,bottom: 0,right: 0,
                      //right: height*.27,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(),
                              Padding(
                              padding:  EdgeInsets.symmetric(horizontal: width*.02,vertical: height*.00),
                              child: SizedBox(
                                width:width*.5,
                                child: Text(


                                   product.name!


                                  ,


                                  style:TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,
                                    fontSize: height*.018,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,) ,
                                  textAlign: TextAlign.start,
                                  maxLines: 2,



                                ),
                              ),
                        ),
                              Material(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).primaryColor,
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(' ${getLang(context, "price")} : ',
                                        style:TextStyle(color: Colors.orange.withOpacity(1),
                                          fontSize: height*.015,
                                          fontWeight: FontWeight.normal,




                                        ) ,),
                                      SizedBox(
                                        width:width*.3,
                                        child: Text('${product.price}',
                                          style:TextStyle(color: Theme.of(context).textTheme.bodySmall!.color,
                                            fontSize: height*.018,
                                            fontWeight: FontWeight.normal,) ,
                                          textAlign: TextAlign.start,



                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height:  height*.13,width:  width*.31,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(image: CachedNetworkImageProvider(product.imageUrl!),fit: BoxFit.fill,)
                            ),
                          ),

                        ],
                      )),
                 /* Positioned(
                    left: 0,bottom: 0,
                    child:  Material(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.teal.shade700,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(' ${getLang(context, "price")} : ',
                              style:TextStyle(color: Colors.orange.withOpacity(1),
                                fontSize: height*.015,
                                fontWeight: FontWeight.normal,




                              ) ,),
                            SizedBox(
                              width:width*.3,
                              child: Text('${product.price}',
                                style:TextStyle(color: Colors.white.withOpacity(1),
                                  fontSize: height*.018,
                                  fontWeight: FontWeight.normal,) ,
                                textAlign: TextAlign.start,



                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),*/
                  isAdmin?  Positioned(
                      
                      child: Material(
                              color: Colors.white.withOpacity(.7),
                              elevation: 3,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: ()async{
                                 showDialog(context: context, builder: (BuildContext context)=>
                                 Dialog(
                                   elevation: 5,
                                   backgroundColor: Colors.teal.shade800,
                                   child: SizedBox(
                                     height: height*.2,
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       children: [
                                         Center(child: Text('${getLang(context, "are you sure")}',style: const TextStyle(fontWeight: FontWeight.w900,color: Colors.white ),)),
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               children: [
                                           EbottonI(

                                               onpressed: ()async{
                                                 MyIndicator().loading(context);
                                             await Product().removeProduct(product: product);

                                             await getProducts();
                                             Navigator.pop(context);
                                             Navigator.pop(context);
                                             MyFlush().showDeletingDoneFlush(context: context);

                                           },
                                           icon: Icon(Icons.delete,color: Colors.red.withOpacity(.5),),
                                         elevation: 3,
                                         borderRadius: 10,
                                         backgroundcolor: Colors.white,
                                         padding: 10,
                                         overColor: Colors.red,
                                             shadowcolor: Colors.black,
                                           child: Text('${getLang(context, "yes")}',style: const TextStyle(color: Colors.black)),




                                       ),
                                       EbottonI(
                                           onpressed: ()async{

                                             Navigator.pop(context);
                                           },
                                           icon: Icon(Icons.keyboard_return,color: Colors.green.withOpacity(.5),),
                                         elevation: 3,
                                         borderRadius: 10,
                                         backgroundcolor: Colors.white,
                                         padding: 10,
                                         overColor: Colors.red,
                                         shadowcolor: Colors.black,
                                           child:  Text('${getLang(context, "no")}',style: const TextStyle(color: Colors.black)),




                                       ),
                                     ],
                                   )
                                 ],
                               ),
                             ),
                           )


                           );

                          },
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(Icons.delete_forever_sharp,color: Colors.red.withOpacity(.5),size: 25,),
                          ),
                        ),
                  )):const SizedBox()
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }



}



