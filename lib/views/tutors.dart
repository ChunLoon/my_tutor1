import 'package:flutter/material.dart';

import '../model/user.dart';
import 'package:my_tutor1/model/config.dart';
import 'package:my_tutor1/model/tutor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class Tutors extends StatefulWidget {
    late final User user;

  @override
  State< Tutors > createState() => _TutorsState();
}

class _TutorsState extends State<Tutors> {
  List<listTutors> tutorsList = <listTutors>[]; //list subject is  dart (json convert dart)
  String titlecenter = "Loading";
    late double screenHeight, screenWidth, resWidth;
      var numofpage, curpage = 1;
  var color;



  @override
  void initState() {
    super.initState();
    _loadSubjects(1);
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
        title: const Text('Tutor'),
        backgroundColor: Color.fromARGB(60, 140, 139, 139),
      ),
       body:tutorsList.isEmpty ?
        Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)))
                      :
           Column(children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // ignore: prefer_const_constructors
                  image: DecorationImage(
                   alignment: Alignment.center,
                    image: AssetImage('assets/images/1.jpg'),
                    fit: BoxFit.cover
                  )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ]
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Tutors available", style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
                      SizedBox(height: 15,),
                      Container(
                        height: 20,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Center(child: Text("Learn Now", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                      ),

                      
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),

Padding(padding: EdgeInsets.all(10),),

              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      children: List.generate(tutorsList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                         // onTap: () => {_loadProductDetails(index)},
                                child:SizedBox( height: 600,

                          child: Card(
                              child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: MyConfig.server +
                                      "/my_tutor1/xx/assets/tutors/" +       //xampp htdocs
                                     tutorsList[index].tutorId.toString() +
                                      '.jpg',
                                  fit: BoxFit.cover,
                                  width: resWidth,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Text(
                                        tutorsList[index]
                                            .tutorName
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    
                                       Text("Phone:"+tutorsList[index]
                                          .tutorPhone
                                          .toString()),
                                      Text("Email:"+tutorsList[index]
                                          .tutorEmail
                                          .toString()),
                                          
                                    ],
                                  ))
                            ],
                          )
                                ),),
                        );
                      }))),

              SizedBox(
                height: 50,
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
                          onPressed: () => {_loadSubjects(index + 1)},
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

  void _loadSubjects(int pageno) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse(MyConfig.server + "/my_tutor1/xx/php/load_tutors.php"),
        body: {
          'pageno': pageno.toString(),
        
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

        if (extractdata['tutors'] != null) {
         tutorsList = <listTutors>[]; //
          extractdata['tutors'].forEach((v) {
            tutorsList.add(listTutors.fromJson(v)); //tutorsList php
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
}