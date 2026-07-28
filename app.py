from flask import Flask, render_template, request, redirect, flash
import mysql.connector

app = Flask(__name__)
app.secret_key = "Secret should be SECRET"

# Database Connection
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Root_Password",
    database="student_course_registration"
)

cursor = db.cursor()

@app.route('/')
def home():

    cursor.execute("SELECT COUNT(*) FROM Department")
    departments_count = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Student")
    students_count = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Professor")
    professors_count = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Subject")
    subjects_count = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM Enrollment")
    enrollments_count = cursor.fetchone()[0]

    return render_template(
        "index.html",
        departments_count=departments_count,
        students_count=students_count,
        professors_count=professors_count,
        subjects_count=subjects_count,
        enrollments_count=enrollments_count
    )

@app.route('/students')
def students():

    cursor.execute("""
        SELECT usn, name, dept_id, sem,phone,email
        FROM Student
        ORDER BY dept_id, sem
    """)

    students = cursor.fetchall()

    return render_template(
        'students.html',
        students=students
    )

@app.route('/departments')
def departments():

    cursor.execute("""
        SELECT dept_id, dept_name
        FROM Department
        ORDER BY dept_id
    """)

    departments = cursor.fetchall()

    return render_template(
        'departments.html',
        departments=departments
    )

@app.route('/professors')
def professors():

    cursor.execute("""
        SELECT prof_id,
               prof_name,
               designation,
               phone,
               email,
               dept_id
        FROM Professor
        ORDER BY dept_id, prof_id
    """)

    professors = cursor.fetchall()

    return render_template(
        'professors.html',
        professors=professors
    )

@app.route('/subjects')
def subjects():

    cursor.execute("""
        SELECT sub_code,
               sub_name,
               credits,
               sem,
               dept_id,
               prof_id
        FROM Subject
        ORDER BY dept_id, sem, sub_code
    """)

    subjects = cursor.fetchall()

    return render_template(
        'subjects.html',
        subjects=subjects
    )

@app.route('/enrollments')
def enrollments():

    cursor.execute("""
        SELECT
            st.usn,
            st.name,
            sb.sub_name,
            e.enroll_date,
            e.status
        FROM Enrollment e
        JOIN Student st
            ON e.usn = st.usn
        JOIN Subject sb
            ON e.sub_code = sb.sub_code
        ORDER BY st.dept_id, st.sem
    """)

    enrollments = cursor.fetchall()

    return render_template(
        'enrollments.html',
        enrollments=enrollments
    )

@app.route('/add_student')
def add_student():
    return render_template('add_student.html')

@app.route('/add_student', methods=['POST'])
def insert_student():

    usn = request.form['usn']
    name = request.form['name']
    address = request.form['address']
    phone = request.form['phone']
    email = request.form['email']
    gender = request.form['gender']
    sem = request.form['sem']
    dept_id = request.form['dept_id']

    query = """
    INSERT INTO Student
    (usn, name, address, phone, email, gender, sem, dept_id)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """

    values = (
        usn,
        name,
        address,
        phone,
        email,
        gender,
        sem,
        dept_id
    )

    cursor.execute(query, values)
    db.commit()

    flash("Student added successfully!")

    return redirect('/students')

@app.route('/search_student')
def search_student():
    return render_template('search_student.html')

@app.route('/search_student', methods=['POST'])
def search_student_result():

    usn = request.form['usn']

    cursor.execute(
        "SELECT * FROM Student WHERE usn = %s",
        (usn,)
    )

    student = cursor.fetchone()

    return render_template(
        'search_student.html',
        student=student
    )

@app.route('/delete_student')
def delete_student():
    return render_template('delete_student.html')

@app.route('/delete_student', methods=['POST'])
def remove_student():

    usn = request.form['usn']

    cursor.execute(
        "SELECT * FROM Student WHERE usn=%s",
        (usn,)
    )

    student = cursor.fetchone()

    if student:

        cursor.execute(
            "DELETE FROM Student WHERE usn=%s",
            (usn,)
        )

        db.commit()

        flash("Student deleted successfully!")

        return redirect('/students')

    return render_template(
        'delete_student.html',
        message="Student not found"
    )

