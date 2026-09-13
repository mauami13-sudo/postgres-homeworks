import csv
import psycopg2

conn_params = {
    "host": "localhost",
    "database": "north",
    "user": "postgres",
    "password": "12345",
    "client_encoding":" utf8"
}

with psycopg2.connect(**conn_params) as conn:
    with conn.cursor() as cur:

        #employees
        with open("employees_data.csv", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for row in reader:
                cur.execute(
                    "INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)",
                    (row["employee_id"], row["first_name"], row["last_name"],
                     row["title"], row["birth_date"], row["notes"])
                )

        #customers
        with open("customers_data.csv", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for row in reader:
                cur.execute(
                    "INSERT INTO customers VALUES (%s, %s, %s)",
                    (row["customer_id"], row["company_name"], row["contact_name"])
                )

        #orders 
        with open("orders_data.csv", encoding="utf-8") as f:
            reader = csv.DictReader(f)
            for row in reader:
                cur.execute(
                    "INSERT INTO orders VALUES (%s, %s, %s, %s, %s)",
                    (row["order_id"], row["customer_id"], row["employee_id"],
                     row["order_date"], row["ship_city"])
                )

        # проверка
        cur.execute("SELECT * FROM orders LIMIT 5")
        for row in cur.fetchall():
            print(row)
