import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/widgets/custom_appbar.dart';
import 'package:smart_kitchen_green_app/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar:appBar("Home Screen"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Image.asset(
                "assets/logo/circle.png",
                height: 150.0,
                width: 150.0,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to SmartKitchenGreen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'An innovative app designed to merge kitchen and garden management into a unified, environmentally-friendly process.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              _buildFeatureCard(
                icon: Icons.inventory,
                title: 'Integrated Grocery Assistant',
                description:
                'Keep a detailed list of all kitchen items, track their availability, and manage expiry dates efficiently.',
              ),
              _buildFeatureCard(
                icon: Icons.notifications,
                title: 'Expiry Date Notifications',
                description:
                'Get alerts about products nearing their expiry dates to minimize food waste.',
              ),
              _buildFeatureCard(
                icon: Icons.kitchen,
                title: 'Kitchen Appliance Connectivity',
                description:
                'Connect with your kitchen appliances for helpful tips and information.',
              ),
              _buildFeatureCard(
                icon: Icons.receipt,
                title: 'Recipe Recommender',
                description:
                'Discover recipes based on your current inventory and reduce food waste.',
              ),
              _buildFeatureCard(
                icon: Icons.nature,
                title: 'Vegetable Garden Planning',
                description:
                'Plan your vegetable garden and plant arrangements for optimal growth.',
              ),
              _buildFeatureCard(
                icon: Icons.calendar_today,
                title: 'Digital Care Calendar',
                description:
                'Manage your garden’s progress and maintenance tasks with a digital calendar.',
              ),
              _buildFeatureCard(
                icon: Icons.info,
                title: 'Plant Care Information',
                description:
                'Access detailed information about plant care, including watering schedules and nutrition needs.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String title, required String description}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.green[700]),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
