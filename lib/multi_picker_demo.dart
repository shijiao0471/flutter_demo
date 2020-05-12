import 'package:flutter/material.dart';

import 'multi_picker_widget.dart';

class MultiPickerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _dataList3();
    return Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: new RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          color: Colors.blue,
          padding: EdgeInsets.all(10.0),
          onPressed: () {
            MultiDataPickerWidget(
              context: context,
              pickerColumnSize: 3,
              columnDataSource: (int column, Map<int, int> selectedMap) {
                List<String> list = List();
                if (column == 0) {
                  list = firstColumnTestData;
                } else if (column == 1) {
                  list = secondColumnTestData[selectedMap[0]];
                } else if (column == 2) {
                  list = thirdColumnTestData[selectedMap[0]][selectedMap[1]];
                }
                return list;
              },
              title: '这里是标题',
              confirmClick: (map) {
                print("johnTag-> $map");
              },
            ).show();
          },
          child: Text('请点击'),
        ));
  }

  List<String> firstColumnTestData = List();
  List<List<String>> secondColumnTestData = List();
  List<List<List<String>>> thirdColumnTestData = List();

  //构建测试数据
  _dataList3() {
    for (int i = 0; i < 10; i++) {
      var list3 = new List<List<String>>();
      //第一列的数据
      var list = new List<String>();
      for (int j = 0; j < 5; j++) {
        //第二列的数据
        list.add("选项$i $j");
        var listThird = new List<String>();
        for (int k = 0; k < 7; k++) {
          //第三列的数据
          listThird.add("选项$i $j $k");
        }
        list3.add(listThird);
      }
      thirdColumnTestData.add(list3);
      secondColumnTestData.add(list);
      firstColumnTestData.add("选项$i");
    }
  }
}
