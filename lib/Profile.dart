import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'Editprofile.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  XFile? imageFile = XFile("");
  String name="";
  String mobile="";
  String email="";
  String address ="";
  String pincode="";
  String city="";
  String state="";


  void Getvalue()async{
    var prefs=await SharedPreferences.getInstance();
    setState(() {
      name=prefs.getString("name")!;
      mobile=prefs.getString("mobile")!;
      email=prefs.getString("email")!;
      address=prefs.getString("address")!;
      pincode=prefs.getString("pincode")!;
      city=prefs.getString("city")!;
      state=prefs.getString("state")!;
      String imagePath = prefs.getString("imagePath") ?? "";
      if (imagePath.isNotEmpty) {
        setState(() {
          imageFile = XFile(imagePath);
        });
      }
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Getvalue();
  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomContainerprofile(),
        body: NestedScrollView(
          headerSliverBuilder: (context,innerBoxIsScrolled)=>[
            SliverAppBar(
              floating: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text("PROFILE",style: TextStyle(fontSize: 20 ,letterSpacing: 10),),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: false,
              expandedHeight: 70.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(30)),
                      color: Colors.deepPurpleAccent.shade100
                  ),
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Stack(
                      children: [
                        Icon(Icons.account_circle,size: 115,color: Colors.grey,),
                        Positioned(
                          top: 10,left: 10,
                          child: Container(
                            height: 95,
                            width: 95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(55),
                              color: Colors.transparent,
                              image: DecorationImage(image:
                              FileImage(File(imageFile!.path)),
                                  fit: BoxFit.fill
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                BounceInUp(
                  duration: Duration(seconds: 4),
                  animate: true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(top:5,left: 30,bottom: 5),
                        child: Row(
                          children: [
                            Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Container(
                                width: 55,height: 55,
                                child: Icon(Icons.person_outline_sharp,color: Colors.lightBlueAccent,),
                              ),
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0,left: 20),
                                  child: Text("Name",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text(name,style: TextStyle(fontSize: 15),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                BounceInUp(
                  duration: Duration(seconds: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5,left: 30,bottom: 5),
                        child: Row(
                          children: [
                            Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Container(
                                width: 55,height: 55,
                                child: Icon(Icons.phone_outlined,color: Colors.green,),
                              ),
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0,left: 20),
                                  child: Text("Mobile Number",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text(mobile,style: TextStyle(fontSize: 15),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                BounceInUp(
                  duration: Duration(seconds: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0,left: 30,bottom: 5),
                        child: Row(
                          children: [
                            Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Container(
                                width: 55,height: 55,
                                child: Icon(Icons.mail_outline,color: Colors.pinkAccent[200],),
                              ),
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0,left: 20),
                                  child: Text("Email Id",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text(email,style: TextStyle(fontSize: 15),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                BounceInUp(
                  duration: Duration(seconds: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0,left: 30,bottom: 5),
                        child: Row(
                          children: [
                            Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Container(
                                width: 55,height: 55,
                                child: Icon(Icons.home_outlined,color: Colors.yellow,),
                              ),
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0,left: 20),
                                  child: Text("Address",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: SizedBox(width: 200,
                                    child: Text(address,style: TextStyle(fontSize: 15),maxLines: 3,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BounceInUp(
                  duration: Duration(seconds: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0,left: 30,bottom: 5),
                        child: Row(
                          children: [
                            Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Container(
                                width: 55,height: 55,
                                child: Icon(Icons.location_on_outlined,color: Colors.red,),
                              ),
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0,left: 20),
                                  child: Text("Pincode",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text(pincode,style: TextStyle(fontSize: 15),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BounceInUp(
                  duration: Duration(seconds: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0,left: 30,bottom: 5),
                        child: Row(
                          children: [
                            Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Container(
                                width: 55,height: 55,
                                child: Icon(Icons.location_city_outlined,color: Colors.deepPurple,),
                              ),
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0,left: 20),
                                  child: Text("City",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text(city,style: TextStyle(fontSize: 15),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BounceInUp(
                  duration: Duration(seconds: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0,left: 30,bottom: 5),
                        child: Row(
                          children: [
                            Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                              ),
                              child: Container(
                                width: 55,height: 55,
                                child: Icon(Icons.account_balance_outlined,color: Colors.deepOrangeAccent,),
                              ),
                            ),
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0,left: 20),
                                  child: Text("State",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,),
                                  child: Text(state,style: TextStyle(fontSize: 15),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class BottomContainerprofile extends StatefulWidget {
  const BottomContainerprofile({super.key});

  @override
  State<BottomContainerprofile> createState() => _BottomContainerprofileState();
}

class _BottomContainerprofileState extends State<BottomContainerprofile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,right: 30,left: 30,bottom: 10),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Editprofile()));
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.deepPurpleAccent[100],
          ),
          child: Align(
              child: Text("Edit Profile",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
        ),
      ),
    );
  }
}
