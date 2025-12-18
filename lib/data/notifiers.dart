import 'package:flutter/material.dart';

ValueNotifier<int> selectedValueNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkmode = ValueNotifier(false);
ValueNotifier<bool> isRedMode = ValueNotifier(false);
ValueNotifier<bool> isRedMode2 = ValueNotifier(false);
ValueNotifier<bool> isRedMode3 = ValueNotifier(false);
ValueNotifier<bool> isDarkMode = ValueNotifier(false);

ValueNotifier<List<Map<String, dynamic>>> productDataNotifier = ValueNotifier([
  {
    'title': 'Dell Latitude 7420',
    'price': '₦550000',
    'location': 'Gbagada Phase II/bariga',
    'images': [
      'assets/images/IMG_2716.jpg',
      'assets/images/IMG_2717.jpg',
      'assets/images/IMG_2718.jpg',
      'assets/images/IMG_2719.jpg',
    ],
    'duration': Duration(days: 9, hours: 9, minutes: 57, seconds: 59),
    'description':
        'The Dell Latitude 7420 is a professional business laptop that delivers exceptional performance and reliability for demanding work environments.',
    'category': 'Laptops',
    'condition': 'Like new',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Gbagada/Phase II, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'Black Bluetooth',
    'price': '₦50,000',
    'location': 'Victoria Island',
    'images': ['assets/images/IMG_2780.jpg', 'assets/images/IMG_2781.jpg'],
    'duration': Duration(days: 5, hours: 12, minutes: 30, seconds: 45),
    'description':
        'The Soundcore 3 is a portable Bluetooth speaker that delivers high-quality stereo sound, deep bass, and long battery life for wireless music playback.',
    'category': 'Electronics',
    'condition': 'Like new',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Ajah/Sangotedo, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'MacBook Pro 2020',
    'price': '₦850000',
    'location': 'Ikeja GRA',
    'images': [
      'assets/images/IMG_2782.jpg',
      'assets/images/IMG_2783.jpg',
      'assets/images/IMG_2785.jpg',
    ],
    'duration': Duration(days: 3, hours: 8, minutes: 15, seconds: 20),
    'description':
        'Apple MacBook Pro 2020 model with M1 chip, delivering incredible performance and battery life for professional creative work.',
    'category': 'Laptops',
    'condition': 'Excellent',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Ikeja/GRA, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'Lenovo ThinkPad X1',
    'price': '₦680000',
    'location': 'Lekki Phase 1',
    'images': ['assets/images/IMG_2789.jpg', 'assets/images/IMG_2788.jpg'],
    'duration': Duration(days: 7, hours: 15, minutes: 45, seconds: 30),
    'description':
        'Lenovo ThinkPad X1 Carbon is an ultralight business laptop with premium build quality and enterprise-grade security features.',
    'category': 'Laptops',
    'condition': 'Good',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Lekki/Phase 1, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'Asus ROG Gaming',
    'price': '₦920000',
    'location': 'Surulere',
    'images': [
      'assets/images/IMG_2790.jpg',
      'assets/images/IMG_2791.jpg',
      'assets/images/IMG_2792.jpg',
    ],
    'duration': Duration(days: 2, hours: 18, minutes: 20, seconds: 10),
    'description':
        'Asus ROG gaming laptop with powerful graphics card and high refresh rate display for immersive gaming experience.',
    'category': 'Gaming Laptops',
    'condition': 'Like new',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Surulere, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'Surface Laptop 4',
    'price': '₦750000',
    'location': 'Yaba',
    'images': [
      'assets/images/IMG_2978.jpg',
      'assets/images/IMG_2979.jpg',
      'assets/images/IMG_2980.jpg',
    ],
    'duration': Duration(days: 4, hours: 6, minutes: 40, seconds: 55),
    'description':
        'Microsoft Surface Laptop 4 combines elegant design with powerful performance for productivity and entertainment.',
    'category': 'Laptops',
    'condition': 'Like new',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Yaba, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'Acer Swift 3',
    'price': '₦380000',
    'location': 'Maryland',
    'images': [
      'assets/images/IMG_2982.jpg',
      'assets/images/IMG_2983.jpg',
      'assets/images/IMG_2985.jpg',
    ],
    'duration': Duration(days: 1, hours: 22, minutes: 10, seconds: 5),
    'description':
        'Acer Swift 3 is a lightweight and affordable laptop perfect for students and everyday computing tasks.',
    'category': 'Laptops',
    'condition': 'Good',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Maryland, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'Dell XPS 13',
    'price': '₦890000',
    'location': 'Ajah',
    'images': [
      'assets/images/IMG_2986.jpg',
      'assets/images/IMG_2987.jpg',
      'assets/images/IMG_2988.jpg',
    ],
    'duration': Duration(days: 6, hours: 14, minutes: 25, seconds: 40),
    'description':
        'Dell XPS 13 features stunning InfinityEdge display and premium build quality in an ultra-compact design.',
    'category': 'Laptops',
    'condition': 'Excellent',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Ajah, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'HP Pavilion 15',
    'price': '₦450000',
    'location': 'Festac',
    'images': [
      'assets/images/IMG_2989.jpg',
      'assets/images/IMG_2990.jpg',
      'assets/images/IMG_2991.jpg',
    ],
    'duration': Duration(days: 8, hours: 10, minutes: 35, seconds: 15),
    'description':
        'HP Pavilion 15 offers reliable performance and generous screen size for work and entertainment.',
    'category': 'Laptops',
    'condition': 'Good',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Festac, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'HP Pavilion 15',
    'price': '₦450000',
    'location': 'Festac',
    'images': [
      'assets/images/IMG_2992.jpg',
      'assets/images/IMG_2993.jpg',
      'assets/images/IMG_2994.jpg',
    ],
    'duration': Duration(days: 8, hours: 10, minutes: 35, seconds: 15),
    'description':
        'HP Pavilion 15 offers reliable performance and generous screen size for work and entertainment.',
    'category': 'Laptops',
    'condition': 'Good',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Festac, Lagos',
    'createdAt': DateTime.now(),
  },
  {
    'title': 'HP Pavilion 15',
    'price': '₦450000',
    'location': 'Festac',
    'images': [
      'assets/images/IMG_2996.jpg',
      'assets/images/IMG_2999.PNG',
      'assets/images/IMG_2998.jpg',
    ],
    'duration': Duration(days: 8, hours: 10, minutes: 35, seconds: 15),
    'description':
        'HP Pavilion 15 offers reliable performance and generous screen size for work and entertainment.',
    'category': 'Laptops',
    'condition': 'Good',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Festac, Lagos',
    'createdAt': DateTime.now(),
  },
]);