@app.route('/update_student')
def update_student():
    return render_template('update_student.html')

@app.route('/find_student', methods=['POST'])
def find_student():

    usn = request.form['usn']

    cursor.execute(
        "SELECT * FROM Student WHERE usn=%s",
        (usn,)
    )

    student = cursor.fetchone()

    return render_template(
        'update_student.html',
        student=student
    )

@app.route('/update_student_data', methods=['POST'])
def update_student_data():

    usn = request.form['usn']
    name = request.form['name']
    address = request.form['address']
    phone = request.form['phone']
    email = request.form['email']
    gender = request.form['gender']
    sem = request.form['sem']
    dept_id = request.form['dept_id']

    query = """
    UPDATE Student
    SET
        name=%s,
        address=%s,
        phone=%s,
        email=%s,
        gender=%s,
        sem=%s,
        dept_id=%s
    WHERE usn=%s
    """

    cursor.execute(
        query,
        (
            name,
            address,
            phone,
            email,
            gender,
            sem,
            dept_id,
            usn
        )
    )

    db.commit()

    flash("Student updated successfully!")

    return redirect('/students')

@app.route('/add_enrollment')
def add_enrollment():
    return render_template('add_enrollment.html')

@app.route('/find_enrollment_student', methods=['POST'])
def find_enrollment_student():

    usn = request.form['usn']

    cursor.execute(
        """
        SELECT usn, name, dept_id, sem
        FROM Student
        WHERE usn = %s
        """,
        (usn,)
    )

    student = cursor.fetchone()

    if not student:

        return render_template(
            'add_enrollment.html',
            message="Student not found"
        )

    cursor.execute(
        """
        SELECT sub_code, sub_name
        FROM Subject
        WHERE dept_id = %s
        AND sem = %s
        """,
        (student[2], student[3])
    )

    subjects = cursor.fetchall()

    return render_template(
        'add_enrollment.html',
        student=student,
        subjects=subjects
    )

@app.route('/enroll_student', methods=['POST'])
def enroll_student():

    usn = request.form['usn']
    sub_code = request.form['sub_code']
    status = request.form['status']

    try:

        query = """
        INSERT INTO Enrollment
        (usn, sub_code, status)
        VALUES (%s, %s, %s)
        """

        cursor.execute(
            query,
            (usn, sub_code, status)
        )

        db.commit()

        flash("Enrollment added successfully!")

        return redirect('/enrollments')

    except mysql.connector.Error as err:

        return render_template(
            'add_enrollment.html',
            message=str(err)
        )
    
@app.route('/search_enrollment')
def search_enrollment():
    return render_template('search_enrollment.html')

@app.route('/search_enrollment', methods=['POST'])
def search_enrollment_result():

    usn = request.form['usn']

    cursor.execute("""
        SELECT
            st.usn,
            st.name,
            sb.sub_name,
            e.enroll_date,
            e.status
        FROM Enrollment e
        JOIN Student st
            ON e.usn = st.usn
        JOIN Subject sb
            ON e.sub_code = sb.sub_code
        WHERE st.usn = %s
    """, (usn,))

    enrollments = cursor.fetchall()

    if not enrollments:

        return render_template(
            'search_enrollment.html',
            message="No enrollments found for this student"
        )

    return render_template(
        'search_enrollment.html',
        enrollments=enrollments
    )

@app.route('/update_enrollment')
def update_enrollment():
    return render_template('update_enrollment.html')

@app.route('/find_enrollment', methods=['POST'])
def find_enrollment():

    usn = request.form['usn']

    cursor.execute("""
        SELECT
            e.enroll_id,
            s.sub_name,
            e.status
        FROM Enrollment e
        JOIN Subject s
            ON e.sub_code = s.sub_code
        WHERE e.usn = %s
    """, (usn,))

    enrollments = cursor.fetchall()

    if not enrollments:

        return render_template(
            'update_enrollment.html',
            message="No enrollments found for this student"
        )

    return render_template(
        'update_enrollment.html',
        enrollments=enrollments
    )

