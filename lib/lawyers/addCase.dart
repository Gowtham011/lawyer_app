import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lawyer_app/animations/bottomAnimation.dart';
import 'package:lawyer_app/screens/backBtnAndImage.dart';
import 'package:toast/toast.dart';


final controllerCaseName = TextEditingController();
final controllerSolName = TextEditingController();
final controllerDesc = TextEditingController();

class AddCase extends StatefulWidget {
  final String lawyerName;
  final String lawyerEmail;
  AddCase({required this.lawyerName, required this.lawyerEmail});

  @override
  _AddCaseState createState() => _AddCaseState();
}


class _AddCaseState extends State<AddCase> {
  bool validCaseName = false;
  bool validSolName = false;
  bool validDesc = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final caseNameTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerCaseName,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/injection.png'),
                height: height * 0.04
              ),
            ),
          ),
          labelText: 'Case Name',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
    final solNameTF = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controllerSolName,
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/tablets.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Solution Name',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  
    final medDescTF = TextField(
      keyboardType: TextInputType.multiline,
      autofocus: false,
      controller: controllerDesc,
      maxLines: null,
      decoration: InputDecoration(
          prefixIcon: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: WidgetAnimator(
              Image(
                image: AssetImage('assets/steth.png'),
                height: height * 0.04,
              ),
            ),
          ),
          labelText: 'Description',
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    controllerClear() {
      controllerCaseName.clear();
      controllerSolName.clear();
      controllerDesc.clear();
    }

    addingCase () {
      Firestore.instance
          .collection('cases')
          .document(controllerCaseName.text)
          .setData({
        'caseName': controllerCaseName.text,
        'solName': controllerSolName.text,
        'caseDesc': controllerDesc.text,
        'post' : widget.lawyerName,
        'lawEmail' : widget.lawyerEmail
      });
      controllerClear();
      Toast.show('Added Successfully!', context,
         backgroundRadius: 5, backgroundColor: Colors.blue, duration: 3);
      Navigator.pop(context);
    }

    final addBtn = Container(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          onPressed: () {
              setState(() {
                controllerCaseName.text.isEmpty ? validCaseName = true : validCaseName = false;
                controllerSolName.text.isEmpty ? validSolName = true : validSolName = false;
              
                controllerDesc.text.isEmpty ? validDesc = true : validDesc = false;
              });
              !validCaseName & !validSolName & !validDesc ? addingCase() :
              Toast.show("Empty Field(s) Found!", context, backgroundColor: Colors.red, backgroundRadius: 5, duration: 2);
          },
          color: Colors.white,
          shape: StadiumBorder(),
          child: Text(
            'Add',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
        ));

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: width,
              margin: EdgeInsets.fromLTRB(width * 0.025, 0, width * 0.025, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BackBtn(),
                  SizedBox(height: height * 0.05),
                  Row(
                    children: <Widget>[
                      Text(
                        'Adding',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: height * 0.04),
                      ),
                      SizedBox(
                        width: height * 0.015
                      ),
                      Text(
                        'Disease',
                        style: GoogleFonts.abel(fontSize: height * 0.04)
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Enter the Following Information',
                    style: GoogleFonts.abel(fontSize: height * 0.025),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  caseNameTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  solNameTF,
                  SizedBox(
                    height: height * 0.015,
                  ),
                  medDescTF,
                  SizedBox(
                    height: height * 0.02,
                  ),
                  addBtn,
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}