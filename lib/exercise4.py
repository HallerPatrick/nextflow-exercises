import sqlite3

from pathlib import Path


def create_table(sql_path, db_name):

    con = sqlite3.connect(db_name)
    
    with open(sql_path, "r") as f:
        sql_commands = f.readlines()

    cur = con.cursor()

    cur.execute('''CREATE TABLE part (id, name, manufacturer, brand, ad, integer, size, value, text)''')
    
    # Insert all data into db
    for line in sql_commands:
        cur.execute(line)

    con.commit()

    con.close()


def table_scan(sql_path, db_name="sample.db"):
    
    if not Path(db_name).exists():
        create_table(sql_path, db_name)
    
    con = sqlite3.connect(db_name)
    
    cur = con.cursor()

    for row in cur.execute("select manufacturer, sum(integer) from part group by manufacturer"):
        print(row)


