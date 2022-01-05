import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/record_cell.dart';
import 'package:ridbrain_project/screens/record_screen.dart';
import 'package:ridbrain_project/services/app_bar.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/objects.dart';
import 'package:ridbrain_project/services/prefs_handler.dart';

class AcceptOrdersScreen extends StatefulWidget {
  const AcceptOrdersScreen({Key? key}) : super(key: key);

  @override
  _AcceptOrdersScreenState createState() => _AcceptOrdersScreenState();
}

class _AcceptOrdersScreenState extends State<AcceptOrdersScreen> {
  List<Record> _records = [];
  bool _loading = true;
  bool _first = true;

  void _updateList(String token) async {
    setState(() {
      _loading = true;
    });

    var result = await Network.getActiveRecords(token);

    if (mounted) {
      setState(() {
        _records = result;
        _loading = false;
      });
    }
  }

  void _updateRecord(Record record) {
    var index = 0;
    for (var item in _records) {
      if (item.recordId == record.recordId) {
        setState(() {
          _records[index] = record;
        });
        break;
      }
      index++;
    }
  }

  Widget _getRecordList() {
    if (_loading) {
      return SliverToBoxAdapter(
        child: Container(
          height: 400,
          child: CupertinoActivityIndicator(),
        ),
      );
    }
    if (_records.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          height: 400,
          alignment: Alignment.center,
          child: Text(
            "Принятых к исполнению заявок нет",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return RecordCell(
            record: _records[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordScreen(
                    record: _records[index],
                    update: _updateRecord,
                  ),
                ),
              );
            },
          );
        },
        childCount: _records.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    if (_first) {
      _updateList(provider.driver.driverToken);
      _first = false;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          StandartAppBar(
            title: Text("Принятые заявки"),
          ),
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 120.0,
            refreshIndicatorExtent: 50.0,
            onRefresh: () async {
              _updateList(provider.driver.driverToken);
            },
          ),
          _getRecordList(),
        ],
      ),
    );
  }
}
