import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading=true;
  File _image=File('assets/Amarillo Negro Solo Tipografía Festival de Cine Evento Logotipo.png');
  List? _output;
  final picker = ImagePicker();

  @override
  void initState(){
    super.initState();
    loadModel().then((value){
      setState(() {

      });
    });
  }

  detectImage(File image) async {
    var output= await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5
    );
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async{
    await Tflite.loadModel(model: 'assets/model_unquant.tflite',labels: 'assets/labels.txt');

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  pickImage()async{
    var image = await picker.pickImage(source: ImageSource.camera);
      if (image==null) return null;

      setState(() {
        _image = File(image.path);
      });
      detectImage(_image);
  }

  pickGalleryImage()async{
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image==null) return null;

    setState(() {
      _image = File(image.path);
    });
    detectImage(_image);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Text('Image Classifer',
            style: TextStyle(color: Colors.grey,fontSize: 20),
            ),
            SizedBox(height: 5),
            Text('Cat and Dogs Apps',
            style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 30),
            ),
            SizedBox(height: 50),
            Center(child:_loading ?
            Container(
              width: 50,
              child: Column (children: <Widget> [
                Image.asset('assets/Amarillo Negro Solo Tipografía Festival de Cine Evento Logotipo.png'),
                SizedBox(height: 50),
              ],)
            ) :Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250,
                    child: Image.file(_image),

                  ),
                  SizedBox(height: 20),
                  _output != null
                      ? Text('${_output![0]['label']}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                    ),
                  )
                      : Container(),
                  SizedBox(height: 10),

                ],
              ),
            ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[

                  GestureDetector(
                    onTap: (){
                      pickImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Select a Photo',
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),

                  ),
                  SizedBox(height: 5,
                  ),
                  GestureDetector(
                    onTap: (){
                      pickGalleryImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Capture a Photo',
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),

                  ),

              ],),
            ),

          ],

        ),
      ),
    );
  }
}