@app.route('/update_enrollment_status', methods=['POST'])
def update_enrollment_status():

    enroll_id = request.form['enroll_id']
    status = request.form['status']

    cursor.execute("""
        UPDATE Enrollment
        SET status = %s
        WHERE enroll_id = %s
    """, (status, enroll_id))

    db.commit()

    flash("Enrollment status updated successfully!")

    return redirect('/enrollments')

@app.route('/delete_enrollment')
def delete_enrollment():
    return render_template(
        'delete_enrollment.html'
    )

@app.route('/find_enrollment_delete',
           methods=['POST'])
def find_enrollment_delete():

    usn = request.form['usn']

    cursor.execute("""
        SELECT
            e.enroll_id,
            s.sub_name,
            e.status
        FROM Enrollment e
        JOIN Subject s
            ON e.sub_code = s.sub_code
        WHERE e.usn = %s
    """, (usn,))

    enrollments = cursor.fetchall()

    if not enrollments:

        return render_template(
            'delete_enrollment.html',
            message="No enrollments found for this student"
        )

    return render_template(
        'delete_enrollment.html',
        enrollments=enrollments
    )

@app.route('/delete_enrollment_record',
           methods=['POST'])
def delete_enrollment_record():

    enroll_id = request.form['enroll_id']

    cursor.execute("""
        DELETE FROM Enrollment
        WHERE enroll_id = %s
    """, (enroll_id,))

    db.commit()

    flash("Enrollment deleted successfully!")

    return redirect('/enrollments')

@app.route('/add_subject')
def add_subject():

    cursor.execute("""
        SELECT dept_id, dept_name
        FROM Department
        ORDER BY dept_id
    """)

    departments = cursor.fetchall()

    return render_template(
        'add_subject.html',
        departments=departments
    )

@app.route('/select_professors',
           methods=['POST'])
def select_professors():

    sub_code = request.form['sub_code']
    sub_name = request.form['sub_name']
    sem = request.form['sem']
    dept_id = request.form['dept_id']
    credits = request.form['credits']

    cursor.execute("""
        SELECT prof_id,
               prof_name
        FROM Professor
        WHERE dept_id = %s
        ORDER BY prof_name
    """, (dept_id,))

    professors = cursor.fetchall()

    return render_template(
        'add_subject.html',

        professors=professors,

        sub_code=sub_code,
        sub_name=sub_name,
        sem=sem,
        dept_id=dept_id,
        credits=credits
    )

@app.route('/insert_subject',
           methods=['POST'])
def insert_subject():

    sub_code = request.form['sub_code']
    sub_name = request.form['sub_name']
    sem = request.form['sem']
    dept_id = request.form['dept_id']
    credits = request.form['credits']
    prof_id = request.form['prof_id']

    cursor.execute("""
        INSERT INTO Subject
        (
            sub_code,
            sub_name,
            credits,
            sem,
            dept_id,
            prof_id
        )
        VALUES
        (
            %s,
            %s,
            %s,
            %s,
            %s,
            %s
        )
    """,
    (
        sub_code,
        sub_name,
        credits,
        sem,
        dept_id,
        prof_id
    ))

    db.commit()

    flash("Subject added successfully!")

    return redirect('/subjects')

@app.route('/search_subject')
def search_subject():
    return render_template('search_subject.html')


@app.route('/search_subject', methods=['POST'])
def search_subject_result():

    sub_code = request.form['sub_code']

    cursor.execute("""
        SELECT
            s.sub_code,
            s.sub_name,
            s.credits,
            s.sem,
            s.dept_id,
            p.prof_name
        FROM Subject s
        JOIN Professor p
            ON s.prof_id = p.prof_id
        WHERE s.sub_code = %s
    """, (sub_code,))

    subject = cursor.fetchone()

    if not subject:

        return render_template(
            'search_subject.html',
            message="Subject not found"
        )

    return render_template(
        'search_subject.html',
        subject=subject
    )

