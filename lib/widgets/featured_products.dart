// import 'package:flutter/material.dart';
// import 'package:my_food_ordering_app/helpers/styles.dart';
// import 'package:my_food_ordering_app/models/products.dart';
// import 'package:my_food_ordering_app/widgets/title.dart';

// import '../helpers/screen_navigation.dart';
// import '../screens/details_screen.dart';

// class FeaturedProduct extends StatelessWidget {
//   const FeaturedProduct({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Products> featuredProduct = [
//       Products(
//           name: "Cereals",
//           image: "1.jpg",
//           rating: 4.7,
//           price: 12.99,
//           vendor: "Good Food",
//           wishList: true),
//       Products(
//         name: "Pizza",
//         image: "2.jpg",
//         rating: 3.7,
//         price: 10.99,
//         vendor: "Good Food",
//         wishList: true,
//       ),
//       Products(
//         name: "Biryani",
//         image: "3.jpg",
//         rating: 4.1,
//         price: 15.99,
//         vendor: "Good Food",
//         wishList: true,
//       ),
//       Products(
//         name: "Salad",
//         image: "4.jpeg",
//         rating: 3.9,
//         price: 20.99,
//         vendor: "Good Food",
//         wishList: true,
//       ),
//       Products(
//         name: "Mix Veg",
//         image: "5.jpg",
//         rating: 4.5,
//         price: 11.99,
//         vendor: "Good Food",
//         wishList: false,
//       ),
//     ];

//     // ignore: sized_box_for_whitespace
//     return Container(
//       height: 230,
//       child: ListView.builder(
//         itemCount: featuredProduct.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) => Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GestureDetector(
//             onTap: () {
//               changeScreen(
//                 context,
//                 DetailsScreen(
//                   product: featuredProduct[index],
//                 ),
//               );
//             },
//             child: Container(
//               height: 240,
//               width: 200,
//               decoration: const BoxDecoration(
//                 color: white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color.fromARGB(255, 235, 204, 202),
//                     offset: Offset(15, 5),
//                     blurRadius: 30,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     "assets/images/${featuredProduct[index].image}",
//                     height: 140,
//                     width: 140,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: TitleWidget(
//                           text: featuredProduct[index].name,
//                           size: 16,
//                           colors: black,
//                           weight: FontWeight.normal,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             color: white,
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: grey,
//                                 offset: Offset(1, 1),
//                                 blurRadius: 4,
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(4.0),
//                             child: featuredProduct[index].wishList
//                                 ? const Icon(
//                                     Icons.favorite,
//                                     size: 18,
//                                     color: red,
//                                   )
//                                 : const Icon(
//                                     Icons.favorite_border,
//                                     size: 18,
//                                     color: red,
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: TitleWidget(
//                               text: featuredProduct[index].rating.toString(),
//                               size: 14,
//                               colors: grey,
//                               weight: FontWeight.normal,
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 2,
//                           ),
//                           const Icon(
//                             Icons.star,
//                             size: 16,
//                             color: red,
//                           ),
//                           const Icon(
//                             Icons.star,
//                             size: 16,
//                             color: red,
//                           ),
//                           const Icon(
//                             Icons.star,
//                             size: 16,
//                             color: red,
//                           ),
//                           const Icon(
//                             Icons.star,
//                             size: 16,
//                             color: red,
//                           ),
//                           const Icon(
//                             Icons.star,
//                             size: 16,
//                             color: grey,
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 8.0),
//                         child: TitleWidget(
//                           text: "\$${featuredProduct[index].price}",
//                           size: 16,
//                           colors: black,
//                           weight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedImage extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback imageTap;
  const FeaturedImage(
      {Key? key,
      required this.image,
      required this.text,
      required this.imageTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.5),
      child: InkWell(
        onTap: imageTap,
        child: Column(
          children: [
            CircleAvatar(
              radius: 35.sp,
              child: Image.asset(
                image,
                width: 90.w,
                height: 90.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
