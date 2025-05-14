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

# auth_group                  django_session            
# auth_group_permissions      management_book           
# auth_permission             management_book_genre     
# auth_user                   management_borrower       
# auth_user_groups            management_genre          
# auth_user_user_permissions  management_language       
# django_admin_log            management_reviews        
# django_content_type         management_student        
# django_migrations  

conn.close()
