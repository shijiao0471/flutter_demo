import 'package:first_flutter_app/ke_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const headerHeight = 48.0;
const pickerHeight = 240.0;

typedef List<Widget> CreateWidgetList();
typedef void ConfirmButtonClick(Map selectedIndexList);
typedef List<String> SingleColumnData(int column, Map<int, int> selectedMap);

abstract class MultiDataPickerDelegate {
  /// 将每列数据源交由控件使用者提供，每列数据关联关系也由使用者维护，这样就可以做到N列数据联动
  /// [column]当前列的位置
  /// [selectedMap]已选值得位置 map<columnIndex,rowOfColumn>
  /// 根据当前列可知前一列所选值，从而从数据源中得到本列数据
  List<String> getSingleColumnData(int column, Map<int, int> selectedMap);

  /// 获取Picker列数
  int getPickerColumnSize();
}

class MultiDataPickerWidget extends StatefulWidget {
  final String title;
  final Color titleColor;
  final double titleFontSize;
  final BuildContext context;
  final Color confirmColor;
  final double confirmFontSize;
  final List<String> pickerTitles;
  final double pickerTitleFontSize;
  final Color pickerTitleColor;
  final double textFontSize;
  final Color textColor;
  final List<FixedExtentScrollController> controllers = new List();
  final ConfirmButtonClick confirmClick;

  final SingleColumnData columnDataSource;
  final int pickerColumnSize;

  ///各项有关联的Picker
  MultiDataPickerWidget({
    Key key,
    @required this.context,
    @required this.columnDataSource,
    @required this.pickerColumnSize,
    this.title = "",
    this.titleColor = const Color(0XFF222222),
    this.titleFontSize = 18,
    this.confirmFontSize = 16,
    this.confirmColor = const Color(0xff3072F6),
    this.pickerTitles,
    this.pickerTitleFontSize = 16,
    this.pickerTitleColor = const Color(0XFF4A4E59),
    this.textFontSize = 18,
    this.textColor = const Color(0xff202126),
    this.confirmClick,
  }) : assert(columnDataSource != null);

  @override
  _MultiDataPickerWidgetState createState() =>
      new _MultiDataPickerWidgetState();

  void show() {
    showGeneralDialog(
      context: context,
      barrierLabel: "barrier",
      barrierColor: Colors.black54,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 150),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            this,
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        );
      },
    ).then((value) {
      print('johnTag then $value');
      if (value != null) {
        confirmClick(value);
      }
    });
  }
}

class _MultiDataPickerWidgetState extends State<MultiDataPickerWidget> {
  ///<columnIndex,rowOfColumnIndex>
  final Map<int, int> _selectedData = Map();

  _MultiDataPickerWidgetState();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.pickerColumnSize; i++) {
      _selectedData[i] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _configHeaderWidget(),
          _horizontalSeparator(),
          _configMultiDataPickerWidget()
        ],
      ),
    );
  }

  Widget _configHeaderWidget() {
    return new Container(
        height: headerHeight,
        color: Color(0xffffffff),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new FlatButton(
                  // color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text(
                    '取消',
                    style: TextStyle(fontSize: 16, color: Color(0xff222222)),
                  )),
              flex: 1,
            ),
            new Expanded(
              child: new Center(
                child: new Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: widget.titleFontSize,
                      fontWeight: FontWeight.w600,
                      color: widget.titleColor),
                ),
              ),
              flex: 3,
            ),
            new Expanded(
              child: new FlatButton(
                  // color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).pop(_selectedData);
                  },
                  child: new Text(
                    '确定',
                    style: TextStyle(
                        fontSize: widget.confirmFontSize,
                        color: widget.confirmColor),
                  )),
              flex: 1,
            )
          ],
        ));
  }

  /// 标题和列标题之间的分割线
  Widget _horizontalSeparator() {
    return Divider(
      height: 0.3,
      indent: 0.0,
      color: Color(0xffe5e5e5),
    );
  }

  Widget _configMultiDataPickerWidget() {
    return new Container(
        height: pickerHeight,
        color: Color(0xffffffff),
        child: new Row(mainAxisSize: MainAxisSize.max, children: _pickers()));
  }

  List<Widget> _pickers() {
    List<Widget> pickers = new List();
    for (int columnIndex = 0;
        columnIndex < widget.pickerColumnSize;
        columnIndex++) {
      int initRow = 0;
      FixedExtentScrollController controller =
          new FixedExtentScrollController(initialItem: initRow);
      widget.controllers.add(controller);
      Widget picker = _configSinglePicker(
          widget.columnDataSource(columnIndex, _selectedData), columnIndex);
      pickers.add(new Expanded(flex: 1, child: picker));
    }
    return pickers;
  }

  ///选中项的字体要加粗
  TextStyle _getTextStyle(int componentIndex, int wheelIndex) {
    if (_selectedData.containsKey(componentIndex) &&
        _selectedData[componentIndex] == wheelIndex) {
      return TextStyle(
          fontSize: widget.textFontSize,
          color: widget.textColor,
          fontWeight: FontWeight.w600);
    } else {
      return TextStyle(fontSize: widget.textFontSize, color: widget.textColor);
    }
  }

  Widget _configSinglePicker(List<String> itemList, columnIndex) {
    return new KePicker(
      controller: widget.controllers[columnIndex],
      key: Key("itemValue"),
      createWidgetList: () {
        return itemList.map((v) {
          return new Center(
            child: new Text(
              v,
              style: _getTextStyle(columnIndex, itemList.indexOf(v)),
            ),
          );
        }).toList();
      },
      itemExtent: 45.0,
      changed: (int index) {
        setState(() {
          //轮盘选中的值
          _selectedData[columnIndex] = index;
          _selectedData.forEach((key, value) {
            if (key > columnIndex) {
              _selectedData[key] = 0;
              widget.controllers[key].jumpTo(0);
            }
          });
        });
      },
    );
  }
}

class KePicker extends StatefulWidget {
  final CreateWidgetList createWidgetList;
  final ValueChanged<int> changed;
  final Key key;
  final itemExtent;
  final FixedExtentScrollController controller;

  KePicker(
      {this.createWidgetList,
      this.changed,
      this.key,
      this.itemExtent = 45,
      this.controller});

  @override
  State createState() {
    return new _KePickerState();
  }
}

class _KePickerState extends State<KePicker> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new KeCupertinoPicker(
        key: widget.key,
        scrollController: widget.controller,
        itemExtent: widget.itemExtent,
        backgroundColor: Colors.white,
        squeeze: 1,
        diameterRatio: 2,
        onSelectedItemChanged: (index) {
          if (widget.changed != null) {
            widget.changed(index);
          }
        },
        children: widget.createWidgetList().length > 0
            ? widget.createWidgetList()
            : [
                new Center(
                  child: new Text(''),
                )
              ],
      ),
    );
  }
}
