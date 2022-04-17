import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../login/loginscreen.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  Widget textfield({@required hintText}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor:  const Color.fromRGBO(205, 203, 203, 1.0),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(161, 78, 203, 1.0),
          title: const Center(child: Text('User Profile')),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              painter: HeaderCurvedContainer(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 415,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 72,),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: const Color.fromRGBO(133, 13, 189, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10,
                        color: Colors.white,
                        child: const SizedBox(
                          height: 50,
                          child: Center(child: Text('Sandip Kadariya',style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(109, 107, 107, 1.0),
                          ),),),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: const Color.fromRGBO(133, 13, 189, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10,
                        color: Colors.white,
                        child: SizedBox(
                          height: 50,
                          child: Center(child: Text(user.email!,style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(109, 107, 107, 1.0),
                          ),),),
                        ),
                      ),const SizedBox(height: 20),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: const Color.fromRGBO(133, 13, 189, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10,
                        color: Colors.white,
                        child: const SizedBox(
                          height: 50,
                          child:   Center(child:  Text('9821802120',style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(109, 107, 107, 1.0),
                          ),),),
                        ),
                      ),const SizedBox(height: 20),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        shadowColor: const Color.fromRGBO(133, 13, 189, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        elevation: 10,
                        color: Colors.white,
                        child: const SizedBox(
                          height: 50,
                          child:   Center(child:  Text('Kathmandu',style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(109, 107, 107, 1.0),
                          ),),),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(174, 140, 199, 1.0)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          )),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(174, 140, 199, 1.0)),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => loginpage()),
                              (Route<dynamic> route) => false);
                    },
                    child: const Text('Logout')),
                const SizedBox(height: 15,)
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                SizedBox(height: 10),
                Icon(
                  Icons.person_outline,
                  size: 130,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromRGBO(174, 140, 199, 1.0);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 150, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}