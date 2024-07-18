import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({required this.product, Key? key}) : super(key: key);

  bool shouldShowDiscountedPrice() {
    final remoteConfig = FirebaseRemoteConfig.instance;
    return remoteConfig.getBool('showDiscountedPrice');
    // return false;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.network(
                product.thumbnail,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Flexible(
              child: Text(
                style: const TextStyle(
                  fontSize: 12,
                ),
                product.description,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
            shouldShowDiscountedPrice()
                ? RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '\$${product.price}',
                          style: TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.grey.withOpacity(0.5),
                            decorationThickness: 2.0,
                            color: Colors.grey.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: '  ',
                        ),
                        TextSpan(
                          text: '\$${product.discountedPrice}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: '  ',
                        ),
                        TextSpan(
                          text: '${product.discountPercentage}% off',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
