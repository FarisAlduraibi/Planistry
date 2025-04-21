import 'package:flutter/material.dart';
import '../utils/constants.dart';

class PlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Data for the table
    final List<PlanItem> planItems = [
      PlanItem('1.1\nslides 22 > 30', '19/4/2025\n13:00 - 14:00', 'Linked list'),
      PlanItem('1.2\nslides 1 > 15', '20/4/2025\n13:00 - 14:00', 'Linked list'),
      PlanItem('1.2\nslides 16 > 30', '21/4/2025\n13:00 - 14:00', 'Linked list'),
      PlanItem('1.3\nslides 1 > 20', '22/4/2025\n13:00 - 14:00', 'Linked list'),
      PlanItem('1.3\nslides 1 > 20', '22/4/2025\n13:00 - 14:00', 'Linked list'),
      PlanItem('1.3\nslides 1 > 20', '22/4/2025\n13:00 - 14:00', 'Linked list'),
      PlanItem('1.3\nslides 1 > 20', '22/4/2025\n13:00 - 14:00', 'Linked list'),
      PlanItem('1.3\nslides 1 > 20', '22/4/2025\n13:00 - 14:00', 'Linked list'),
      PlanItem('1.3\nslides 1 > 20', '22/4/2025\n13:00 - 14:00', 'Linked list'),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CS 432',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              'Plan 01',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Table header
          Container(
            color: Colors.blue,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Chapter',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Date & Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Content',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Table content
          Expanded(
            child: ListView.builder(
              itemCount: planItems.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              planItems[index].chapter,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              planItems[index].dateTime,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              planItems[index].content,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey.shade300,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlanItem {
  final String chapter;
  final String dateTime;
  final String content;

  PlanItem(this.chapter, this.dateTime, this.content);
}