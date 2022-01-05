import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:ridbrain_project/screens/record_cell.dart';
import 'package:ridbrain_project/screens/record_screen.dart';
import 'package:ridbrain_project/services/app_bar.dart';
import 'package:ridbrain_project/services/convert_date.dart';
import 'package:ridbrain_project/services/extentions.dart';
import 'package:ridbrain_project/services/network.dart';
import 'package:ridbrain_project/services/objects.dart';
import 'package:table_calendar/table_calendar.dart';

import '../services/prefs_handler.dart';

class NewOrdersScreen extends StatefulWidget {
  const NewOrdersScreen({Key? key}) : super(key: key);

  @override
  _NewOrdersScreenState createState() => _NewOrdersScreenState();
}

class _NewOrdersScreenState extends State<NewOrdersScreen> {
  static final _today = ConvertDate.dayBegin();
  static final _firstDay = DateTime(_today.year, _today.month, _today.day - 1);
  static final _lastDay = DateTime(_today.year, _today.month + 3, _today.day);

  DateTime _focusedDay = _today;
  DateTime _selectedDay = _today;

  List<Record> _records = [];
  bool _loading = true;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    var select = selectedDay.toLocal().add(
          Duration(
            hours: -selectedDay.toLocal().hour,
            minutes: -selectedDay.toLocal().minute,
          ),
        );
    var focused = focusedDay.toLocal().add(
          Duration(
            hours: -focusedDay.toLocal().hour,
            minutes: -focusedDay.toLocal().minute,
          ),
        );

    if (!isSameDay(_selectedDay, select)) {
      setState(() {
        _selectedDay = select;
        _focusedDay = focused;
      });
    }
  }

  void _updateList(String token) async {
    setState(() {
      _loading = true;
    });

    var result = await Network.getRecords(token);

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
          _records.removeAt(index);
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
    if (_records.forDate(_selectedDay).isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          height: 400,
          alignment: Alignment.center,
          child: Text(
            "Заявок в этот день нет",
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
          var record = _records.forDate(_selectedDay)[index];
          return RecordCell(
            record: record,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecordScreen(
                  record: record,
                  update: _updateRecord,
                ),
              ),
            ),
          );
        },
        childCount: _records.forDate(_selectedDay).length,
      ),
    );
  }

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DriverProvider>(context);

    if (_records.isEmpty) {
      _updateList(provider.driver.driverToken);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          StandartAppBar(
            title: Text("Новые заявки"),
          ),
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 120.0,
            refreshIndicatorExtent: 50.0,
            onRefresh: () async {
              _updateList(provider.driver.driverToken);
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              child: TableCalendar<Record>(
                locale: "ru",
                firstDay: _firstDay,
                lastDay: _lastDay,
                headerVisible: false,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: CalendarFormat.twoWeeks,
                eventLoader: _records.forDate,
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: _onDaySelected,
                calendarStyle: CalendarStyle(
                  markerSize: 7,
                  markersMaxCount: 3,
                  markerMargin: const EdgeInsets.all(0.8),
                  markerDecoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.circle,
                  ),
                ),
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
              ),
            ),
          ),
          _getRecordList(),
        ],
      ),
    );
  }
}
