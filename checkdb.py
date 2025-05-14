import sqlite3

conn = sqlite3.connect('db.sqlite3')
cursor = conn.cursor()

table_name = "sqlite_sequence"
# cursor.execute(f"SELECT * FROM {table_name};")
# tables = cursor.fetchall()
# print("Tables:", tables)

cursor.execute(f"PRAGMA table_info({table_name});")
columns = cursor.fetchall()

print(f"Fields in table '{table_name}':")
for col in columns:
    print(f"- {col[1]} ({col[2]})")  # col[1] = column name, col[2] = type


conn.close()
