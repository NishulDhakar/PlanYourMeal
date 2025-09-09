import 'package:flutter/material.dart';

class WeeklyPlanPage extends StatefulWidget {
  const WeeklyPlanPage({super.key});

  @override
  State<WeeklyPlanPage> createState() => _WeeklyPlanPageState();
}

class _WeeklyPlanPageState extends State<WeeklyPlanPage> {
  int selectedDay = DateTime.now().weekday - 1;

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final List<String> daysShort = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  // Sample meal plan data
  final Map<int, Map<String, List<Map<String, String>>>> weeklyPlan = {
    0: { // Monday
      'breakfast': [
        {'name': 'Oatmeal with Berries', 'calories': '320', 'time': '8:00 AM'},
        {'name': 'Green Tea', 'calories': '5', 'time': '8:30 AM'},
      ],
      'lunch': [
        {'name': 'Grilled Chicken Salad', 'calories': '450', 'time': '1:00 PM'},
        {'name': 'Apple', 'calories': '80', 'time': '1:45 PM'},
      ],
      'dinner': [
        {'name': 'Salmon with Vegetables', 'calories': '380', 'time': '7:00 PM'},
        {'name': 'Brown Rice', 'calories': '150', 'time': '7:00 PM'},
      ]
    },
    1: { // Tuesday
      'breakfast': [
        {'name': 'Greek Yogurt with Granola', 'calories': '280', 'time': '8:00 AM'},
        {'name': 'Orange Juice', 'calories': '110', 'time': '8:30 AM'},
      ],
      'lunch': [
        {'name': 'Turkey Sandwich', 'calories': '400', 'time': '1:00 PM'},
        {'name': 'Banana', 'calories': '105', 'time': '1:45 PM'},
      ],
      'dinner': [
        {'name': 'Pasta with Marinara', 'calories': '420', 'time': '7:00 PM'},
        {'name': 'Caesar Salad', 'calories': '180', 'time': '7:00 PM'},
      ]
    },
    // Add more days as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildWeekSelector(),
          _buildMealPlanCard(),
          Expanded(
            child: _buildMealsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMealDialog();
        },
        backgroundColor: const Color(0xff92A3FD),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Weekly Plan',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.black,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeekSelector() {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          bool isSelected = selectedDay == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDay = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              width: 70,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xff92A3FD) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    daysShort[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealPlanCard() {
    int totalCalories = _calculateTotalCalories();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffC58BF2), Color(0xff92A3FD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            days[selectedDay],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCalorieInfo('Breakfast', _getMealCalories('breakfast')),
              _buildCalorieInfo('Lunch', _getMealCalories('lunch')),
              _buildCalorieInfo('Dinner', _getMealCalories('dinner')),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              'Total: $totalCalories cal',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieInfo(String meal, int calories) {
    return Column(
      children: [
        Text(
          meal,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '$calories',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMealsList() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildMealSection('Breakfast', Icons.free_breakfast, const Color(0xffFF6B6B)),
          const SizedBox(height: 20),
          _buildMealSection('Lunch', Icons.lunch_dining, const Color(0xff4A90E2)),
          const SizedBox(height: 20),
          _buildMealSection('Dinner', Icons.dinner_dining, const Color(0xffFF9500)),
        ],
      ),
    );
  }

  Widget _buildMealSection(String mealType, IconData icon, Color color) {
    List<Map<String, String>> meals = _getMealsForDay(mealType.toLowerCase());
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 12),
                Text(
                  mealType,
                  style: TextStyle(
                    color: color,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ...meals.map((meal) => _buildMealItem(meal, color)).toList(),
          if (meals.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'No meals planned for ${mealType.toLowerCase()}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMealItem(Map<String, String> meal, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal['name'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${meal['calories']} cal',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      meal['time'] ?? '',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.edit,
              color: Colors.grey[400],
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getMealsForDay(String mealType) {
    return weeklyPlan[selectedDay]?[mealType] ?? [];
  }

  int _getMealCalories(String mealType) {
    List<Map<String, String>> meals = _getMealsForDay(mealType);
    return meals.fold(0, (sum, meal) => sum + int.parse(meal['calories'] ?? '0'));
  }

  int _calculateTotalCalories() {
    return _getMealCalories('breakfast') + 
           _getMealCalories('lunch') + 
           _getMealCalories('dinner');
  }

  void _showAddMealDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Meal'),
          content: const Text('Add meal functionality coming soon!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}