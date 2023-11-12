import sys
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QLineEdit, QVBoxLayout, QHBoxLayout, QPushButton, QListWidget
from PyQt5.QtSql import QSqlDatabase, QSqlQuery

class CafeManagementApp(QWidget):
    def __init__(self):
        super().__init__()

        self.init_ui()
        self.create_database()

    def init_ui(self):
        self.setWindowTitle('Cafe Management App')
        self.setGeometry(100, 100, 400, 300)

        self.name_label = QLabel('Name:')
        self.name_entry = QLineEdit(self)

        self.position_label = QLabel('Position:')
        self.position_entry = QLineEdit(self)

        self.add_button = QPushButton('Add Employee')
        self.employee_list = QListWidget(self)

        layout = QVBoxLayout()
        form_layout = QHBoxLayout()
        form_layout.addWidget(self.name_label)
        form_layout.addWidget(self.name_entry)
        form_layout.addWidget(self.position_label)
        form_layout.addWidget(self.position_entry)

        layout.addLayout(form_layout)
        layout.addWidget(self.add_button)
        layout.addWidget(self.employee_list)

        self.setLayout(layout)

        self.add_button.clicked.connect(self.add_employee)
        self.load_employees()

        self.show()

    def create_database(self):
        db = QSqlDatabase.addDatabase("QSQLITE")
        db.setDatabaseName("cafe.db")

        if not db.open():
            print("Cannot open database")
            return False

        query = QSqlQuery()
        query.exec_("CREATE TABLE IF NOT EXISTS employees (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, position TEXT)")

    def add_employee(self):
        name = self.name_entry.text()
        position = self.position_entry.text()

        query = QSqlQuery()
        query.prepare("INSERT INTO employees (name, position) VALUES (?, ?)")
        query.addBindValue(name)
        query.addBindValue(position)

        if query.exec_():
            print("Employee added successfully.")
            self.load_employees()
        else:
            print("Error adding employee.")

    def load_employees(self):
        self.employee_list.clear()

        query = QSqlQuery("SELECT name, position FROM employees")
        while query.next():
            name = query.value(0)
            position = query.value(1)
            item = f"{name} - {position}"
            self.employee_list.addItem(item)

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = CafeManagementApp()
    sys.exit(app.exec_())