@app.route('/update_subject')
def update_subject():
    return render_template('update_subject.html')


@app.route('/find_subject',
           methods=['POST'])
def find_subject():

    sub_code = request.form['sub_code']

    cursor.execute("""
        SELECT
            sub_code,
            sub_name,
            credits,
            sem
        FROM Subject
        WHERE sub_code=%s
    """, (sub_code,))

    subject = cursor.fetchone()

    return render_template(
        'update_subject.html',
        subject=subject
    )


@app.route('/update_subject_data',
           methods=['POST'])
def update_subject_data():

    cursor.execute("""
        UPDATE Subject
        SET
            sub_name=%s,
            credits=%s,
            sem=%s
        WHERE sub_code=%s
    """,
    (
        request.form['sub_name'],
        request.form['credits'],
        request.form['sem'],
        request.form['sub_code']
    ))

    db.commit()

    flash("Subject updated successfully!")

    return redirect('/subjects')

@app.route('/delete_subject')
def delete_subject():
    return render_template('delete_subject.html')


@app.route('/delete_subject',
           methods=['POST'])
def delete_subject_record():

    sub_code = request.form['sub_code']

    cursor.execute("""
        DELETE FROM Subject
        WHERE sub_code=%s
    """, (sub_code,))

    db.commit()

    flash("Subject deleted successfully!")

    return redirect('/subjects')

@app.route('/add_professor')
def add_professor():
    return render_template('add_professor.html')


@app.route('/add_professor',
           methods=['POST'])
def insert_professor():

    cursor.execute("""
        INSERT INTO Professor
        (
            prof_id,
            prof_name,
            designation,
            phone,
            email,
            dept_id
        )
        VALUES
        (
            %s,%s,%s,%s,%s,%s
        )
    """,
    (
        request.form['prof_id'],
        request.form['prof_name'],
        request.form['designation'],
        request.form['phone'],
        request.form['email'],
        request.form['dept_id']
    ))

    db.commit()

    flash("Professor added successfully!")

    return redirect('/professors')

@app.route('/search_professor')
def search_professor():
    return render_template('search_professor.html')


@app.route('/search_professor',
           methods=['POST'])
def search_professor_result():

    cursor.execute("""
        SELECT
        prof_id,
        prof_name,
        designation,
        phone,
        email,
        dept_id
    FROM Professor
    WHERE prof_id=%s
    """, (request.form['prof_id'],))

    professor = cursor.fetchone()

    return render_template(
        'search_professor.html',
        professor=professor
    )

@app.route('/update_professor')
def update_professor():
    return render_template('update_professor.html')


@app.route('/find_professor',
           methods=['POST'])
def find_professor():

    cursor.execute("""
        SELECT
            prof_id,
            prof_name,
            designation,
            phone,
            email
        FROM Professor
        WHERE prof_id=%s
    """, (request.form['prof_id'],))

    professor = cursor.fetchone()

    return render_template(
        'update_professor.html',
        professor=professor
    )


@app.route('/update_professor_data',
           methods=['POST'])
def update_professor_data():

    cursor.execute("""
        UPDATE Professor
        SET
            prof_name=%s,
            designation=%s,
            phone=%s,
            email=%s
        WHERE prof_id=%s
    """,
    (
        request.form['prof_name'],
        request.form['designation'],
        request.form['phone'],
        request.form['email'],
        request.form['prof_id']
    ))

    db.commit()

    flash("Professor updated successfully!")

    return redirect('/professors')

@app.route('/testdb')
def testdb():
    cursor.execute("SELECT COUNT(*) FROM Student")
    result = cursor.fetchone()

    return f"Total Students = {result[0]}"

if __name__ == '__main__':
    app.run(debug=True)