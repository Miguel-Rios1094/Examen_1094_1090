import 'package:flutter/material.dart';

void main() {
  runApp(RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: RestaurantMenuPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RestaurantMenuPage extends StatefulWidget {
  @override
  _RestaurantMenuPageState createState() => _RestaurantMenuPageState();
}

class _RestaurantMenuPageState extends State<RestaurantMenuPage> {
  String selectedCategory = 'Recommend';

  final List<String> categories = [
    'Recommend',
    'Popular',
    'Noodles',
    'Pizza',
    'Drinks',
  ];

  final List<Map<String, String>> foodItems = [
    {
      'title': 'Orange Sandwiches',
      'subtitle': 'No.1 in Sales',
      'price': '12',
      'image':
          'https://images.cookforyourlife.org/wp-content/uploads/2015/08/Basic-Soba-Noodles-shutterstock_1076519477-e1720050206926.jpg',
    },
    {
      'title': 'Sai Ua Samun Phrai',
      'subtitle': 'Low fat',
      'price': '18',
      'image':
          'https://images.cookforyourlife.org/wp-content/uploads/2015/08/Basic-Soba-Noodles-shutterstock_1076519477-e1720050206926.jpg',
    },
    {
      'title': 'Ratatouille Pasta',
      'subtitle': 'Highly recommended',
      'price': '17',
      'image':
          'https://images.cookforyourlife.org/wp-content/uploads/2015/08/Basic-Soba-Noodles-shutterstock_1076519477-e1720050206926.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back),
                  Icon(Icons.search),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Restaurant',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(Icons.restaurant),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("20-30 min"),
                  ),
                  SizedBox(width: 8),
                  Text("2.4km Restaurant"),
                  Spacer(),
                  Icon(Icons.star, color: Colors.amber),
                  Text(" 4.7"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('"Orange sandwiches is delicious"'),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: categories.map((category) {
                        final isSelected = category == selectedCategory;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? Colors.orange : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  if (isSelected)
                                    BoxShadow(
                                      color: Colors.orange.withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: foodItems.length,
                itemBuilder: (context, index) {
                  final item = foodItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item['image']!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(item['title']!),
                      subtitle: Text(item['subtitle']!),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('\$${item['price']!}',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FoodDetailPage(
                              title: item['title']!,
                              price: item['price']!,
                              image: item['image']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {},
        child: Icon(Icons.shopping_bag_outlined),
      ),
    );
  }
}

class FoodDetailPage extends StatefulWidget {
  final String title;
  final String price;
  final String image;

  FoodDetailPage(
      {required this.title, required this.price, required this.image});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int quantity = 1;

  void increment() => setState(() => quantity++);
  void decrement() => setState(() {
        if (quantity > 1) quantity--;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back)),
                    Icon(Icons.favorite_border),
                  ],
                ),
                SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(widget.image, height: 150),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer, size: 20),
              SizedBox(width: 4),
              Text('50 min'),
              SizedBox(width: 16),
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text('4.8'),
              SizedBox(width: 16),
              Icon(Icons.local_fire_department, color: Colors.red, size: 20),
              SizedBox(width: 4),
              Text('325 kcal'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('\$${widget.price}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(width: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: decrement,
                      child: Icon(Icons.remove, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Text(quantity.toString(),
                        style: TextStyle(color: Colors.white)),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: increment,
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text('Ingredients',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: ['Noodle', 'Shrimp', 'Egg', 'Scallion'].map((ingredient) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.orange[100],
                    child: Icon(Icons.fastfood, color: Colors.orange),
                  ),
                  SizedBox(height: 6),
                  Text(ingredient),
                ],
              );
            }).toList(),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Dashi is the sort of super-rich broth...',
                    style: TextStyle(fontSize: 14)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {},
                      backgroundColor: Colors.orange,
                      child: Icon(Icons.shopping_bag_outlined),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.white,
                        child:
                            Text('$quantity', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
