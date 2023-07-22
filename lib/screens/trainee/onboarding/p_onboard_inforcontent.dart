import 'package:flutter/cupertino.dart';

class InforContent extends StatefulWidget {
  final String text;
  final List<String> data;

  InforContent({required this.text, required this.data});

  @override
  State<InforContent> createState() => _InforContentState();
}

class _InforContentState extends State<InforContent> {
  List<bool> isSelected = [];

  @override
  void initState() {
    super.initState();
    isSelected = List.generate(widget.data.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 13,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 3.0,
              childAspectRatio: 2.5,
            ),
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected[index]
                        ? Color(0xFF1A7012) // 선택되었을 때 색상 변경
                        : Color(0xFF252932),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      widget.data[index],
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF9C9C9C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
