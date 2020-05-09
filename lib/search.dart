import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wholegrain/productDetails.dart';

class DataSearch extends SearchDelegate<String> {
  final recentSearch = [];
  final productName = [
    'Whole wheat bread chapatti',
    'Gardenia whole grain bread',
    'Whole wheat cake/ muffin',
    'Whole wheat pita bread',
    'Kawan whole wheat paratha',
    'KG Pastry wholemeal flower roll',
    'Belvita breakfast oat biscuit',
    'Gullon No Sugar Added Oaty Biscuit',
    'Gullon Sugar Free Digestive Biscuit',
    'Gullon Sugar Free Digestive Biscuit, Dark Choc',
    'Jacob\'s Hi Fibre',
    'Jacob\'s Low Sodium Hi-Fibre',
    'Jacob\'s Weetameal',
    'Julie\'s Oat 25 (10 Grain Cookies)',
    'Julie\'s Oat 25 (Chocolate Chips)',
    'Julie\'s Oat 25 (Strawberry)',
    'Kallo Corn Cakes, Low Fat, Lightly Salted',
    'Kallo Wholegrain Low Fat Rice & Corn Cakes, Blueberry & Vanilla',
    'Kallo Wholegrain Low Fat Rice Cakes, Organic, Lightly Salted',
    'McVitie\'s Digestive Biscuit',
    'Quaker Oat Cookies (Apple & Cinnamon)',
    'Quaker Oat Cookies (Chocolate Chips)',
    'Quaker Oat Cookies (Honey Nuts)',
    'Quaker Oat Cookies (Raisin)',
    'Sanitarium Weet-Bix Blends Hi-Bran +',
    'Sanitarium Weet-Bix Blends Multi-Grain +',
    'Sanitarium Weet-Bix, Cholesterol Lowering',
    'Sanitarium Weet-Bix, Gluten Free',
    'Sanitarium Weet-Bix, Gluten Free, with Coconut & Rice Puffs',
    'Sanitarium Weet-Bix (Kid, Organic, Original)',
    'Tesco Oaties',
    'Tesco Oaties, Milk Chocolate',
    'Walkers Mini Crunchy Oatmeal Cookies',
    'Weetabix Oatbix',
    'Weetabix Organic',
    'Weetabix Protein Chocolate Chip',
    'Weetabix, Banana Flavour',
    'Weetabix, Original',
    'Weetabix, with Chocolate',
    'Whole Wheat Biscuit',
    'Alpen Muesli, No Added Sugar',
    'Alpen Muesli, Original',
    'Carman\'s Muesli Bar, Classic Fruit & Nuts',
    'Carman\'s Muesli Bar, Original Fruit Free',
    'Carman\'s Muesli Bar, Super Berry',
    'Kalbe Fitbar Crispy Rice Bar, Chocolate',
    'Kalbe Fitbar Crispy Rice Bar, Fruits',
    'Kalbe Fitbar Crispy Rice Bar, Nuts',
    'Kellogg\'s Coco Loops',
    'Kellogg\'s Crunchy Oat Granola, Almond Treat',
    'Kellogg\'s Crunchy Oat Granola, Chocolate Sensation',
    'Kellogg\'s Mueslix, Harvest Fruit',
    'Kellogg\'s Mueslix, Raisin & Almond Crunch',
    'Kellogg\'s Special K, Oats & Honey',
    'Kellogg\'s Special K, Original',
    'Kellogg\'s Special K, Vanilla Almond',
    'Nature Valley Crunchy Cereal Bar, Oats & Chocolate',
    'Nestle Corn Flakes',
    'Nestle Fitness Bar Chocolate',
    'Nestle Fitness Bar Strawberry',
    'Nestle Fitnesse Granola, Oats & Honey',
    'Nestle Fitnesse Granola, Oats, Cranberry & Pumpkin Seeds',
    'Nestle Fitnesse, Fruits',
    'Nestle Fitnesse, Honey & Almond',
    'Nestle Fitnesse, Original',
    'Nestle Honey Gold Flakes',
    'Nestle Honey Stars Breakfast Cereals',
    'Nestle Koko Krunch Breakfast Cereal',
    'Nestle Koko Krunch Cereal Bar',
    'Nestle Koko Krunch Duo Breakfast Cereal',
    'Nestle Milo Breakfast Cereal',
    'Nestle Milo Cereal Bar',
    'Nestle Milo Protein Granola',
    'Nestle Multigrain Cheerios',
    'Organ Kids Cocoa O\'s',
    'Organ Multigrain O\'s with Quinoa',
    'Organ Rice & Millet O\'s, Wildberry Flavour',
    'Organ Wholegrain Buckwheat O\'s, Maple Flavour',
    'Post Great Grains Cereal, Banana Nut Crunch',
    'Post Great Grains Cereal, Blueberry Morning',
    'Post Great Grains Cereal, Coconut Almond Crunch',
    'Post Great Grains Cereal, Cranberry Almond Crunch',
    'Post Great Grains Cereal, Crunchy Pecans',
    'Post Great Grains Cereal, Raisins, Dates, Pecans',
    'Post Honey Bunches of Oats Cereal, Pecan & Maple Brown Sugar',
    'Post Honey Bunches of Oats Cereal Whole Grain Almond Crunch',
    'Post Honey Bunches of Oats Cereal Whole Grain Honey Crunch',
    'Post Honey Bunches of Oats Cereal, Apple Caramel Crunch',
    'Post Honey Bunches of Oats Cereal, Honey Roasted',
    'Post Honey Bunches of Oats Cereal, with Vanilla Bunches & Whole Grain Flakes',
    'Post Raisin Bran',
    'Quaker Chewy Granola Bar (Chocolate Chip, Chocolate Chunk, Cookies & Cream, Peanut Butter & Chocolate Chips)',
    'Quaker Life Multigrain Cereal, Cinnamon',
    'Quaker Life Multigrain Cereal, Original',
    'Quaker Oatmeal Square',
    'Radiant Organic Corn Flakes',
    'Radiant Organic Spelt Flakes',
    'Sanitarium Weet-Bix Bites, Apricot',
    'Sanitarium Weet-Bix Bites, Crunchy Honey',
    'Sanitarium Weet-Bix Bites, Wild Berry',
    'Sanitarium Weet-Bix Protein',
    'Sante Crunchy Muesli Bar, Banana',
    'Sante Crunchy Muesli Bar, Nuts & Almonds',
    'Sante Crunchy Muesli Bar, Plum',
    'Sante Fruit Muesli',
    'Sante Traditional Muesli',
    'Tesco Honey Nut Cluster',
    'Tesco Special Flakes, Low Fat',
    'Tesco Special Flakes, Low Fat, Honey, Oat & Almond',
    'Tesco Special Flakes, Low Fat, Red Berry',
    'Weetabix Crispy Minis, Banana',
    'Weetabix Crispy Minis, Chocolate Chips',
    'Weetabix Crispy Minis, Fruits & Nuts',
    'Weetabix Oatibix Flakes',
    'Weetabix Oatibix Flakes Red Berries',
    'Weetabix Protein Crunch, Chocolate Flavour',
    'Weetabix Protein Crunch, Original',
    'Weightwatchers Berry Flakes',
    'Weightwatchers Oven Baked Fruity Muesli',
    'Weightwatchers Oven Baked Nutty Muesli',
    'Yogood Crunchy Muesli, Chocolate & Nuts',
    'Yogood Crunchy Muesli, Fruit & Nut',
    'Yogood Crunchy Muesli, Hoeny Toasted',
    'Yogood Crunchy Muesli, Strawberry & Hazelnut',
    'Yogood Gourmet Muesli (Blissful Blueberry & Cranberry)',
    'Yogood Gourmet Muesli (Cran&berries)',
    'Yogood Gourmet Muesli (MacadaMania)',
    'Yogood Gourmet Muesli (Nuts Inc.)',
    'Ecobrown\'s Chocolate Wholegrain Rice Drink',
    'Ecobrown\'s Original Wholegrain Beverage',
    'Ecobrown\'s Low Sugar Wholegrain Rice Drink',
    'GoodMorning Vgrains 18 Grains',
    'Nestle Milo with Whole Grain Cereal',
    'Nestle Nestum Cereal with Milk',
    'Nestle Nestum with Brown Rice',
    'NutreMill Wholegrain Soy Beverage',
    'Quaker Fruit Bites Instant Oatmeal - Classic Chocolate',
    'Quaker Fruit Bites Instant Oatmeal - Milky Delight',
    'Quaker Instant Oat Porridge, Bubur Lambuk',
    'Quaker Instant Oat Porridge, Chicken Mushroom',
    'Quaker Instant Oat Porridge, Corn',
    'Oatmeal',
    'Quaker Oat Cereal Drink, Berry Burst',
    'Quaker Oat Cereal Drink, Chocolate',
    'Quaker Oat Cereal Drink, Matcha',
    'Quaker Oat Cereal Drink, Mocha',
    'Quaker Oat Cereal Drink, Original',
    'Quaker Oat Cereal Drink, Vanilla',
    'Brown Rice, Cooked',
    'Nature Quest Brown Rice Vermicelli, Uncooked',
    'Organ Super Food Pasta, Millet Quinoa Buckwheat Spirals, Uncooked',
    'Barley, Cooked (grain only)',
    'Corn',
    'Millet, Cooked',
    'Quinoa, Cooked',
    'Popcorn',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = " ";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //result shown based on string
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //result shown when search
    final suggestionList = query.isEmpty
        ? recentSearch
        : productName.where((p) => p.toUpperCase().startsWith(query.toUpperCase())).toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => StreamBuilder(
                  stream: Firestore.instance
                      .collection('product')
                      .where('product_name', isEqualTo: suggestionList[index])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Text("");
                    return Product_Details(
                      product_name: suggestionList[index],
                    );
                  })));
        },
        leading: Icon(Icons.access_time),
        title: RichText(
            text: TextSpan(
                text: suggestionList[index].substring(0, query.length),
                style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.black26),
                  )
                ])),
      ),
      itemCount: suggestionList.length,
    );
  }
}
