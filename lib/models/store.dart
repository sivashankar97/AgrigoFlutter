// class Store {
//   String itemName;
//   double itemPrice;
//   String itemImage;
//   String itemDesc;
//   Store.item({this.itemName, this.itemPrice, this.itemImage, this.itemDesc,});
// }

// List<Store> storeItems = [
  // Store.item(
  //     itemName: "Pepper",
  //     itemPrice: 200.00,
  //     itemImage: "images/pepper.png",
  //     itemDesc:
  //         "sksfksfsk placeholder (or filler) text.hdhd ihf2d siwd2dos ieww It's a convenient tool for mock-ups"),
  // Store.item(
  //     itemName: "Pepper",
  //     itemPrice: 200.00,
  //     itemImage: "images/broccoli.png",
  //     itemDesc:
  //         " holder (or frgrgrgrgriller) text. It's a convenient tool for mock-ups"),
  // Store.item(
  //     itemName: "Pepper",
  //     itemPrice: 200.00,
  //     itemImage: "images/kale.png",
  //     itemDesc:
  //         "pographyto emphasise design elements over content. It's also called placeholder (or filler) text. It's a convenient tool for mock-ups"),
  // Store.item(
  //     itemName: "Pepper",
  //     itemPrice: 200.00,
  //     itemImage: "images/pepper.png",
  //     itemDesc:
  //         "yout, and printing in place of English to emphasise dents over content. It's also called placeholder (or filler) text. It's a convenient tool for mock-ups"),
// ];
class Product {
  String pName;
  String pPrice;
  String pLocation;
  String pDescription;
  String pCategory;
  String pId;
  int pQuantity;
  Product(
      {this.pQuantity,
      this.pId,
      this.pName,
      this.pCategory,
      this.pDescription,
      this.pLocation,
      this.pPrice});
}
