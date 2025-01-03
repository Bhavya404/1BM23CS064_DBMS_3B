// Create the "Student" database and collection
db.createCollection("Student");

// Insert appropriate values
db.Student.insert({ RollNo: 1, Age: 21, Cont: 9876, email: "antara.de9@gmail.com" });
db.Student.insert({ RollNo: 2, Age: 22, Cont: 9976, email: "anushka.de9@gmail.com" });
db.Student.insert({ RollNo: 3, Age: 21, Cont: 5576, email: "anubhav.de9@gmail.com" });
db.Student.insert({ RollNo: 4, Age: 20, Cont: 4476, email: "pani.de9@gmail.com" });
db.Student.insert({ RollNo: 10, Age: 23, Cont: 2276, email: "rekha.de9@gmail.com" });

// Query to update the Email-Id of a student with rollno 10
db.Student.update({ RollNo: 10 }, { $set: { email: "Abhinav@gmail.com" } });

// Replace the student name from “ABC” to “FEM” of rollno 11
db.Student.insert({ RollNo: 11, Age: 22, Name: "ABC", Cont: 2276, email: "rea.de9@gmail.com" });
db.Student.update({ RollNo: 11, Name: "ABC" }, { $set: { Name: "FEM" } });

// Drop the collection
db.Student.drop();
