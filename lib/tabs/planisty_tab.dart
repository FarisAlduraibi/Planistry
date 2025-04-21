import 'package:flutter/material.dart';
import 'package:gr/tabs/PlanScreen.dart';

import '../utils/constants.dart';

class PlanistyTab extends StatelessWidget {
  // Sample data - replace with your actual data source
  final List<Map<String, dynamic>> plans = [
    {
      'id': '01',
      'title': 'Plan 01',
    },
    // Add more plans as needed
  ];

  @override
  Widget build(BuildContext context) {
    bool hasPlans = plans.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: hasPlans
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: plans.length,
            itemBuilder: (context, index) {
              final plan = plans[index];
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      plan['title'],
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Delete functionality
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlanScreen()),
                );
              },
              child: Text('Generate Plan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/planistry.png',
            width: 150,
            height: 150,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/planistry.png',
                width: 150,
                height: 150,
              );
            },
          ),
          SizedBox(height: 24),
          Text(
            'You have no Plan Yet.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlanScreen()),
              );
            },
            child: Text('Generate Plan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              minimumSize: Size(200, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}