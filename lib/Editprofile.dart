import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'Profile.dart';

class Editprofile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditprofileState();
  }
}

class _EditprofileState extends State<Editprofile> {
  XFile? imageFile = XFile("");
  final ImagePicker picker = ImagePicker();
  void _openGallery(BuildContext context) async{
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = image!;
    });
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context)  async{
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      imageFile = photo!;
    });
    Navigator.pop(context);
  }

  Future<void>_showChoiceDialog(BuildContext context) {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose Option"),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1,),
              ListTile(
                onTap: (){
                  _openGallery(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box,color: Colors.black87,),
              ),

              Divider(height: 1,),
              ListTile(
                onTap: (){
                  _openCamera(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,color: Colors.black87,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(height: 1),
              ),
              if (imageFile != null && imageFile!.path.isNotEmpty) // Conditionally show delete option
                ListTile(
                  onTap: () {
                    deleteimage();
                  },
                  title: Text("Delete"),
                  leading: Icon(Icons.delete,color: Colors.black87,),
                ),
            ],
          ),
        ),);
    });
  }

  Future<void> deleteimage() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("imagePath", "");
    setState(() {
      imageFile = XFile("");
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // Load saved data when the widget is initialized
    loadSavedData();
  }

  // Function to load saved data into TextEditingControllers
  void loadSavedData() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      namecontroller.text = prefs.getString("name") ?? "";
      mobilecontroller.text = prefs.getString("mobile") ?? "";
      emailcontroller.text = prefs.getString("email") ?? "";
      addresscontroller.text = prefs.getString("address") ?? "";
      pincodecontroller.text = prefs.getString("pincode") ?? "";
      citycontroller.text = prefs.getString("city") ?? "";
      statecontroller.text = prefs.getString("state") ?? "";
      String imagePath = prefs.getString("imagePath") ?? "";
      if(imagePath.isNotEmpty){
        imageFile =XFile(imagePath);
      }
    });
  }



  final formkey=GlobalKey<FormState>();

  TextEditingController namecontroller=TextEditingController();
  TextEditingController mobilecontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  TextEditingController pincodecontroller=TextEditingController();
  TextEditingController citycontroller=TextEditingController();
  TextEditingController statecontroller=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                SizedBox(width: 150,
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
                      Positioned(
                          bottom: 10,left: 70,
                          child:CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.deepPurpleAccent,
                              child: GestureDetector(
                                  onTap: (){
                                    _showChoiceDialog(context);
                                  },
                                  child: Icon(Icons.camera_alt_rounded,size: 15,color: Colors.white,))) )
                    ],
                  ),
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(controller: namecontroller,
                          decoration: InputDecoration(
                              labelText: "Name",
                              labelStyle: TextStyle(fontSize: 15,),
                              border: OutlineInputBorder()
                          ),
                          validator: (value){
                            if(value!= null && value.isEmpty){
                              return "Please Entery your Name";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(controller: mobilecontroller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: "Mobile Number",
                              labelStyle: TextStyle(fontSize: 15,),
                              border: OutlineInputBorder()
                          ),
                          validator: (value){
                            if(value!=null && value.isEmpty){
                              return 'Please Enter your mobile no';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(controller: emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: "Email Id",
                                labelStyle: TextStyle(fontSize: 15,),
                                border: OutlineInputBorder(
                                )
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Email address';
                              }
                              if (!RegExp(r'^(([^<>()[\]\\.,;:\s@]+(\.[^<>()[\]\\.,;:\s@]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)) {
                                return 'Enter a Valid Email address';
                              }
                              return null;
                            }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(controller: addresscontroller,
                          decoration: InputDecoration(
                              labelText: "Address",
                              labelStyle: TextStyle(fontSize: 15,),
                              border: OutlineInputBorder()
                          ),
                          validator: (value){
                            if(value!=null && value.isEmpty){
                              return 'Please Enter your Address';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(
                          controller: pincodecontroller,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: "Pincode",
                              labelStyle: TextStyle(fontSize: 15,),
                              border: OutlineInputBorder()
                          ),
                          validator: (value){
                            if(value!=null && value.isEmpty){
                              return 'Please Enter Pincode';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(controller:citycontroller,
                          decoration: InputDecoration(
                              labelText: "City",
                              labelStyle: TextStyle(fontSize: 15,),
                              border: OutlineInputBorder()
                          ),
                          validator: (value){
                            if(value!=null && value.isEmpty){
                              return 'Please Enter your City';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextFormField(controller: statecontroller,
                          decoration: InputDecoration(
                              labelText: "State",
                              labelStyle: TextStyle(fontSize: 15,),
                              border: OutlineInputBorder()
                          ),
                          validator: (value){
                            if(value!=null && value.isEmpty){
                              return 'Please Enter your State';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,right: 30,left: 30,bottom: 10),
                        child: InkWell(
                          onTap: (){
                            if(formkey.currentState!.validate()) {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.success(
                                  message:
                                  "Save Successfully",
                                ),
                              );
                              SaveValue();
                              Navigator.push(context,MaterialPageRoute(builder: (context){
                                return Profile();
                              }));
                            }
                            else{
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  backgroundColor: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  textStyle: TextStyle(fontSize: 15),
                                  message:
                                  "Something went wrong. Please check your credentials and try again",
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 45,width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.deepPurpleAccent[200],
                            ),
                            child: Align(
                                child: Text("Save",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void SaveValue() async{

    var prefs=await SharedPreferences.getInstance();
    prefs.setString("name", namecontroller.text);
    prefs.setString("mobile", mobilecontroller.text);
    prefs.setString("email", emailcontroller.text);
    prefs.setString("address", addresscontroller.text);
    prefs.setString("pincode", pincodecontroller.text);
    prefs.setString("city", citycontroller.text);
    prefs.setString("state", statecontroller.text);
    prefs.setString("imagePath", imageFile?.path ?? "");
    print("save success");
  }
}


