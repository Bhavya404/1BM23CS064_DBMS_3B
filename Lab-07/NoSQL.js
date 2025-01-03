// 1. Create the collection "restaurants" (if not already created)
db.createCollection("restaurants");

// 2. Insert multiple restaurant documents into the collection
db.restaurants.insertMany([
  { 
    name: "Meghna Foods", 
    town: "Jayanagar", 
    cuisine: "Indian", 
    score: 8, 
    address: { 
      zipcode: "10001", 
      street: "Jayanagar" 
    } 
  },
  { 
    name: "Empire", 
    town: "MG Road", 
    cuisine: "Indian", 
    score: 7, 
    address: { 
      zipcode: "10100", 
      street: "MG Road" 
    } 
  },
  { 
    name: "Chinese WOK", 
    town: "Indiranagar", 
    cuisine: "Chinese", 
    score: 12, 
    address: { 
      zipcode: "20000", 
      street: "Indiranagar" 
    } 
  },
  { 
    name: "Kyotos", 
    town: "Majestic", 
    cuisine: "Japanese", 
    score: 9, 
    address: { 
      zipcode: "10300", 
      street: "Majestic" 
    } 
  },
  { 
    name: "WOW Momos", 
    town: "Malleshwaram", 
    cuisine: "Indian", 
    score: 5, 
    address: { 
      zipcode: "10400", 
      street: "Malleshwaram" 
    } 
  }
]);

// 3. Display all documents in the 'restaurants' collection
db.restaurants.find({});

// 4. Arrange restaurant names in descending order along with all columns
db.restaurants.find({}).sort({ name: -1 });

// 5. Find the restaurant Id, name, town, and cuisine for those with a score <= 10
db.restaurants.find({ "score": { $lte: 10 } }, { _id: 1, name: 1, town: 1, cuisine: 1 });

// 6. Find the average score for each restaurant
db.restaurants.aggregate([
  { 
    $group: { 
      _id: "$name", 
      average_score: { $avg: "$score" } 
    } 
  }
]);

// 7. Find the name and address of restaurants with a zipcode starting with '10'
db.restaurants.find({ "address.zipcode": /^10/ }, { name: 1, "address.street": 1, _id: 0 });
