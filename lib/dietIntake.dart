import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wholegrain/productDetails.dart';
import 'package:pie_chart/pie_chart.dart';

class DietIntake extends StatefulWidget {
  final List<String> productName;
  final List<double> productDetails;

  const DietIntake({
    this.productName,
    this.productDetails,
  });

  @override
  _DietIntakeState createState() => _DietIntakeState();
}

class _DietIntakeState extends State<DietIntake> {
  Map<String, double> dataMap = new Map();
  List<Color> colorList = <Color>[Colors.lightGreen,Colors.white,
    Colors.blue,Colors.blueAccent,Colors.purple,Colors.purpleAccent,Colors.deepPurpleAccent
  ];

  @override
  void initState() {
    // TODO: implement initState
    dataMap.putIfAbsent("Total whole grain content", () => widget.productDetails[2]);
    dataMap.putIfAbsent("Total ", () => 100 - widget.productDetails[2]);
    //dataMap.putIfAbsent("Total fat", () => widget.productDetails[4]);
    //dataMap.putIfAbsent("Carbohydrate", () => widget.productDetails[7]);
    //dataMap.putIfAbsent("Fibre", () => widget.productDetails[9]);
    //dataMap.putIfAbsent("Total sugar", () => widget.productDetails[10]);
    //dataMap.putIfAbsent("Total whole grain content", () => widget.productDetails[12]);
    //dataMap.putIfAbsent("Others", () => widget.productDetails[11] + widget.productDetails[13] + widget.productDetails[14] + widget.productDetails[15]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diet Intake"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.productName.length == 0 ? "No whole grain food added!" : "Whole grain food you have taken: ")),
              SizedBox(
                height: 8,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.productName.length,
                  itemBuilder: (context, index) {
                    return Text(widget.productName[index]);
                  }),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        PieChart(dataMap: dataMap,legendPosition: LegendPosition.bottom, colorList: colorList,),

                        /*DataTable(
                          columns: [
                            DataColumn(label: Text('Label')),
                            DataColumn(label: Text('Amount')),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(Text('Serving size (g)')),
                              DataCell(Text(widget.productDetails[0].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  : widget.productDetails[0].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text(
                                  'Total whole grain content per serving (g)')),
                              DataCell(Text(widget.productDetails[1].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  : widget.productDetails[1].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Total whole grain content (%)')),
                              DataCell(Text(widget.productDetails[2].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  : widget.productDetails[2].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Calorie per serving (kcal)')),
                              DataCell(Text( widget.productDetails[3].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  : widget.productDetails[3].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Total fat (g)')),
                              DataCell(Text(
                                  widget.productDetails[4].toStringAsFixed(2) ==
                                      "0.00"
                                      ? "-"
                                      : widget.productDetails[4].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Saturated fat (g)')),
                              DataCell(Text(widget.productDetails[5].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  :  widget.productDetails[5].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Monounsaturated fat (g)')),
                              DataCell(Text(widget.productDetails[6].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  :  widget.productDetails[6].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Polyunsaturated fat (g)')),
                              DataCell(Text(widget.productDetails[7].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  : widget.productDetails[7].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Carbohydrate (g)')),
                              DataCell(Text(widget.productDetails[8].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  :  widget.productDetails[8].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Fibre (g)')),
                              DataCell(Text(widget.productDetails[9].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  : widget.productDetails[9].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Total sugar (g)')),
                              DataCell(Text(widget.productDetails[10].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-"
                                  : widget.productDetails[10].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Protein (g)')),
                              DataCell(Text(
                                  widget.productDetails[11].toStringAsFixed(2) ==
                                      "0.00"
                                      ? "-"
                                      : widget.productDetails[11].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Sodium (mg)')),
                              DataCell(Text(
                                  widget.productDetails[12].toStringAsFixed(2) ==
                                      "0.00"
                                      ? "-" : widget.productDetails[12].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Potassium (mg)')),
                              DataCell(Text(
                                  widget.productDetails[13].toStringAsFixed(2) ==
                                      "0.00"
                                      ? "-" : widget.productDetails[13].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Calcium (mg)')),
                              DataCell(Text(
                                  widget.productDetails[14].toStringAsFixed(2) ==
                                      "0.00"
                                      ? "-" : widget.productDetails[14].toStringAsFixed(2))),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Iron (mg)')),
                              DataCell(Text(widget.productDetails.length == 0
                                  ? "-" :
                              widget.productDetails[15].toStringAsFixed(2) ==
                                  "0.00"
                                  ? "-" : widget.productDetails[15].toStringAsFixed(2))),
                            ]),
                          ],
                        ),*/
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        backgroundColor: Colors.greenAccent,
        onPressed: (){
          Product_Details.productName = [];

          for(int i=0;i<16;i++){
            Product_Details.productDetails[i] = 0.0;
          }

          Navigator.of(context).pop(true);
        },
      ),
    );
  }

}
