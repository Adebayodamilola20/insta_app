import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Imagepicker extends StatefulWidget {
  const Imagepicker({super.key});

  @override
  State<Imagepicker> createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker>
    with SingleTickerProviderStateMixin {
  late TabController _tabController3;

  @override
  void initState() {
    super.initState();
    _tabController3 = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage listing'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: const Color.fromARGB(133, 238, 238, 238),
          ),
          padding: EdgeInsets.all(4.0),
          child: TabBar(
            isScrollable: true,
            controller: _tabController3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicator: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30.0),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                child: Text(
                  'Active',
                  style: TextStyle(fontWeight: FontWeight.w900,
                  fontSize: 16),
                ),
              ),
              Tab(child: Text('Closed',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 17
              ),)),
              Tab(child: Text('Sold',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16
              ),)),
            ],
          ),
        ),
      ),
    );
  }
}
