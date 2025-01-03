// 1. Create a collection named 'Customers'
db.createCollection("Customers");

// 2. Insert at least 5 values into the table
db.Customers.insert({cust_id: 1, Balance: 200, Type: "S"});
db.Customers.insert({cust_id: 1, Balance: 1000, Type: "Z"});
db.Customers.insert({cust_id: 2, Balance: 100, Type: "Z"});
db.Customers.insert({cust_id: 2, Balance: 1000, Type: "C"});
db.Customers.insert({cust_id: 2, Balance: 500, Type: "C"});
db.Customers.insert({cust_id: 2, Balance: 50, Type: "S"});
db.Customers.insert({cust_id: 3, Balance: 500, Type: "Z"});

// 3. Query to display records whose total account balance is greater than 1200 
// for account type 'Z' for each customer_id
db.Customers.aggregate([
  { $match: { Type: "Z" } },
  { $group: { _id: "$cust_id", TotAccBal: { $sum: "$Balance" } } },
  { $match: { TotAccBal: { $gt: 1200 } } }
]);

// 4. Determine Minimum and Maximum account balance for each customer_id
db.Customers.aggregate([
  { 
    $group: { 
      _id: "$cust_id", 
      minAccBal: { $min: "$Balance" }, 
      maxAccBal: { $max: "$Balance" }
    }
  }
]);

// 5. Drop the table
db.Customers.drop();
