import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;
import 'package:greengrocer/src/pages/home/components/category_tile.dart';
import 'package:greengrocer/src/pages/home/components/item_tile.dart';
import 'package:greengrocer/src/pages/widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages/widgets/custom_shimmer.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  final UtilsServices utilsServices = UtilsServices();

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 15),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: Colors.orange,
                badgeContent: const Text(
                  '2',
                  style: TextStyle(color: Colors.white),
                ),
                child: AddToCartIcon(
                  key: globalKeyCartItems,
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCartAnimationMethod) {
          runAddToCartAnimation = addToCartAnimationMethod;
        },
        child: Column(
          children: [
            //Campo de pesquisa
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: "Pesquise aqui",
                  prefixIcon: const Icon(Icons.search, color: Colors.red),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                ),
              ),
            ),

            //Categorias
            Container(
              padding: const EdgeInsets.only(left: 25),
              height: 40,
              child: !isLoading
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => CategoryTile(
                        onPressed: () {
                          setState(() {
                            selectedCategory = app_data.categories[index];
                          });
                        },
                        category: app_data.categories[index],
                        isSelected:
                            app_data.categories[index] == selectedCategory,
                      ),
                      separatorBuilder: (_, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: app_data.categories.length,
                    )
                  : ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(10, (index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 12),
                          alignment: Alignment.center,
                          child: CustomShimmer(
                            borderRadius: BorderRadius.circular(10),
                            height: 20,
                            width: 80,
                          ),
                        );
                      }),
                    ),
            ),

            //GridView
            Expanded(
              child: !isLoading
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                      ),
                      itemCount: app_data.items.length,
                      itemBuilder: (_, index) {
                        return ItemTile(
                          item: app_data.items[index],
                          cartAnimationMethod: itemSelectedCartAnimations,
                        );
                      },
                    )
                  : GridView.count(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                      children: List.generate(
                        10,
                        (index) {
                          return CustomShimmer(
                            borderRadius: BorderRadius.circular(10),
                            height: double.infinity,
                            width: double.infinity,
                          );
                        },
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
