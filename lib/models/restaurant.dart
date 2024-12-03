import 'package:collection/collection.dart';
import 'package:damaz/models/cart_item.dart';
import 'package:damaz/models/food.dart';
import 'package:flutter/material.dart';

class Restaurant extends ChangeNotifier{
  // list of food menu
  final List<Food> _menu = [
    // burgers
    Food(
      name: "Classic Cheeseburger", 
      description: "A juicy beef patty with melted cheddar, lettuce, tomato, and a hint of onion and picle.", 
      imagePath: "lib/images/burgers/cheese_burger.jpeg", 
      price: 0.99, 
      category: FoodCategory.burgers, 
      availableAddons: [
        Addon(name: "Extra cheese", price: 0.99),
        Addon(name: "Bacon", price: 1.99),
        Addon(name: "Avocado", price: 2.99),
      ],
    ),

      Food(
      name: "BBQ Bacon Burger", 
      description: 
          "Smoky BBQ sauce, crispy bacon, and onion rings make this beef burger a savory delight.", 
      imagePath: "lib/images/burgers/bbq_burger.jpeg", 
      price: 10.99, 
      category: FoodCategory.burgers, 
      availableAddons: [
        Addon(name: "Grilled Onions", price: 0.99),
        Addon(name: "Jalapenos", price: 1.49),
        Addon(name: "Extra BBQ Sauce", price: 1.99),
      ],
    ),

      Food(
      name: "Veggie Burger", 
      description: 
         "A hearty veggie patty topped with fresh avocado, lettuce, and tomato, served on a whole.", 
      imagePath: "lib/images/burgers/vege_burger.jpeg", 
      price: 9.99, 
      category: FoodCategory.burgers, 
      availableAddons: [
        Addon(name: "Vegan Cheese", price: 0.99),
        Addon(name: "Grilled Mushrooms", price: 1.49),
        Addon(name: "Hummus Spread", price: 1.99),
      ],
    ),

      Food(
      name: "Blue Moon Burger", 
      description: 
         "This burger is a blue cheese lover's dream. It features a succulent ground beef patty.", 
      imagePath: "lib/images/burgers/bluemoon_burger.jpeg", 
      price: 9.49, 
      category: FoodCategory.burgers, 
      availableAddons: [
        Addon(name: "Sauteed Mushrooms", price: 0.99),
        Addon(name: "Fried Egg", price: 1.49),
        Addon(name: "Spicy Mayo", price: 0.99),
      ],
    ),

    // salads
      Food(
      name: "Caesar Salad", 
      description: 
        "Crisp romaine lettuce, parmesan cheese, croutons, and Caesar dressing.", 
      imagePath: "lib/images/salads/caesar_salad.jpeg", 
      price: 7.99, 
      category: FoodCategory.salads, 
      availableAddons: [
        Addon(name: "Grilled Chicken", price: 0.99),
        Addon(name: "Anchovies", price: 1.99),
        Addon(name: "Extra Parmesan", price: 1.99),
      ],
    ),

    Food(
      name: "Greek Salad", 
      description: 
        "Tomatoes, cucmbers, red onions, olives, feta cheese with olive oil and herbs.", 
      imagePath: "lib/images/salads/greek_salad.jpeg", 
      price: 8.49, 
      category: FoodCategory.salads, 
      availableAddons: [
        Addon(name: "Feta Cheese", price: 0.99),
        Addon(name: "Kalamata Olives", price: 1.49),
        Addon(name: "Grilled Shrimp", price: 1.99),
      ],
    ),

    Food(
      name: "Quinoa Salad", 
      description: 
        "Quinoa mixed with cucumbers, tomatoes, bell peppers, and a lemon vinaigrette.", 
      imagePath: "lib/images/salads/quinoa.jpeg", 
      price: 9.99, 
      category: FoodCategory.salads, 
      availableAddons: [
        Addon(name: "Avocado", price: 0.99),
        Addon(name: "Feta Cheese", price: 1.49),
        Addon(name: "Grilled Chicken", price: 1.99),
      ],
    ),

    Food(
      name: "Asian Sesame Salad", 
      description: 
        "Delight in the flavors of the east with this sesame-infused salad. It includes mixed stuffs.", 
      imagePath: "lib/images/salads/asiansesame_salad.jpeg", 
      price: 7.99, 
      category: FoodCategory.salads, 
      availableAddons: [
        Addon(name: "Mandarin Oranges", price: 0.99),
        Addon(name: "Almond Slivers", price: 1.49),
        Addon(name: "Extra Teriyaka", price: 1.99),
      ],
    ),

    Food(
      name: "South West Chiken Salad", 
      description: 
        "Crisp romaine lettuce, parmesan cheese, croutons, and Caesar dressing.", 
      imagePath: "lib/images/salads/caesar_salad.jpeg", 
      price: 7.99, 
      category: FoodCategory.salads, 
      availableAddons: [
        Addon(name: "Grilled Chicken", price: 0.99),
        Addon(name: "Anchovies", price: 1.99),
        Addon(name: "Extra Parmesan", price: 1.99),
      ],
    ),

    // sides
    Food(
      name: "Sweet Potato Fries", 
      description: 
        "Crispy sweet potato fries with a touch of salt.", 
      imagePath: "lib/images/sides/sweet_potato_side.jpeg", 
      price: 4.99, 
      category: FoodCategory.sides, 
      availableAddons: [
        Addon(name: "Cheese Sauce", price: 0.99),
        Addon(name: "Truffle Oil", price: 1.49),
        Addon(name: "Cajun Spice", price: 1.99),
      ],
    ),

     Food(
      name: "Onions Rings", 
      description: 
        "Golden and crispy onion rings, perfect for dipping.", 
      imagePath: "lib/images/sides/onionrings_side.jpeg", 
      price: 3.99, 
      category: FoodCategory.sides, 
      availableAddons: [
        Addon(name: "Ranch Dip", price: 0.99),
        Addon(name: "Spicy Mayo", price: 1.49),
        Addon(name: "Parmesan Dust", price: 1.99),
      ],
    ),

    Food(
      name: "Garlic Bread", 
      description: 
        "Warm and toasty garlic bread, topped with melted butter and parsley.", 
      imagePath: "lib/images/sides/garlic_bread_side.jpeg", 
      price: 3.99, 
      category: FoodCategory.sides, 
      availableAddons: [
        Addon(name: "Extra Garlic", price: 0.99),
        Addon(name: "Mozzarella Cheese", price: 1.49),
        Addon(name: "Marinara Dip", price: 1.99),
      ],
    ),

    Food(
      name: "Loaded Sweet Potato Fries", 
      description: 
        "Savory sweet potato fries with melted cheese, smoky bacon bits, and a dollop.", 
      imagePath: "lib/images/sides/loadedfried_side.jpeg", 
      price: 4.49, 
      category: FoodCategory.sides, 
      availableAddons: [
        Addon(name: "Sour Cream", price: 0.99),
        Addon(name: "Bacon Bits", price: 1.49),
        Addon(name: "Green Onions", price: 0.99),
      ],
    ),

     Food(
      name: "Croissants Bread", 
      description: 
        "Que dire? C'est des croissants.", 
      imagePath: "lib/images/sides/croissants_side.jpeg", 
      price: 4.49, 
      category: FoodCategory.sides, 
      availableAddons: [
        Addon(name: "Bacon Bits", price: 0.99),
        Addon(name: "Jalapeno Slices", price: 1.49),
        Addon(name: "Sriracha", price: 0.99),
      ],
    ),



    // desserts
     Food(
      name: "Biscoff", 
      description: 
        "Delicious like life.", 
      imagePath: "lib/images/desserts/biscoff_dessert.jpeg", 
      price: 3.99, 
      category: FoodCategory.desserts, 
      availableAddons: [
        Addon(name: "Strawberry Topping", price: 0.99),
        Addon(name: "Blueberry Compote", price: 1.49),
        Addon(name: "Chocolate Chips", price: 1.99),
      ],
    ),

       Food(
      name: "Custard cake", 
      description: 
        "Delicious like heaven.", 
      imagePath: "lib/images/desserts/custard_cake.jpeg", 
      price: 3.99, 
      category: FoodCategory.desserts, 
      availableAddons: [
        Addon(name: "Strawberry Topping", price: 0.99),
        Addon(name: "Blueberry Compote", price: 1.49),
        Addon(name: "Chocolate Chips", price: 1.99),
      ],
    ),

    Food(
      name: "Easy dessert", 
      description: 
        "Delicious like happiness.", 
      imagePath: "lib/images/desserts/easy_desserts.jpeg", 
      price: 3.99, 
      category: FoodCategory.desserts, 
      availableAddons: [
        Addon(name: "Caramel Sauce", price: 0.99),
        Addon(name: "Vanilla Ice Cream", price: 1.49),
        Addon(name: "Cinnamon Spice", price: 1.99),
      ],
    ),

    Food(
      name: "Oreo", 
      description: 
        "Delicious more than delicous.", 
      imagePath: "lib/images/desserts/oreo_desserts.jpeg", 
      price: 5.49, 
      category: FoodCategory.desserts, 
      availableAddons: [
        Addon(name: "Caramel Sauce", price: 0.99),
        Addon(name: "Vanilla Ice Cream", price: 1.49),
        Addon(name: "Cinnamon Spice", price: 1.99),
      ],
    ),

    Food(
      name: "Swiss dessert", 
      description: 
        "Just delicious.", 
      imagePath: "lib/images/desserts/swiss_desert.jpeg", 
      price: 2.99, 
      category: FoodCategory.desserts, 
      availableAddons: [
        Addon(name: "Strawberry Topping", price: 0.99),
        Addon(name: "Blueberry Compote", price: 4.49),
        Addon(name: "Chocolate Chips", price: 1.99),
      ],
    ),


    // drinks
    Food(
      name: "Lemonade", 
      description: 
        "Refreshing lemonade made real lemons and touch of sweetness.", 
      imagePath: "lib/images/drinks/fanta_citron.jpeg", 
      price: 3.99, 
      category: FoodCategory.drinks, 
      availableAddons: [
        Addon(name: "Strawberry Flavor", price: 0.99),
        Addon(name: "Mint Leaves", price: 1.49),
        Addon(name: "Ginger Zest", price: 1.99),
      ],
    ),

    Food(
      name: "Coca", 
      description: 
        "Refreshing Coca with a touch of sweetness.", 
      imagePath: "lib/images/drinks/coca.jpeg", 
      price: 3.99, 
      category: FoodCategory.drinks, 
      availableAddons: [
        Addon(name: "Peach Flavor", price: 0.99),
        Addon(name: "Lemon Slices", price: 1.49),
        Addon(name: "Honey", price: 1.99),
      ],
    ),

    Food(
      name: "Pepsi", 
      description: 
        "Refreshing Pepsi with a touch of sweetness.", 
      imagePath: "lib/images/drinks/pepsi.jpeg", 
      price: 3.99, 
      category: FoodCategory.drinks, 
      availableAddons: [
        Addon(name: "Protein Powder", price: 0.99),
        Addon(name: "Almond Milk", price: 1.49),
        Addon(name: "Chia Seeds", price: 1.99),
      ],
    ),

    Food(
      name: "Sprite", 
      description: 
        "Refreshing Sprite with a touch of sweetness.", 
      imagePath: "lib/images/drinks/pepsi.jpeg", 
      price: 3.99, 
      category: FoodCategory.drinks, 
      availableAddons: [
        Addon(name: "Extra Mint", price: 0.99),
        Addon(name: "Raspberry Puree", price: 1.49),
        Addon(name: "Splash of Coconut Rum", price: 1.99),
      ],
    ),

  ];

  /*

  G E T T E R S

  */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;

   /*

  O P E R A T I O N S
  */

  // user cart
  final List<CartItem> _cart = [];

  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are the same
      bool isSameFood  = item.food == food;

      // check if the list of selected addons are the same
      bool isSameAddons = 
          ListEquality().equals(item.selectedAddons, selectedAddons);
      return isSameFood && isSameAddons;
    });

    // if item already exists, increase it's quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }

    // otherwise, add a new cart item to the cart
    else {
      _cart.add(CartItem(
        food: food, 
        selectedAddons: selectedAddons,
      ),
    );
    }
    notifyListeners();
  }
  

  // remove from cart 
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }

    }

    notifyListeners();

  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart){
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity; 
    }
    return total;
  }

  // get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

   /*

  H E L P E R S
  */

  // generate a receipt


}