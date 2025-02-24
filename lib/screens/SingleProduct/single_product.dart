import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:phone_accessories_shop/theme/colors_theme.dart';
import 'package:phone_accessories_shop/theme/text_theme.dart';

class SingleProduct extends StatefulWidget {
  final String productId;
  final String productType;

  const SingleProduct({
    super.key,
    required this.productId,
    required this.productType,
  });

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  Map<String, dynamic>? productData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    final url = Uri.parse(
      'http://192.168.1.57:3000/api/products/${widget.productType}/${widget.productId}',
    );

    print("Fetching: $url");

    try {
      final response = await http.get(url);
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          productData = data;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load product');
      }
    } catch (error) {
      print("Error fetching product: $error");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: const Text("Product Details")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : productData == null
              ? const Center(child: Text("Error loading product"))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: (productData?['gallery_images']
                                    as List<dynamic>?)
                                ?.map(
                              (imageUrl) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 16.0),
                                  width: 250,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: thirdColor,
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl.toString(),
                                    width: 250,
                                    height: 280,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                    ),
                                  ),
                                );
                              },
                            ).toList() ??
                            [],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productData?['title'] ?? 'No Title',
                            style: AppTextStyles.getSubtitleSize(),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "\$${productData?['price'] ?? '0.00'}",
                            style: AppTextStyles.getTitleSize(),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            productData?['short_description'] ??
                                'No description available',
                            style: AppTextStyles.getSIMISubtitleSize(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
