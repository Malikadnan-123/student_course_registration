# 🎓 Student Course Registration System

A web-based Student Course Registration System developed using **Flask**, **MySQL**, **HTML**, and **CSS**. The system allows administrators to manage students, professors, subjects, departments, and course enrollments through an easy-to-use interface.

---

## 📌 Features

### Student Management
- Add new students
- View all students
- Update student details
- Delete student records
- Search students

### Professor Management
- Add professors
- View professor records
- Update professor details
- Delete professors
- Search professors

### Subject Management
- Add subjects
- View subjects
- Update subject details
- Delete subjects
- Search subjects

### Department Management
- View department information

### Enrollment Management
- Enroll students in courses
- Update enrollment records
- Delete enrollments
- Search enrollments
- View all enrollments

---

## 🛠️ Technologies Used

- **Backend:** Flask (Python)
- **Database:** MySQL
- **Frontend:** HTML, CSS
- **Database Concepts:** Views, Triggers, Stored Procedures

---

## 🗄️ Database Features

### Trigger
A database trigger is used to prevent duplicate enrollments and maintain data integrity.

### View
Database views are used to simplify complex queries and provide structured data retrieval.

### Stored Procedure
Stored procedures are used to perform database operations efficiently and reduce query repetition.

---

## 📂 Project Structure

```text
Student-Course-Registration-System/
│
├── app.py
├── README.md
│
├── Database/
│   └── database.sql
│
├── Static/
│   └── style.css
│
└── Templates/
    ├── index.html
    ├── students.html
    ├── professors.html
    ├── subjects.html
    ├── departments.html
    ├── enrollments.html
    ├── add_student.html
    ├── update_student.html
    ├── delete_student.html
    └── ...
```

---

## ⚙️ Installation and Setup

### 1. Clone the Repository

```bash
git clone https://github.com/Abhinav-Ind/Student-Course-Registration-System.git
```

### 2. Navigate to the Project Directory

```bash
cd Student-Course-Registration-System
```

### 3. Install Required Packages

```bash
pip install flask mysql-connector-python
```

### 4. Create the Database

- Open MySQL.
- Import the `database.sql` file located inside the `Database` folder.
- Create the required database schema.

### 5. Configure Database Connection

Update the database credentials in `app.py`:

```python
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="YOUR_PASSWORD",
    database="YOUR_DATABASE_NAME"
)
```

### 6. Run the Application

```bash
python app.py
```

### 7. Open in Browser

```text
http://127.0.0.1:5000
```

---

---

## 🎯 Learning Outcomes

This project demonstrates:

- Database Design
- CRUD Operations
- Flask Web Development
- MySQL Integration
- Triggers
- Views
- Stored Procedures
- Frontend-Backend Integration

---

## 👨‍💻 Author

**Abhinav Kumar**

GitHub: https://github.com/Abhinav-Ind

---

## 📄 License

This project is created for educational and academic purposes.