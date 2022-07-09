import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:my_tutor1/model/user.dart';
//import '../models/tutors.dart';
import 'package:my_tutor1/model/config.dart';
import 'package:my_tutor1/model/subject.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:my_tutor1/views/cartscreen.dart';


class Subjects extends StatefulWidget {
     
  final User user;

  const Subjects({Key? key, required this.user}) : super(key: key);

  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  
  List<listSubjects> subjectList = <listSubjects>[]; //list subject is  dart (json convert dart)
  String titlecenter = "Loading";
    String search = "";
  TextEditingController searchController = TextEditingController();
int cart = 0;

    late double screenHeight, screenWidth, resWidth;
      var numofpage, curpage = 1;
  var color;

 


  @override
  void initState() {
    super.initState();
   
    _loadSubjects(1, search);
  }

  @override
  Widget build(BuildContext context) {

    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount = 3;
    }

    return Scaffold(
         backgroundColor: Colors.black,
          
          appBar: AppBar(
        title: const Text('Subjects'),
       
        backgroundColor: Color.fromARGB(60, 140, 139, 139),
      
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          ),
          

          TextButton.icon(
            onPressed: () {
                         

              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => CartScreen(
                            user:widget.user,
                            )));
                _loadSubjects(1, search);
                   _loadMyCart();
              },
            
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: Text(widget.user.cart.toString(),
                style: const TextStyle(color: Colors.white)),
          ),

        ],
      ),
       body:subjectList.isEmpty ?
        Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)))
                      :
           Column(children: [

              const Text("Recommend ",textAlign: TextAlign.left,style: const TextStyle(
                      fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold,)),



Container(
  color: Colors.white,
   child:SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    height: 80,
                    width: 180,
                    margin: EdgeInsets.all(10),
                      
                  child: CachedNetworkImage(
                                  imageUrl: MyConfig.server +
                                      "/my_tutor1/xx/assets/courses/" +       //xampp htdocs
                                     subjectList[index].subjectId.toString() +
                                      '.png',),

                                  
                  ),
                  ),
                  ),
                ),
              
Padding(padding: EdgeInsets.all(8)),

              
const Text("Subject List ",textAlign: TextAlign.left,style: const TextStyle(
                      fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold,)),



              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      children: List.generate(subjectList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          onTap: () => {_loadSubjectDetails(index)},
                            

                          child: Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 5,
                                child: CachedNetworkImage(
                                  imageUrl: MyConfig.server +
                                      "/my_tutor1/xx/assets/courses/" +       //xampp htdocs
                                     subjectList[index].subjectId.toString() +
                                      '.png',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 5,
                                  child: Column(
                                    children: [
                                      Text(
                                        subjectList[index]
                                            .subjectName
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children:[
                                      Text("RM " +
                                          double.parse(subjectList[index]
                                                  .subjectPrice
                                                  .toString())
                                              .toStringAsFixed(2)),
                                     /* Text(subjectList[index]
                                              .subjectDesc
                                              .toString() ),*/
                                        
                                            IconButton(
                                                  onPressed: () {
                                                   _addtocartDialog(index);
                                                  },
                                                  icon: const Icon(
                                                      Icons.shopping_cart )),
                                     ] ),           
                                    ],
                                  ))
                            ],
                          )
                                ),
                        );
                      }))),

              SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.red;
                    } else {
                      color = Colors.white;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () => {_loadSubjects(index +1, "")},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
           ]),
    );
    
  }

  void _loadSubjects(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(MyConfig.server + "/my_tutor1/xx/php/load_subjects.php"),
        body: {
          'pageno': pageno.toString(),
          'search': _search,

        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);

      print(jsondata);



      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['subjects'] != null) {
         subjectList = <listSubjects>[]; //
          extractdata['subjects'].forEach((v) {
            subjectList.add(listSubjects.fromJson(v)); //subjectList php
          });
        } else {
          titlecenter = "No Product Available";
        }
        setState(() {});
      } else {
        //do something
      }
    });
  }


void _loadSearchDialog() {
    searchController.text = "";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search ",
                ),
                content: SizedBox(
                  //height: screenHeight / 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                   
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      search = searchController.text;
                      Navigator.of(context).pop();
                      _loadSubjects(1, search,);
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }

 _loadSubjectDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Subject Details",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: MyConfig.server +


                       "/my_tutor1/xx/assets/courses/" +       //xampp htdocs
                                     subjectList[index].subjectId.toString() +
                                      '.png',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  subjectList[index].subjectName.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("\nSubject Description: \n" +
                       subjectList[index].subjectDesc.toString(),	textAlign: TextAlign.justify,
 ),
                  Text(" \nPrice: RM " +
                      double.parse(  subjectList[index].subjectPrice.toString())
                          .toStringAsFixed(2)),
                  Text("\nSession: " +
                        subjectList[index].subjectSessions.toString() +
                      " units"),
                  Text("\nRating: " +
                        subjectList[index].subjectRating.toString()),
                  
                ]),
              ],
            )),
           
              actions: [
              SizedBox(
                  width: screenWidth / 1,
                  child: ElevatedButton(
                      onPressed: () {
                        _addtocartDialog(index);
                      },
                      child: const Text("Add to cart"))),
            ],
          );
        });
  }


  _addtocartDialog(int index) {
   showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Add to cart",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
          
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () async {
          _addtoCart(index);
           // add(index);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  


      
    
  }
void _loadMyCart() {
  
      // ignore: avoid_single_cascade_in_expression_statements
      http.post( 
        Uri.parse(MyConfig.server + "/my_tutor1/xx/php/load_mycartqty.php"),
         body: {
            "email": widget.user.email.toString(),
          }).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          return http.Response(
              'Error', 408); // Request Timeout response status code
        },
      ).then((response) {

    
        var jsondata = jsonDecode(response.body);
        if (response.statusCode == 200 && jsondata['status'] == 'success') {
          print(jsondata['data']['carttotal'].toString());
          setState(() {
            widget.user.cart = jsondata['data']['carttotal'].toString();
          });
        }
      });
    
  }




  void _addtoCart(int index) {

    http.post(
        Uri.parse(MyConfig.server + "/my_tutor1/xx/php/insert_cart.php"),
        body: {
          "email": widget.user.email.toString(),
          "subid": subjectList[index].subjectId.toString(),
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      print(response.body);
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        print(jsondata['data']['carttotal'].toString());
        setState(() {
          widget.user.cart = jsondata['data']['carttotal'].toString();
        });
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

             Navigator.of(context).pop();
               Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => CartScreen(
                           user: widget.user,)));
      }

      
               
    });

    
  }

}