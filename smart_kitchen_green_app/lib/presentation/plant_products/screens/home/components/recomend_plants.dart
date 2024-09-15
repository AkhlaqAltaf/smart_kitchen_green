import 'package:flutter/material.dart';
import 'package:smart_kitchen_green_app/apis/plant_apis/recommended_plants.dart';
import 'package:smart_kitchen_green_app/data_layer/plants/plant.dart';
import 'package:smart_kitchen_green_app/presentation/plant_products/screens/details/details_screen.dart';

import '../../../constants.dart';

class RecomendPlants extends StatefulWidget {
  const RecomendPlants({super.key});

  @override
  State<RecomendPlants> createState() => _RecomendPlantsState();
}

class _RecomendPlantsState extends State<RecomendPlants> {
  @override
  void initState() {
    super.initState();
    fetchPlants();
  }

  List<Plant> plants = [];

  void fetchPlants() async {
    try {
      plants = await fetchRecomendations(context);
      
      if (plants.isNotEmpty) {
        print("PLANT IMAGE:" + plants.first.img);
      } else {
        print("No plants found");
      }
      setState(() {});
    } catch (e) {
      print("Error fetching plants: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          plants.length,
          (index) => RecomendPlantCard(
            image: plants[index].img,
            title: plants[index].name,
            category: plants[index].category,
            index: index,
          ),
        ),
      ),
    );
  }
}

class RecomendPlantCard extends StatelessWidget {
  final String image, title;
  final String category;
  final int index;
  const RecomendPlantCard({
    required this.image,
    required this.title,
    required this.category,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          image.startsWith('http')
              ? Image.network(image) // For network images
              : Image.asset(image), // For asset images
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$title\n".toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        TextSpan(
                          text: "$title".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$category',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: kPrimaryColor),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
