import 'package:flutter/material.dart';

/*PreferredSize customAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60.0),
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: AppBar(
        leading: Icon(Icons.calculate_outlined,size: 50,),
        title: Text("Mathematics ",style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            letterSpacing: 2
        ),
        ),
        backgroundColor:  Color(0XFF1ea366),
        elevation: 0,
      ),
    ),
  );
  *//*AppBar(
    leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios, color: Colors.pink)),
    title: Text("Mathematics", style: TextStyle(color: Colors.pink)),
    centerTitle: true,
    backgroundColor: Colors.yellow,
    elevation: 0,
  );*//*
}*/
class customAppBar extends StatelessWidget {
  const customAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.calculate_outlined,size: 50,),
      title: Text("Mathematics ",style: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w500,
          letterSpacing: 2
      ),
      ),
      backgroundColor:  Color(0XFF1ea366),
      elevation: 0,
    );
  }
}
