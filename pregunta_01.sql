-- 
--  La tabla `tbl1` tiene la siguiente estructura:
-- 
--    K0  CHAR(1)
--    K1  INT
--    c12 FLOAT
--    c13 INT
--    c14 DATE
--    c15 FLOAT
--    c16 CHAR(4)
--
--  Escriba una consulta en SQL que devuelva la suma del campo c12.
-- 
--  Rta/
--     SUM(c12)
--  0  15137.63
--
--  >>> Escriba su codigo a partir de este punto <<<
--SELECT SUM(c12) FROM tbl1.csv
import sqlite3

conn = sqlite3.connect(":memory:")
cur = conn.cursor()
conn.executescript(
    """
DROP TABLE IF EXISTS tbl1;

CREATE TABLE tbl1 (
    K0  CHAR(1),
    K1  INT,
    c12 FLOAT,
    c13 INT,
    c14 DATE,
    c15 FLOAT,
    c16 CHAR(4)
    );
"""
)
conn.commit()

with open("tbl1.csv", "rt") as f:
    data = f.readlines()

data

# Separa los campos por comas
data = [line.split(",") for line in data]

# Convierte la fila en una tupla
data = [tuple(line) for line in data]

cur.executemany("INSERT INTO tbl1 VALUES (?,?,?,?,?,?,?)", data)

cur.execute("SELECT SUM(c12) FROM tbl1").fetchall()[0][0]
