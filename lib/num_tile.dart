import 'package:flutter/material.dart';

class NumTile extends StatefulWidget {
  final String numara;
  final Color color;
  final Color textColor;
  final buttonTapped;

  NumTile(
      {super.key,
      required this.numara,
      required this.color,
      required this.textColor,
      required this.buttonTapped});

  @override
  State<NumTile> createState() => _NumTileState();
}

class _NumTileState extends State<NumTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(color: widget.color),
          child: TextButton(
            onPressed: widget.buttonTapped,
            /*child: Text(widget.numara.toString(),style: TextStyle(fontSize: 22 ,color: widget.textColor,backgroundColor: widget.color),textAlign: TextAlign.center,),*/
            child: widget.numara != "DEL" ? Text(widget.numara.toString(),style: TextStyle(fontSize: 22 ,color: widget.textColor,backgroundColor: widget.color),textAlign: TextAlign.center,):
            Row(
              children: [
                Icon(Icons.backspace_rounded, color: widget.textColor,),
                Spacer(),
                Text(widget.numara.toString(),style: TextStyle(fontSize: 22 ,color: widget.textColor,backgroundColor: widget.color),textAlign: TextAlign.center,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
